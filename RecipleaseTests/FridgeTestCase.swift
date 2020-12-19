//
//  FridgeTestCase.swift
//  RecipleaseTests
//
//  Created by Laurent Debeaujon on 17/12/2020.
//

import XCTest
@testable import Reciplease

class FridgeTestCase: XCTestCase {
    var fridge = Fridge()

    func testCleanThenFridgeIsEmpty() {
        fridge.clean()
        XCTAssertEqual(fridge.ingredients, [])

    }
    func testAddIngredientGivenFridgeIsEmptyWhenAddIngredientThenOneMoreInFridge() {
        //Given
        let startQtyOfIngredient = fridge.ingredients.count
        fridge.addIngredient(Ingredient(name: "test"))
        let endQtyOfIngredient = fridge.ingredients.count
        XCTAssertLessThan(startQtyOfIngredient,endQtyOfIngredient)
    }
    func testStringOfIngredientsWhenProcessingThenGetStringOfIngredient() {

    }

}
