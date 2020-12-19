//
//  JSONTestCase.swift
//  RecipleaseTests
//
//  Created by Laurent Debeaujon on 18/12/2020.
//

import XCTest
@testable import Reciplease

class JSONTestCase: XCTestCase {
    func testDecodeDataGivenJSONWhenDecodeEdamamThenAPIDecoded() {
        // Given
        let json = JSON.shared
        // When
        json.decodeData(type: Edamam?.self, data: FakeResponseData.edamamJsonCorrectData, completion: {(recipe, error) in
            // then
            XCTAssertEqual(recipe, FakeResponseData.responseEdamamOK)
            XCTAssertNil(error)
        })
    }
}
