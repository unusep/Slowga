//
//  MangaEdenSourceAPITest.swift
//  SlowgaTests
//
//  Created by Deshun Cai on 10/10/18.
//  Copyright © 2018 Unusep Productions. All rights reserved.
//

import XCTest

class MangaEdenSourceAPITest: XCTestCase {
    let api = MangaEdenSourceAPI()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCanRetrieveAllMangas() {
        let expectation = self.expectation(description: "Returns manga covers")
        var mc: [MangaCoverRaw]? = nil
        api.getMangaList { (mangaCovers) in
            mc = mangaCovers
            XCTAssertNotNil(mc)
            XCTAssert(mc!.count > 0)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testCanSearchForManga() {
        let expectation = self.expectation(description: "Can search for one piece")
        var mc: [MangaCoverRaw]? = nil
        api.search(for: "One Piece") { (mangaCovers) in
            mc = mangaCovers
            XCTAssertNotNil(mc)
            XCTAssert(mc!.count > 0)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
