//
//  Services.swift
//  Reciplease
//
//  Created by Laurent Debeaujon on 20/11/2020.
//

import Foundation

final class EdamamService : RecipesService {
    var recipes = [RecipleaseStruct]()

    static var shared = EdamamService()

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
        self.recipes = []

        APIServices.getAPIData(
            endpointEdamamUrl, parameters, Edamam.self, completionHandler: {[weak self] (error, apidata) in
                guard let depackedAPIData = apidata, let recipeHits = depackedAPIData.hits else {
                    return callback(error, nil)
                }

                for hits in recipeHits {
                    if let recipeAPI = hits.recipeHits {
                        if var recipe = self?.bridgeEdamam(recipe: recipeAPI) {
                            StoredFavorite.isRecorded(idRecipe: recipe.id,  completionHandler: {(recorded) in
                                if recorded {
                                    recipe.favorite = true
                                }
                            })
                            self?.recipes.append(recipe)
                        }
                    }
                }
                callback(nil, self?.recipes)
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
            "r": idRecipe,
            "app_id": keyEdamamMap["app_id"],
            "app_key": keyEdamamMap["app_key"]
        ]
        APIServices.getRawData(
            endpointEdamamUrl, parameters, completionHandler: { [weak self]  (error, data) in
                guard let json = data  else {
                    return callback(error, nil)
                }

                do {
                    let decoder = JSONDecoder()
                    let recipe = try decoder.decode([Recipe].self, from: json)
                    if recipe.count > 0 {
                        callback(nil, self?.bridgeEdamam(recipe: recipe[0]))
                    } else {
                        callback(error, nil)
                    }
                } catch {
                    callback(Utilities.ManageError.decodableIssue, nil)
                }
            })
    }

    private func bridgeEdamam(recipe: Recipe ) -> RecipleaseStruct {
        let recipeReciplease = RecipleaseStruct.init(
            id: recipe.uriID,
            name: recipe.label,
            image: recipe.image,
            source: recipe.source,
            origin: recipe.urlOrigin,
            portion: recipe.yield,
            ingredients: recipe.ingredientLines,
            time: recipe.time
        )
        return recipeReciplease
    }
}
