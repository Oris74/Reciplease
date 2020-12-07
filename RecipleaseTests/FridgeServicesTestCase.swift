//
//  FridgeServicesTestCase.swift
//  RecipleaseTests
//
//  Created by Laurent Debeaujon on 11/11/2020.
//

import XCTest
@testable import Reciplease

class FridgeServicesTestCase: XCTestCase {
    var fridgeService: FridgeService!

    override func setUp() {
        super.setUp()
        fridgeService = FridgeService()
    }
    let ingredients: String = "tomatoes, chicken"

    func testGivenNewIngredientWhenTappedThenIngredienAdded() {
        //Given
        fridgeService.getFoodTapped(new: ingredients)

        //When

        //Then
    }
        override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

  /*  internal static let shared: Reciplease.FridgeService

    private(set) internal private(set) var fridge: Reciplease.Fridge { get }

    internal func transfertIngredientsToFridge()

    ///Getting ingredients from text field to store them into the fridge
    internal func getFoodTapped(new foodstuffs: String)

    internal func cleanFridge()*/
}
