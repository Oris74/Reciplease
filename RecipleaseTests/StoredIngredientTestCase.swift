//
//  StoredIngredientTestCase.swift
//  RecipleaseTests
//
//  Created by Laurent Debeaujon on 17/12/2020.
//

import XCTest
import CoreData

@testable import Reciplease

class StoredIngredientTestCase: XCTestCase {

    override class func tearDown() {
        StoredIngredient.clean()
    }

    func testStoredIngredientGivenNewIngredientWhenGetALLIngredientStoredThenIngredientListIsNotNull() {
        // Given
        StoredIngredient.save(ingredient: Ingredient(name: "test"))
        // When
        let ingredientList = StoredIngredient.all
        // Then
        XCTAssert(ingredientList.count >= 0)
    }

    func testRAZStoredIngredientGivenTestStoredWhenCleaningDatabaseThenDatabaseIsRAZ() {
        // Given
        let newFakeIngredient = "Test"
        StoredIngredient.save(ingredient: Ingredient(name: newFakeIngredient))
        // When
        StoredIngredient.clean()
        // Then
        let ingredientList = StoredIngredient.all
        XCTAssertEqual(ingredientList.count, 0)
    }
}
