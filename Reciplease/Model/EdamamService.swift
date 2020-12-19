//
//  Services.swift
//  Reciplease
//
//  Created by Laurent Debeaujon on 20/11/2020.
//

import Foundation

final class EdamamService : RecipesService {

    static let shared = EdamamService()

    private let apiService: APIProtocol
    private let endPointEdamamUrl = URL(string:"https://api.edamam.com/search?")!

    private var recipes = [RecipleaseStruct]()

    private var keyEdamamMap: [String:String] {
        return Utilities.getValueForAPIKey(named: apiKey ) ?? ["":""]
    }
    private var index = 0

    private var apiKey = "EDAMAM"

    private init() {
        apiService = APIService.shared
    }

    init(apiService: APIProtocol) {
        self.apiService =  apiService
    }

    internal func getRecipes(ingredients: String, callback: @escaping ([RecipleaseStruct]?, Utilities.ManageError?) -> Void) {

        let parameters = [
            "q": ingredients,
            "app_id": keyEdamamMap["app_id"],
            "app_key": keyEdamamMap["app_key"],
            "from": String(index),
            "to": String(index + 10)
        ]
        self.recipes = []

        apiService.getAPIData(
            endPointEdamamUrl, parameters, Edamam?.self, completionHandler: {[weak self] (apidata, error ) in
                guard let depackedAPIData = apidata, let recipeHits = depackedAPIData.hits else {
                    return callback(nil, error)
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
                callback( self?.recipes, nil)
                return
            })
    }

    internal func getRecipe(idRecipe: String, callback: @escaping ( RecipleaseStruct?, Utilities.ManageError?) -> Void) {

        let parameters = [
            "r": idRecipe,
            "app_id": keyEdamamMap["app_id"],
            "app_key": keyEdamamMap["app_key"]
        ]
        apiService.getAPIData(
            endPointEdamamUrl,
            parameters,
            [Recipe]?.self,
            completionHandler: { (result, error) in
                callback(self.bridgeEdamam(recipe: result?.first), error)
            })
    }

    private func bridgeEdamam(recipe: Recipe? ) -> RecipleaseStruct? {
        guard let depackedRecipe = recipe else { return nil }
        let recipeReciplease = RecipleaseStruct.init(
            id: depackedRecipe.uriID,
            name: depackedRecipe.label,
            image: depackedRecipe.image,
            source: depackedRecipe.source,
            origin: depackedRecipe.urlOrigin,
            portion: depackedRecipe.yield,
            ingredients: depackedRecipe.ingredientLines,
            time: depackedRecipe.time
        )
        return recipeReciplease
    }
}
