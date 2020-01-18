//
//  MaticNetworkTests.swift
//  MaticNetworkTests
//
//  Created by kashee kushwaha on 17/01/20.
//  Copyright © 2020 kashee kushwaha. All rights reserved.
//

import XCTest
@testable import MaticNetwork

class MaticNetworkTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testArticleViewModelAuthor() {
        let article = Article(source: Source(id: "123", name: "BBC News"), author: "BBC", title: "Indian Economy", description: "Details description about indian economy", url: "", urlToImage: "", publishedAt: "18-01-2020", content: "Some content about indian economy")
        
        let articleViewModel = ArticleViewModel(article: article)
        
        
        // Here test case will fail because local author value is not same as be pass author in ArticleViewModel
//        let author = "BBC New"
//        XCTAssertEqual(author, articleViewModel.author)
        
        
        // Here test case will pass because local author value is same as be pass author in ArticleViewModel
        let author = "BBC"
        XCTAssertEqual(author, articleViewModel.author)
    }

}
