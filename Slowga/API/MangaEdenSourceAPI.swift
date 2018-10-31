//
//  MangaEdenSourceAPI.swift
//  Slowga
//
//  Created by Deshun Cai on 10/10/18.
//  Copyright © 2018 Unusep Productions. All rights reserved.
//

import Foundation
import Alamofire


class MangaEdenSourceAPI: MangaSourceAPI {
    
    let baseUrl: String = "https://www.mangaeden.com/api/"
    let baseImageUrl: String = "https://cdn.mangaeden.com/mangasimg/"
    
    func getMangaList(onComplete callback: @escaping (([MangaCoverRaw]) -> Void)) {
        let path = baseUrl + "/list/0/"
        Alamofire.request(path).responseJSON { (response) in
            switch response.result {
            case .success:
                if let json = response.result.value as? [String: Any] {
                    let mangaJsonList = json["manga"] as! [[String: Any]]
                    let mangaCovers = mangaJsonList.map { (mangaJson) -> MangaCoverRaw in
                        let title = mangaJson["t"] as? String
                        let imageUrl = mangaJson["im"] as? String
                        let id = mangaJson["i"] as? String
                        let hits = mangaJson["h"] as? Int

                        return MangaCoverRaw(
                            title: title,
                            imageUrl: imageUrl.map({ (url) -> String in
                                self.baseImageUrl + url
                            }),
                            id: id,
                            hits: hits
                        )
                    }
                    callback(mangaCovers)
                }
            case .failure(_): break
            }
        }
    }
    
    func getMangaInformation(for mangaId: String, onComplete callback: @escaping ((MangaInfoRaw) -> Void)) {
        
    }
    
    func getChapterInformation(for chapter: Int, of mangaId: String, onComplete callback: @escaping ((MangaChapterRaw) -> Void)) {
        
    }
    
    func getPage(page: Int, for chapter: Int, of mangaId: String, onComplete callback: @escaping ((MangaPageRaw) -> Void)) {
        
    }
    
}
