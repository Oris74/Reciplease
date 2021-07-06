//
//  StoredFavoritesTestCase.swift
//  RecipleaseTests
//
//  Created by Laurent Debeaujon on 17/12/2020.
//

import XCTest
import CoreData

@testable import Reciplease

class StoredFavoritesTestCase: XCTestCase {

    override class func tearDown() {
        StoredFavorite.Delete(idRecipe: "Test")
    }

    func testStoredFavoriteGivenTestNotStoredWhenTestRecipeIsSavedThenTestISStored() {
        // Given
        let newFakeRecipe = "Test"
        StoredFavorite.isRecorded(idRecipe: newFakeRecipe, completionHandler: {(result) in
            XCTAssertFalse(result)
        })
        // When
        StoredFavorite.save(recipe: newFakeRecipe)

        //Then
        StoredFavorite.isRecorded(idRecipe: newFakeRecipe, completionHandler: {(result) in
            XCTAssertTrue(result)
        })

    }

    func testStoredFavoriteGivenFavoriteListIsEmptyWhenGetALLFavoriteStoredThenfavoriteListIsNull() {
        // Given
        let favoriteList: [StoredFavorite]
        // When
        favoriteList = StoredFavorite.all
        print(favoriteList.count)
        // Then
        XCTAssert(favoriteList.count == 0)
    }

    func testDeleteStoredFavoriteGivenTestStoredWhenTestRecipeIsDeletedThenTestNotStored() {
        // Given
        let newFakeRecipe = "Test"
        StoredFavorite.save(recipe: newFakeRecipe)
        StoredFavorite.isRecorded(idRecipe: newFakeRecipe, completionHandler: {(result) in
            XCTAssertTrue(result)
        })
        // When
        StoredFavorite.Delete(idRecipe: newFakeRecipe)

        //Then
        StoredFavorite.isRecorded(idRecipe: newFakeRecipe, completionHandler: {(result) in
            XCTAssertFalse(result)
        })
    }
}
