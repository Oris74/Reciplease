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
        fridgeService.cleanFridge()
        fridgeService.transfertIngredientsToFridge()
    }

    func find(ingredient searchedIngredient: String, in fridge: [Ingredient]) -> Bool {
        for ingredient in fridge where searchedIngredient == ingredient.name {
                return true
            }
        return false
    }

    func fillFridge(foods: [String]) {

        let ingredientStored = fridgeService.fridge.ingredients

        for ingredient in foods {
            if find(ingredient: ingredient, in: ingredientStored) {
            } else {
                fridgeService.getFoodTapped(new: ingredient)
            }
        }
    }

   func testTransfertIngredientsToFridgeGivenSavedIngredientsWhenRestoreIngredientThenFridgeIsFull() {
        // Given
        fillFridge(foods: ["Ingredient1", "Ingredient2", "Ingredient3"])

        let arrayOfIngredients = [Ingredient(name: "Ingredient1"),
            Ingredient(name: "Ingredient2"),
            Ingredient(name: "Ingredient3")
        ]
        // When
        fridgeService.transfertIngredientsToFridge()

        // Then
        XCTAssertEqual(fridgeService.fridge.ingredients, arrayOfIngredients)
    }

    ///Getting ingredients from text field to store them into the fridge
    func testGetFoodTappedGivenTappedIngredientWhenProcessingThenIngredientsAreInFridge() {
        // Given
        let foods = "Ingredient1, Ingredient2, Ingredient3"
        let arrayOfIngredients = [Ingredient(name: "Ingredient1"),
            Ingredient(name: "Ingredient2"),
            Ingredient(name: "Ingredient3")
        ]
        // When
        fridgeService.getFoodTapped(new: foods)

        // Then
        XCTAssertEqual(fridgeService.fridge.ingredients, arrayOfIngredients)
    }

    func testCleanFridgeGivenIngredientInFridgeWhenProcessingThenFridgeIsEmpty() {

        // Given
        fillFridge(foods: ["Ingredient1", "Ingredient2", "Ingredient3"])
        // When
        fridgeService.cleanFridge()
        // Then
        XCTAssertEqual(fridgeService.fridge.ingredients, [])
    }

    func testStringOfIngredientsGivenFridgeThenReturnStringOfIngredient() {
        // Given
        fillFridge(foods: ["Ingredient1", "Ingredient2", "Ingredient3"])
        // When
        let requeteOfIngredient = fridgeService.fridge.stringOfIngredients
        // Then
        XCTAssertEqual(requeteOfIngredient, "Ingredient1,Ingredient2,Ingredient3")
    }
}
