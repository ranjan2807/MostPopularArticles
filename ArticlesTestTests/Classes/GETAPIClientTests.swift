//
//  GETAPIClientTests.swift
//  ArticlesTestTests
//
//  Created by Ranjan Patra on 01/05/23.
//

import XCTest
@testable import ArticlesTest

final class GETAPIClientTests: XCTestCase {
    
    var validURLForData: String?
    var validURLForError: String?
    var emptyURL: String?
    var corruptBaseUrl: String?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        validURLForData = "http://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/7.json?" +
        "api-key=d5pYXZSQRZjf3K8AmEAbBzDMAE9Ia2MI"
        validURLForError = "http://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/7.json?api-key="
        emptyURL = ""
        corruptBaseUrl = "http://api.nyzztimes.com/svc/mostpopular/v2/mostviewed/all-sections/7.json?"
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after
        // the invocation of each test method in the class.
        validURLForData = nil
        validURLForError = nil
        emptyURL = nil
        corruptBaseUrl = nil
    }

    func testAPICallwithValidURLWithValidData () {
        let apiClient = GETAPIClient(urlString: validURLForData!)
        
        let expectation = XCTestExpectation(description: "load-valid-url-data")
        
        var dataFetched: Data?
        apiClient.getList { (_, data, _) in
            dataFetched = data
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
        
        XCTAssertNotNil(dataFetched, "API response  is taking too long.")
    }
    
    func testAPICallwithValidURLWithInValidData () {
        let apiClient = GETAPIClient(urlString: validURLForError!)
        
        let expectation = XCTestExpectation(description: "load-invalid-url-error")
        
        var error: AppError?
        apiClient.getList { (_, _, err) in
            error = err
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
        
        XCTAssertNotNil(error, "Error not found")
    }
    
    func testAPICallwithEmptyUrl () {
        let apiClient = GETAPIClient(urlString: emptyURL!)
        
        let expectation = XCTestExpectation(description: "load-valid-empty-url")
        
        var error: AppError?
        apiClient.getList { (_, _, err) in
            error = err
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
        
        XCTAssertNotNil(error, "Error not found")
    }
    
    func testAPICallwithCorruptBaseUrl () {
        let apiClient = GETAPIClient(urlString: corruptBaseUrl!)
        
        let expectation = XCTestExpectation(description: "load-corrupt-base-url")
        
        var error: AppError?
        apiClient.getList { (_, _, err) in
            error = err
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
        
        XCTAssertNotNil(error, "Error not found")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
