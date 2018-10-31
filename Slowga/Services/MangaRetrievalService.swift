//
//  MangaSearchService.swift
//  Slowga
//
//  Created by Deshun Cai on 10/10/18.
//  Copyright © 2018 Unusep Productions. All rights reserved.
//

import Foundation
import CoreData
import Alamofire


class MangaRetrievalService {
    var source: MangaSourceAPI
    var context: NSManagedObjectContext
    
    init(source: MangaSourceAPI, context: NSManagedObjectContext) {
        self.source = source
        self.context = context
    }
    
    // retrieves cover image.
    // downloads and saves if not already downloaded
    public func getCoverImage(for mangaCover: MangaCover, onComplete callback: @escaping ((String?) -> Void)) {
        if let imagePath = mangaCover.imageFilePath {
            callback(imagePath)
        } else {
            // we have not already downloaded the manga cover.
            // download it and save the mangacover
            if let imageUrl = mangaCover.imageUrl {
                let destination: DownloadRequest.DownloadFileDestination = { _, _ in
                    let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                    let fileURL = documentsURL.appendingPathComponent(imageUrl)
                    
                    return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
                }
                Alamofire.download(imageUrl, to: destination).response { response in
                    if response.error == nil, let imagePath = response.destinationURL?.path {
                        // successfully downloaded. update image path and save
                        mangaCover.imageIsDownloaded = true
                        DispatchQueue.main.async {
                            do {
                                try self.context.save()
                            } catch _ {
                                // TODO handle error if we cannot save
                            }
                        }
                        callback(imagePath)
                    } else {
                        callback(nil)
                    }
                }
            } else {
                // manga cover does not have an image url.
                // TODO: try to update manga cover
                callback(nil)
            }
        }
    }
    
    public func search(for term: String?, onComplete callback: (([MangaCover]) -> Void)) {
        if let term = term {
            let request: NSFetchRequest<MangaCover> = MangaCover.fetchRequest()
            
            let predicateContainsTerm = NSPredicate(format: "title CONTAINS[cd] %@", term)
            // filter for covers with images
            let predicateHasImage = NSPredicate(format: "imageUrl != nil")
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicateHasImage, predicateContainsTerm])
            
            let sort = NSSortDescriptor(key: #keyPath(MangaCover.hits), ascending: false)
            request.sortDescriptors = [sort]
            do {
                let mangaCovers = try context.fetch(request)
                callback(mangaCovers)
            } catch _ {
                // TODO: handle the error if we cannot retrieve stuff
            }
        } else {
            callback([])
        }
    }
    
    /// Updates the manga list in the core data context using the source
    ///
    /// - Parameter callback: an optional callback that is called with the updated MangaCovers
    public func updateMangaList(onComplete callback: (([MangaCover]) -> Void)? = nil) {
        // do not retrieve data if already exists on core data
        let request: NSFetchRequest<MangaCover> = MangaCover.fetchRequest()
        if let count = try? context.count(for: request), count > 0 {
            return;
        }
        
        // otherwise, retrieve and store
        source.getMangaList { (mangaCoverRaws) in
            DispatchQueue.main.async {
                let mangaCovers = mangaCoverRaws.map { (mcr) -> MangaCover in
                    let mangaCover: MangaCover = MangaCover(context: self.context)
                    mangaCover.id = mcr.id
                    mangaCover.imageUrl = mcr.imageUrl
                    mangaCover.title = mcr.title
                    return mangaCover
                }
                do {
                    try self.context.save()
                } catch _ {
                    // TODO: handle the error if we cannot save this
                }
                callback?(mangaCovers)
            }
        }
    }
    
    public func getMangaInformation(for mangaId: String, onComplete callback: ((Manga) -> Void)) {
        
    }
    
    public func getChapterInformation(for chapter: Int, of mangaId: String, onComplete callback: ((MangaChapter) -> Void)) {
        
    }
}
