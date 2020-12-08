//
//  FavoriteService.swift
//  Reciplease
//
//  Created by Laurent Debeaujon on 02/12/2020.
//

import Foundation

class FavoriteService {
    static let shared = FavoriteService()

    var recipes: [RecipleaseStruct] = []
    let recipesService: RecipesService = EdamamService.shared

    func getRecipes(callback: @escaping (Utilities.ManageError?,    [RecipleaseStruct]?) -> Void) {
        let favorites: [Favorite] = StoredFavorite.all.map {
            Favorite(idRecipe: $0.uri ?? "")
        }
        print("nb favoris :\(favorites.count) " )
        let groupRecipe = DispatchGroup()
        for favorite in favorites {
            groupRecipe.enter()
            DispatchQueue.main.async { [weak self] in
                self?.recipesService.getRecipe(
                    idRecipe:favorite.idRecipe,
                    callback: {[weak self](error, recipe) in
                        if var depackedRecipe = recipe {
                            depackedRecipe.favorite = true
                            self?.recipes.append(depackedRecipe)
                        }
                        groupRecipe.leave()
                    })
            }
        }

        groupRecipe.notify( queue: DispatchQueue.main) { [self] in
            if recipes.isEmpty {
                callback(.noFavoriteFound, nil)
                return
            }
            callback(nil, recipes)
        }
    }
}
