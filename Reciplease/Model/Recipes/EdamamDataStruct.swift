//
//  EdamamDataStruct.swift
//  Reciplease
//
//  Created by Laurent Debeaujon on 04/11/2020.
//

import Foundation

// MARK: - Edamam
///API Edamam.com Data Structure
struct Edaman: Codable {
    let q: String
    let from, to: Int
    let more: Bool
    let count: Int
    let hits: [Hit]
}

// MARK: - Hit
struct Hit: Codable {
    let recipe: Recipe
    let bookmarked, bought: Bool
}

// MARK: - Recipe
struct Recipe: Codable {
    let uri: String
    let label: String
    let image: String
    let source: String
    let url: String
    let shareAs: String
    let yield: Int
    let dietLabels, healthLabels, cautions, ingredientLines: [String]
    let ingredients: [Ingredient]
    let calories, totalWeight: Double
    let totalTime: Int
    let totalNutrients, totalDaily: [String: Total]
    let digest: [Digest]
}

// MARK: - Digest
struct Digest: Codable {
    let label, tag: String
    let schemaOrgTag: String?
    let total: Double
    let hasRdi: Bool
    let daily: Double
    let unit: Unit
    let sub: [Digest]?

    enum CodingKeys: String, CodingKey {
        case label, tag, schemaOrgTag, total
        case hasRdi
        case daily, unit, sub
    }
}

enum Unit: String, Codable {
    case empty = "%"
    case g = "g"
    case kcal = "kcal"
    case mg = "mg"
    case µg = "µg"
}

// MARK: - Ingredient
struct Ingredient: Codable {
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
