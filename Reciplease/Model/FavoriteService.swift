//
//  FavoriteService.swift
//  Reciplease
//
//  Created by Laurent Debeaujon on 02/12/2020.
//

import Foundation

class FavoriteService {
    static let shared = FavoriteService()

    let recipesService: RecipesService = EdamamService.shared

    func getRecipes(callback: @escaping (Utilities.ManageError?, [RecipleaseStruct]?) -> Void) {
        let favorites: [Favorite] = StoredFavorite.all.map {
            Favorite(idRecipe: $0.uri ?? "")
        }

        let groupRecipe = DispatchGroup()
        var recipes: [RecipleaseStruct] = []

        for favorite in favorites {
            groupRecipe.enter()
            recipesService.getRecipe(idRecipe: favorite.idRecipe, callback: {(error, recipe) in
                if var depackedRecipe = recipe {
                    depackedRecipe.favorite = true
                    recipes.append(depackedRecipe)
                } else {
                    callback(error, nil )
                }
            })
            groupRecipe.leave()
        }

        groupRecipe.notify(qos: DispatchQoS.background, flags: DispatchWorkItemFlags.assignCurrentContext, queue: DispatchQueue.main) {
            // what to do after all requests are done
            if recipes.isEmpty {
                callback(.noFavoriteFound, nil)
                return
            }
            callback(nil, recipes)
        }
    }
}
