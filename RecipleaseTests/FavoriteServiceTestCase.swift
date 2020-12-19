//
//  FavoriteServiceTestCase.swift
//  RecipleaseTests
//
//  Created by Laurent Debeaujon on 17/12/2020.
//

import XCTest
import CoreData

@testable import Reciplease

class FavoriteServiceTestCase: XCTestCase {
    func testGetFavoriteGivenCorrectRecipeJSONThenCallBackSuccess() {
        // Given
        let favorites: [Favorite] = [
            Favorite(idRecipe: "http://www.edamam.com/ontologies/edamam.owl#recipe_4829f82b6a402d398f147edc6352dfde")
            ]
        let favoriteService = FavoriteService(
            recipesService: EdamamService(
                apiService: APIServiceFake(
                    json: FakeResponseData.recipeEdamamJsonCorrectData!)),
            favorites: favorites)
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        favoriteService.getFavorites( callback: { ( apiData, errorCode) in
            // Then
            XCTAssertNil(errorCode)
            XCTAssertEqual(apiData?.first, FakeResponseData.responseRecipleaseStructOK)

            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 0.10)
    }

}
