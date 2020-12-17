//
//  FridgeService.swift
//  Reciplease
//
//  Created by Laurent Debeaujon on 10/11/2020.
//

import Foundation

class FridgeService {
    static let shared = FridgeService()

    private(set) var fridge = Fridge()

    private init(){
        transfertIngredientsToFridge()
    }

 /*   init(fridge: Fridge){
        self.fridge = fridge
    }*/

    func transfertIngredientsToFridge() {
        let ingredients: [Ingredient] = StoredIngredient.all.map {
            Ingredient(name: $0.name ?? "")
        }
        addToFridge(ingredients: ingredients, backup: false)
    }

    ///Getting ingredients from text field to store them into the fridge
    func getFoodTapped(new foodstuffs: String) {

        let arrayOfFoods = foodstuffs.split { $0 == ","}.map { $0.trimmingCharacters(in: .whitespaces)}
        let trimmedFoods = arrayOfFoods.map {Ingredient(name: String($0))}

        addToFridge(ingredients: trimmedFoods, backup: true)
    }

    private func addToFridge(ingredients:[Ingredient], backup: Bool) {
        for ingredient in ingredients {
            self.fridge.addIngredient(ingredient)

            if backup {
                StoredIngredient.save(ingredient: ingredient)
            }
        }
    }

    func cleanFridge() {
        self.fridge.clean()
        StoredIngredient.clean()
    }
}
