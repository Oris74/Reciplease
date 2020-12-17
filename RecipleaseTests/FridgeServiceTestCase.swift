//
//  FridgeServiceTestCase.swift
//  RecipleaseTests
//
//  Created by Laurent Debeaujon on 17/12/2020.
//

import XCTest
@testable import Reciplease

class FridgeServiceTestCase: XCTestCase {
    var fridgeService: FridgeService!
    var fridge: Fridge!

    override func setUp() {
        super.setUp()
        fridgeService = FridgeService.shared
    }

    func fillFridge(foods: [String]) {
        for ingredient in foods {
            fridgeService.getFoodTapped(new: ingredient)
        }
    }

    func testTransfertIngredientsToFridgeGivenSavedIngredientsWhenRestoreIngredientThenFridgeIsFull() {
        // Given
        fillFridge(foods: ["Chicken", "Cheese", "Sausage"])

        let arrayOfIngredients = [Ingredient(name: "Chicken"),
            Ingredient(name: "Cheese"),
            Ingredient(name: "Sausage")
        ]
        // When
        fridgeService.transfertIngredientsToFridge()
        // Then
        XCTAssertEqual(fridgeService.fridge.ingredients, arrayOfIngredients)
    }

    ///Getting ingredients from text field to store them into the fridge
    func testGetFoodTappedGivenTappedIngredientWhenProcessingThenIngredientsAreInFridge() {
        // Given
        let foods = "Chicken, Cheese, Sausage"
        let arrayOfIngredients = [Ingredient(name: "Chicken"),
            Ingredient(name: "Cheese"),
            Ingredient(name: "Sausage")
        ]
        // When
        fridgeService.getFoodTapped(new: foods)

        // Then
        XCTAssertEqual(fridgeService.fridge.ingredients, arrayOfIngredients)
    }

    internal func testCleanFridgeGivenIngredientInFridgeWhenProcessingThenFridgeIsEmpty() {
        // Given
        fillFridge(foods: ["Chicken", "Cheese", "Sausage"])
        // When
        fridgeService.cleanFridge()
        // Then
        XCTAssertEqual(fridgeService.fridge.ingredients, [])
    }
    func testStringOfIngredientsGivenFridgeThenReturnStringOfIngredient() {
        // Given
        //fillFridge(foods: ["Chicken", "Cheese", "Sausage"])
        // When
        let requeteOfIngredient = fridgeService.fridge.stringOfIngredients
        // Then
        XCTAssertEqual(requeteOfIngredient, "Chicken,Cheese Sausage")
    }

}
