//
//  UtilitiesTestCase.swift
//  RecipleaseTests
//
//  Created by Laurent Debeaujon on 11/11/2020.
//

import Foundation
import XCTest
@testable import Pods_Reciplease

class UtilitiesTestCase: XCTestCase {

    // MARK: - test getValueForAPIKey
    func testGivenAPINameWhenNameIsNotNullThenReturnKey() {
        let result = Utilities.getValueForAPIKey(named: "API_ADAMAM")
        // Then
        XCTAssertNotNil(result)
    }
    func testGivenAPINameWhenNameIsNotKnownThenReturnNil() {
          let result = Utilities.getValueForAPIKey(named: "OpenClassRoom")
          // Then
          XCTAssertNil(result)
      }
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
