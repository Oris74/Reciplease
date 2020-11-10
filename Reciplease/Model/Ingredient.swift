//
//  Fridge.swift
//  Reciplease
//
//  Created by Laurent Debeaujon on 09/11/2020.
//

import Foundation
import CoreData

extension Ingredient {

    static var all: [Ingredient] {
        let request: NSFetchRequest<Ingredient> = Ingredient.fetchRequest()
        guard let ingredients = try? AppDelegate.viewContext.fetch(request) else {
            return []
        }
        return ingredients
    }

    static func addToFridge(new ingredients: String) {

        let arrayOfIngredients = ingredients.split(separator: ",")

        for newIngredient in arrayOfIngredients {
            let ingredient = Ingredient(context: AppDelegate.viewContext)
            ingredient.name = newIngredient.trimmingCharacters(in: .whitespacesAndNewlines)
            try? AppDelegate.viewContext.save()
        }

    }

    static func emptyFridge() {
        let request: NSFetchRequest<Ingredient> = Ingredient.fetchRequest()
        // Configure Fetch Request
        request.includesPropertyValues = false

        do {
            let items = try AppDelegate.viewContext.fetch(request)

            for item in items {
                AppDelegate.viewContext.delete(item)
            }

            // Save Changes
            try AppDelegate.viewContext.save()

        } catch {
            // Error Handling
            // ...
        }
    }
}

