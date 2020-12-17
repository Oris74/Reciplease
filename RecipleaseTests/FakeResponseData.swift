//
//  FakeRersponseData.swift
//  RecipleaseTests
//
//  Created by Laurent Debeaujon on 10/12/2020.
//

import Foundation
@testable import Reciplease

class FakeResponseData {
    // MARK: - Data
    static var edamamJsonCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Edamam", withExtension: "json")!
        return try? Data(contentsOf: url)
    }

    static var recipeEdamamJsonCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "RecipeEdamam", withExtension: "json")!
        return try? Data(contentsOf: url)
    }

    static let incorrectData = "erreur".data(using: .utf8)!

    // MARK: - Response Edamam
    static let responseEdamamOK = Edamam(
        query:"chicken, milk, butter, orange",
        from: 0,
        toQty: 1,
        more: true,
        count: 79,
        hits: [Hit(
            recipeHits: Recipe(
                uriID: "http://www.edamam.com/ontologies/edamam.owl#recipe_4829f82b6a402d398f147edc6352dfde",
                label: "Dinner Tonight: Chicken Do-Piaza Recipe",
                image: "https://www.edamam.com/web-img/320/320f21390c7ff17ab309020df4c06eb8.jpg",
                source: "Serious Eats",
                urlOrigin: "http://www.seriouseats.com/recipes/2008/10/chicken-do-piaza-recipe.html",
                yield: Int(4.0),
                ingredientLines:[
                    "1 cup whole-milk yogurt",
                    "2 large onions",
                    "1/2 cup orange juice",
                    "1/4 cup water",
                    "1 tablespoon grated ginger",
                    "3 garlic cloves, chopped",
                    "2 teaspoons ground coriander",
                    "1 teaspoon ground turmeric",
                    "1/4 teaspoon cayenne",
                    "1 chicken",
                    "2 tablespoons butter",
                    "Salt"
                ],
                time: Int(0.0)
            ),
            bookmarked: false,
            bought: false
        )]
    )
    // MARK: - Response Recipe
    static let responseRecipeOK = Recipe(
                uriID: "http://www.edamam.com/ontologies/edamam.owl#recipe_b79327d05b8e5b838ad6cfd9576b30b6",
                label: "Chicken Vesuvio",
                image: "https://www.edamam.com/web-img/e42/e42f9119813e890af34c259785ae1cfb.jpg",
                source: "Serious Eats",
                urlOrigin: "http://www.seriouseats.com/recipes/2011/12/chicken-vesuvio-recipe.html",
                yield: Int(4.0),
                ingredientLines:[
                        "1/2 cup olive oil",
                        "5 cloves garlic, peeled",
                        "2 large russet potatoes, peeled and cut into chunks",
                        "1 3-4 pound chicken, cut into 8 pieces (or 3 pound chicken legs)",
                        "3/4 cup white wine",
                        "3/4 cup chicken stock",
                        "3 tablespoons chopped parsley",
                        "1 tablespoon dried oregano",
                        "Salt and pepper",
                        "1 cup frozen peas, thawed"
                ],
        time: Int(60.0)
            )

    static let responseKO = HTTPURLResponse(
        url: URL(string: "http://openclassrooms.com")!,
        statusCode: 500, httpVersion: nil, headerFields: [:])!

    // MARK: - Error
    class ErrorClass: Error {}
    static let error = ErrorClass()
}
