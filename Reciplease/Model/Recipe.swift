//
//  Recipe.swift
//  Reciplease
//
//  Created by Laurent Debeaujon on 09/11/2020.
//

import Foundation
import CoreData
// MARK: Recipe

extension Recipe {
    static var all: [Recipe] {
        let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(key: "title", ascending: true)
        ]
        guard let recipe = try? AppDelegate.viewContext.fetch(request) else {
            return []
        }
        return recipe
    }
}
