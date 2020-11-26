//
//  Services.swift
//  Reciplease
//
//  Created by Laurent Debeaujon on 20/11/2020.
//

import Foundation

final class Services {//: RecipesService {

    static let shared = Services()
    private var index = 0

    private let endpointEdamamUrl = URL(string:"https://api.edamam.com/search?")!

    private var apiKey = "EDAMAM"

    func getRecipes(ingredients: String, callback: @escaping (Utilities.ManageError?, [RecipleaseStruct]?) -> Void) {
        guard let keyEdamamMap = Utilities.getValueForAPIKey(named: apiKey )
        else {
            callback(Utilities.ManageError.apiKeyError, nil )
            return
        }

        let parameters = [
            "q": ingredients,
            "app_id": keyEdamamMap["app_id"],
            "app_key": keyEdamamMap["app_key"],
            "from": String(index),
            "to": String(index + 10)
        ]

        APIServices.getAPIData(
            endpointEdamamUrl, parameters, Edamam?.self, completionHandler: {[weak self] (error, apidata) in
                guard let recipes = apidata, let recipeHits = recipes.hits else {
                    return callback(error, nil)
                }

                var recipeReciplease: [RecipleaseStruct] = []
                //let recipeReciplease = recipes.map { _ in try? Recipe(from: RecipleaseStruct.self as! Decoder) }

                for hits in recipeHits {
                    if let recipeAPI = hits.recipeHits {
                        if var recipe = self?.bridgeEdamam(recipe: recipeAPI) {
                            StoredFavorite.isRecorded(idRecipe: recipe.id,  completionHandler: {(recorded) in
                                if recorded {
                                    recipe.favorite = true
                                }
                            })
                            recipeReciplease.append(recipe)
                        }
                    }
                }
                callback(nil, recipeReciplease)
                return
                })
    }

    func getRecipe(idRecipe: String, callback: @escaping (Utilities.ManageError?, RecipleaseStruct?) -> Void) {
        guard let keyEdamamMap = Utilities.getValueForAPIKey(named: apiKey )
        else {
            callback(Utilities.ManageError.apiKeyError, nil )
            return
        }

        let parameters = [
            "&r": idRecipe,
            "&app_id": keyEdamamMap["app_id"],
            "&app_key": keyEdamamMap["app_key"]
        ]
        APIServices.getAPIData(
            endpointEdamamUrl, parameters, Recipe?.self, completionHandler: { [weak self] (error, apiData) in
                guard let recipe = apiData  else {
                    return callback(error, nil)
                }
                callback(nil, self?.bridgeEdamam(recipe: recipe))
            })
    }

    func getFavorites(callback: @escaping (Utilities.ManageError?, [RecipleaseStruct]?) -> Void) {
        let favorites: [Favorite] = StoredFavorite.all.map {
            Favorite(idRecipe: $0.uri ?? "")
        }
        var recipes: [RecipleaseStruct] = []

        for favorite in favorites {
            getRecipe(idRecipe: favorite.idRecipe, callback: {(error, recipe) in
                if var depackedRecipe = recipe {
                    depackedRecipe.favorite = true
                    recipes.append(depackedRecipe)
                } else {
                    callback(error, nil )
                }
            })
        }
        if recipes.isEmpty {
            callback(.noFavoriteFound, nil)
            return
        }
        callback(nil, recipes)
    }

     func bridgeEdamam(recipe: Recipe ) -> RecipleaseStruct {
            let recipeReciplease = RecipleaseStruct.init(
                id: recipe.uriID,
                name: recipe.label,
                image: recipe.image,
                source: recipe.source,
                origin: recipe.urlOrigin,
                shareAs: recipe.shareAs,
                portion: recipe.yield,
                ingredients: recipe.ingredientLines,
                time: recipe.time
            )
            return recipeReciplease
        }
}
