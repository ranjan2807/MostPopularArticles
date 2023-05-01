//
//  MostPopularArticlesRepositoryTests.swift
//  ArticlesTestTests
//
//  Created by Ranjan Patra on 01/05/23.
//

import XCTest
@testable import ArticlesTest

final class MostPopularArticlesRepositoryTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after
        // the invocation of each test method in the class.
    }

    func testMostPopularArticlesFetchValidDataSuccess() {
        let repo = MostPopularArticlesRepository()
        
        let expectation = XCTestExpectation(description: "load-invalid-url-error")
        
        var articleList: [ArticleModel] = []
        repo.fetch { _, articles, _ in
            articleList = articles ?? []
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
        
        XCTAssertGreaterThan(articleList.count, 1, "Something went wrong")
    }
    
    func testMostPopularArticlesFetchFailedWithError() {
        let repo = MostPopularArticlesRepository()
        
        let expectation = XCTestExpectation(description: "load-invalid-url-error")
        
        var articleList: [ArticleModel] = []
        repo.fetchList(with: "https://www.google.co.in") { _, articles, _ in
            articleList = articles ?? []
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
        
        XCTAssertLessThan(articleList.count, 1, "Something went wrong")
    }
    
    func testMostPopularArticlesFetchFailedWithEmptyUrl() {
        let repo = MostPopularArticlesRepository()
        
        let expectation = XCTestExpectation(description: "load-invalid-url-error")
        
        var articleList: [ArticleModel] = []
        repo.fetchList(with: "") { _, articles, _ in
            articleList = articles ?? []
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
        
        XCTAssertLessThan(articleList.count, 1, "Something went wrong")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
