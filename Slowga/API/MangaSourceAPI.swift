//
//  MangaSourceAPI.swift
//  Slowga
//
//  Created by Deshun Cai on 10/10/18.
//  Copyright © 2018 Unusep Productions. All rights reserved.
//

import Foundation

struct MangaCoverRaw {
    let title: String?
    let imageUrl: String?
    let id: String?
    let hits: Int?
}

struct MangaInfoRaw {
    
}

struct MangaChapterRaw {
    
}

struct MangaPageRaw {
    
}

protocol MangaSourceAPI {
    func getMangaList(onComplete callback: @escaping (([MangaCoverRaw]) -> Void))
    func getMangaInformation(for mangaId: String, onComplete callback: @escaping ((MangaInfoRaw) -> Void))
    func getChapterInformation(for chapter: Int, of mangaId: String, onComplete callback: @escaping ((MangaChapterRaw) -> Void))
    func getPage(page: Int, for chapter: Int, of mangaId: String, onComplete callback: @escaping ((MangaPageRaw) -> Void))
}
