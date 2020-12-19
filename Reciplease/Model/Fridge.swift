//
//  Fridge.swift
//  Reciplease
//
//  Created by Laurent Debeaujon on 09/11/2020.
//

import Foundation

struct Fridge {
    var ingredients: [Ingredient] = []

    var stringOfIngredients: String {
        return ingredients.map {String($0.name)}.joined(separator: ",")
    }

     mutating func addIngredient(_ ingredient: Ingredient) {
        ingredients.append(ingredient)
    }

     mutating func clean() {
        ingredients = []
    }

}
