//
//  FavoriteService.swift
//  Reciplease
//
//  Created by Laurent Debeaujon on 02/12/2020.
//

import Foundation

class FavoriteService {
    static let shared = FavoriteService()

    private var recipesService: RecipesService
    private var favorites: [Favorite] = []

    private init() {
        recipesService = EdamamService.shared
        refreshFavoritesList()
    }

    init(recipesService: RecipesService, favorites: [Favorite]) {
        self.recipesService = recipesService
        self.favorites = favorites
    }

    func refreshFavoritesList() {
        favorites = StoredFavorite.all.map {
            Favorite(idRecipe: $0.uri ?? "")
        }
    }

    func getFavorites(callback: @escaping ([RecipleaseStruct]?, Utilities.ManageError?) -> Void) {
        var recipes = [RecipleaseStruct]()

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
