//
//  Manga.swift
//  Slowga
//
//  Created by Deshun Cai on 9/10/18.
//  Copyright © 2018 Unusep Productions. All rights reserved.
//

import UIKit

struct Manga {
    let status: String?
    let categories: [String]
    var lastChapterDate: Int
    
    let cover: MangaCover
    let slug: String
    let author: String
    var releasedYear: Int?
    let plot: String
    
    let chapters: [MangaChapter]
}
