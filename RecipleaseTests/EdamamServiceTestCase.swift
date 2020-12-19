//
//  RecipesServicesTestCase.swift
//  RecipleaseTests
//
//  Created by Laurent Debeaujon on 11/11/2020.
//

import XCTest

@testable import Reciplease

class EdamamServicesTestCase: XCTestCase {

    func testGetRecipesGivenCorrectEdamamJSONThenCallBackSuccess() {
        // Given
        let recipesService = EdamamService(apiService: APIServiceFake(json: FakeResponseData.edamamJsonCorrectData!))
        let ingredients = "chicken, milk, butter, orange"

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipesService.getRecipes(ingredients: ingredients, callback: { ( apiData, errorCode) in
            // Then
            XCTAssertNil(errorCode)
            XCTAssertNotNil(apiData)
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 0.10)
    }

    func testGetRecipeGivenCorrectRecipeEdamamJSONThenCallBackSuccess() {
        // Given

        let recipesService = EdamamService(apiService: APIServiceFake(json: FakeResponseData.recipeEdamamJsonCorrectData!))
        let idRecipe = "http://www.edamam.com/ontologies/edamam.owl#recipe_4829f82b6a402d398f147edc6352dfde"

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipesService.getRecipe(idRecipe: idRecipe, callback: { (apiData, errorCode) in
            // Then
            XCTAssertNil(errorCode)
            XCTAssertEqual(apiData, FakeResponseData.responseRecipleaseStructOK)
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 0.01)
    }
}
