//
//  MangaRetrievalServiceTest.swift
//  SlowgaTests
//
//  Created by Deshun Cai on 12/10/18.
//  Copyright © 2018 Unusep Productions. All rights reserved.
//

import XCTest
import CoreData

class MangaRetrievalServiceTest: XCTestCase {
    
    override func setUp() {
    }

    override func tearDown() {

    }

    func testUpdatesAtLeastOneManga() {
        
        let source = MangaSourceAPIMock()
        let context = CoreDataMock.shared.mockPersistantContainer.viewContext
        let mangaRetrievalService = MangaRetrievalService(
            source: source, context: context
        )
        
        let expectation = self.expectation(description: "Updates manga list")
        
        mangaRetrievalService.updateMangaList { (mangaCovers) in
            XCTAssert(mangaCovers.count > 0)
            let request: NSFetchRequest<MangaCover> = MangaCover.fetchRequest()
            let objs = try! context.fetch(request)
            XCTAssert(objs.count > 0)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
        
        let request: NSFetchRequest<MangaCover> = MangaCover.fetchRequest()
        let objs = try! context.fetch(request)
        for case let obj as NSManagedObject in objs {
            context.delete(obj)
        }
        try! context.save()
    }


}
