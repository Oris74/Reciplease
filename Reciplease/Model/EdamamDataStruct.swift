//
//  EdamamDataStruct.swift
//  Reciplease
//
//  Created by Laurent Debeaujon on 04/11/2020.
//

import Foundation

// MARK: - Edamam
/// API Edamam.com Data Structure
struct Edamam: Codable {
    let query: String
    let from, toQty: Int
    let more: Bool
    let count: Int
    let hits: [Hit]?

    enum CodingKeys: String, CodingKey {
        case query = "q"
        case from
        case toQty = "to"
        case more
        case count
        case hits
    }
}

// MARK: - Hit
struct Hit: Codable {
    let recipeHits: Recipe?
    let bookmarked, bought: Bool

    enum CodingKeys: String, CodingKey {
        case recipeHits = "recipe"
        case bookmarked
        case bought
    }
}

// MARK: - Recipe
struct Recipe: Codable {
    let uriID: String
    let label: String
    let image: String
    let source: String
    let urlOrigin: String
    let shareAs: String
    let yield: Int
    let dietLabels, healthLabels, cautions, ingredientLines: [String]
    let ingredients: [IngredientRecipe]?
    let calories, totalWeight: Double?
    let time: Int
    let totalNutrients, totalDaily: [String: Total]?
    let digest: [Digest]?

    enum CodingKeys: String, CodingKey {
        case uriID = "uri"
        case label, image, source
        case urlOrigin = "url"
        case shareAs, yield, dietLabels
        case healthLabels, cautions, calories
        case totalWeight, ingredientLines
        case time = "totalTime"
        case ingredients
        case totalNutrients, totalDaily
        case digest
    }
}

 // MARK: - Digest
struct Digest: Codable {
    let label, tag: String
    let schemaOrgTag: String?
    let total: Double
    let hasRdi: Bool?
    let daily: Double
    let unit: Unit
    let sub: [Digest]?
}

enum Unit: String, Codable {
    case empty = "%"
    case g = "g"
    case kcal = "kcal"
    case mg = "mg"
    case µg = "µg"
}

// MARK: - Ingredient
struct IngredientRecipe: Codable {
    let text: String
    let weight: Double
    let image: String?
}
// MARK: - Total
struct Total: Codable {
    let label: String
    let quantity: Double
    let unit: Unit
}
