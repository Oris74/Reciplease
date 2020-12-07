//
//  UtilitiesTestCase.swift
//  RecipleaseTests
//
//  Created by Laurent Debeaujon on 11/11/2020.
//

import Foundation
import XCTest
@testable import Reciplease

class UtilitiesTestCase: XCTestCase {

    // MARK: - test getValueForAPIKey
    func testGivenAPINameWhenNameIsNotNullThenReturnKey() {
        let result = Utilities.getValueForAPIKey(named: "EDAMAM")
        // Then
        XCTAssertNotNil(result)
    }
    func testGivenAPINameWhenNameIsNotKnownThenReturnNil() {
          let result = Utilities.getValueForAPIKey(named: "OpenClassRoom")
          // Then
          XCTAssertNil(result)
      }
}
