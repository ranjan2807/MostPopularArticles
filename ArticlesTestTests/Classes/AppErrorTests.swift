//
//  AppErrorTests.swift
//  ArticlesTestTests
//
//  Created by Ranjan Patra on 02/05/23.
//

import XCTest
@testable import ArticlesTest

final class AppErrorTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after
        // the invocation of each test method in the class.
    }

    func testAppError() {
        XCTAssertNotNil(AppError.noDataFound)
        XCTAssertNotNil(AppError.error(nil))
        XCTAssertNotNil(AppError.noNetwork)
        XCTAssertNotNil(AppError.parseError("Error parsing data"))
        XCTAssertNotNil(AppError.parseError(nil))
        XCTAssertNotNil(AppError.generic)
        XCTAssertNotNil(AppError.invalidURL)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
