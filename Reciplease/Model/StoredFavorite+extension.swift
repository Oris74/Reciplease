//
//  StoredFavorite+extension.swift
//  Reciplease
//
//  Created by Laurent Debeaujon on 24/11/2020.
//

import Foundation
import CoreData

extension StoredFavorite {
    static var all: [StoredFavorite] {
        let request: NSFetchRequest<StoredFavorite> = StoredFavorite.fetchRequest()
        guard let favorite = try? AppDelegate.viewContext.fetch(request) else {
            return []
        }
        return favorite
    }

    static func save(recipe: String) {
        let favorite = Favorite(idRecipe: recipe)
        isRecorded(idRecipe: recipe, completionHandler: { (recorded) in
            if (!recorded) {
                let storedFavorite = StoredFavorite(context: AppDelegate.viewContext)
                storedFavorite.uri = favorite.idRecipe
                try? AppDelegate.viewContext.save()
            }
        })
    }

    static func isRecorded(idRecipe: String , completionHandler: @escaping ( Bool) -> Void) {
        let request: NSFetchRequest<StoredFavorite> = StoredFavorite.fetchRequest()
        // Configure Fetch Request
        request.predicate = NSPredicate(format: "uri=%@", idRecipe)
        let count = try? AppDelegate.viewContext.count(for: request)
        if(count == 0) {
            completionHandler(false)
        } else {
            completionHandler(true)
        }
    }

    static func Delete(idRecipe: String) {
        let request: NSFetchRequest<StoredFavorite> = StoredFavorite.fetchRequest()
        // Configure Fetch Request
        request.predicate = NSPredicate(format: "uri=%@", idRecipe)
        request.includesPropertyValues = false
        
        let items = try? AppDelegate.viewContext.fetch(request)
        guard let depackedItems = items else { return }
        for item in depackedItems {
            AppDelegate.viewContext.delete(item)
        }
        // Save Changes
        try? AppDelegate.viewContext.save()
    }
}
