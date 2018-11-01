//
//  MangaSearchService.swift
//  Slowga
//
//  Created by Deshun Cai on 10/10/18.
//  Copyright © 2018 Unusep Productions. All rights reserved.
//

import Foundation
import CoreData
import os.log


typealias ImageFilePath = String

class MangaRetrievalService {
    var source: MangaSourceAPI
    var context: NSManagedObjectContext
    
    init(source: MangaSourceAPI, context: NSManagedObjectContext) {
        self.source = source
        self.context = context
    }
    
    // retrieves cover image
    // calls callback with the name of the file
    // downloads and saves if not already downloaded
    public func getCoverImage(for mangaCover: MangaCover, onComplete callback: @escaping ((ImageFilePath?) -> Void)) {
        // use cached manga cover if already donwloaded
        if mangaCover.isImageDownloaded {
            os_log("Image path already stored", type: .debug)
            callback(mangaCover.getLocalImageFilePath())
            return
        }
        
        // otherwise, attempt to download the image
        guard let imageUrl = mangaCover.imageUrl, let url = URL(string: imageUrl) else {
            os_log("This manga does not have a valid image url", type: .debug)
            callback(nil)
            return
        }
        URLSession.shared.downloadTask(with: url) { (location: URL?, response: URLResponse?, error: Error?) in
            if error != nil {
                // TODO: handle errors
                os_log("%@", type: .error, error!.localizedDescription)
                callback(nil)
                return
            }
            guard
                let contentLength = response?.expectedContentLength, contentLength > 0,
                let statusCode = (response as? HTTPURLResponse)?.statusCode,
                200 <= statusCode, statusCode < 300
                else {
                // TODO: handle errors
                    os_log("Failed to download. Either content length is 0 or http response is not within acceptable range.", type: .debug)
                callback(nil)
                return
            }
            guard
                let tempLocation = location,
                let localFilePath = mangaCover.getLocalImageFilePath()
                else {
                    // TODO: handle errors
                    os_log("Failed to get valid URL from mangaCover image file path", type: .debug)
                    callback(nil)
                    return
            }
            
            // successfully downloaded
            do {
                let localFileURL = URL(fileURLWithPath: localFilePath)
                let parentDirectory = localFileURL.deletingLastPathComponent()
                if !FileManager.default.fileExists(atPath: parentDirectory.path) {
                    try FileManager.default.createDirectory(at: parentDirectory, withIntermediateDirectories: true, attributes: nil)
                }
                try FileManager.default.moveItem(at: tempLocation, to: localFileURL)
                mangaCover.isImageDownloaded = true
                callback(localFilePath)
            } catch let e {
                // TODO: handle errors
                callback(nil)
                os_log("%@", type: .error, e.localizedDescription)
            }
        }.resume()
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
                    mangaCover.hits = Int64(mcr.hits ?? 0)
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
