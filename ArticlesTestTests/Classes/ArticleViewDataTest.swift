//
//  ArticleViewDataTest.swift
//  ArticlesTestTests
//
//  Created by Ranjan Patra on 01/05/23.
//

import XCTest
@testable import ArticlesTest

final class ArticleViewDataTest: XCTestCase {
    
    var articleListValid: [ArticleModel]?
    var articleListInValid: [ArticleModel]?
    
    func buildValidJson() -> [ArticleModel]? {
        
        if let url = Bundle(for: ArticleViewDataTest.self)
            .url(forResource: "articlesResponse", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([ArticleModel].self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
    
    func buildInValidJson() -> [ArticleModel]? {
        
        if let url = Bundle(for: ArticleViewDataTest.self)
            .url(forResource: "articleWithNullFeilds", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([ArticleModel].self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        articleListValid = buildValidJson()
        articleListInValid = buildInValidJson()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        articleListValid = nil
        articleListInValid = nil
    }
    
    func testValidFeildsArticleViewData() {
        let viewData = ArticleViewData(articleRaw: (articleListValid?.first)!)
        
        XCTAssertNotNil(viewData.title)
        XCTAssertNotNil(viewData.thumbnailURL)
        XCTAssertNotNil(viewData.id)
        XCTAssertNotNil(viewData.authors)
        XCTAssertNotNil(viewData.keywords)
        XCTAssertNotNil(viewData.facet)
        XCTAssertNotNil(viewData.publishedDate)
        XCTAssertNotNil(viewData.caption)
        XCTAssertNotNil(viewData.abstract)
        XCTAssertNotNil(viewData.htmlURL)
        XCTAssertNotNil(viewData.imageURL)
        
        XCTAssertTrue(viewData.contains(searchText: "the"))
        XCTAssertTrue(viewData.contains(searchText: "Carlson"))
        XCTAssertFalse(viewData.contains(searchText: "Glenn Thrush"))
    }
    
    func testInValidFeildsArticleViewData() {
        let viewData = ArticleViewData(articleRaw: (articleListInValid?.first)!)
        
        XCTAssertEqual(viewData.title, "")
        XCTAssertNil(viewData.thumbnailURL)
        XCTAssertEqual(viewData.id, "")
        XCTAssertEqual(viewData.authors, "")
        XCTAssertEqual(viewData.keywords, "")
        XCTAssertEqual(viewData.facet, "")
        XCTAssertEqual(viewData.publishedDate, "")
        XCTAssertEqual(viewData.caption, "")
        XCTAssertEqual(viewData.abstract, "")
        XCTAssertNil(viewData.htmlURL)
        XCTAssertNil(viewData.imageURL)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
