//
//  StoredIngredient.swift
//  Reciplease
//
//  Created by Laurent Debeaujon on 10/11/2020.
//

import Foundation
import CoreData

extension StoredIngredient {
    static var all: [StoredIngredient] {
        let request: NSFetchRequest<StoredIngredient> = StoredIngredient.fetchRequest()
        guard let goodsInFridge = try? AppDelegate.viewContext.fetch(request) else {
            return []
        }
        return goodsInFridge
    }

    static func save(ingredient: Ingredient) {
          let storedIngredient = StoredIngredient(context: AppDelegate.viewContext)
                storedIngredient.name = ingredient.name
            try? AppDelegate.viewContext.save()
    }

    static func clean() {
        let request: NSFetchRequest<StoredIngredient> = StoredIngredient.fetchRequest()
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

        }
    }
}
