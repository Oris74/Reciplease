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

    func getRecipes(callback: @escaping ([RecipleaseStruct]?, Utilities.ManageError?) -> Void) {
        var recipes = [RecipleaseStruct]()
        let favorites: [Favorite] = StoredFavorite.all.map {
            Favorite(idRecipe: $0.uri ?? "")
        }
        var processingError: Utilities.ManageError?
        let groupRecipe = DispatchGroup()
        for favorite in favorites {
            groupRecipe.enter()

            recipesService.getRecipe(
                idRecipe:favorite.idRecipe,
                callback: { (recipe, error) in
                    DispatchQueue.main.async {
                        if var depackedRecipe = recipe {
                            depackedRecipe.favorite = true
                            recipes.append(depackedRecipe)
                        }
                        processingError = error
                        groupRecipe.leave()
                    }
                })
        }
        if (processingError == nil),
           (recipes.count == 0) {
            processingError = .noFavoriteFound
        }
        groupRecipe.notify( queue: DispatchQueue.main) {
            callback(recipes, processingError)
        }
    }
}
