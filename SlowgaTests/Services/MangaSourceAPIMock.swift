//
//  MangaSourceAPIStub.swift
//  SlowgaTests
//
//  Created by Deshun Cai on 12/10/18.
//  Copyright © 2018 Unusep Productions. All rights reserved.
//

import Foundation

class MangaSourceAPIMock: MangaSourceAPI {
    func getMangaList(onComplete callback: @escaping (([MangaCoverRaw]) -> Void)) {
        let manga = MangaCoverRaw(
            title: "title", imageUrl: "imageUrl", id: "id"
        )
        callback([manga])
    }
    
    func getMangaInformation(for mangaId: String, onComplete callback: @escaping ((MangaInfoRaw) -> Void)) {
        
    }
    
    func getChapterInformation(for chapter: Int, of mangaId: String, onComplete callback: @escaping ((MangaChapterRaw) -> Void)) {
        
    }
    
    func getPage(page: Int, for chapter: Int, of mangaId: String, onComplete callback: @escaping ((MangaPageRaw) -> Void)) {
        
    }
    
    
}
