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
    var uriID: String
    var label: String
    var image: String
    var source: String
    var urlOrigin: String
    var yield: Int
    var ingredientLines: [String]
    var time: Int

    init( uriID: String, label: String, image: String, source: String, urlOrigin: String, yield: Int, ingredientLines: [String], time: Int) {
        self.uriID = uriID
        self.label = label
        self.image = image
        self.source = source
        self.urlOrigin = urlOrigin
        self.yield = yield
        self.ingredientLines = ingredientLines
        self.time = time
    }
}

extension Recipe {
    enum RecipeKeys: String, CodingKey {
        case uriID = "uri"
        case label, image, source
        case urlOrigin = "url"
        case yield
        case ingredientLines
        case time = "totalTime"
    }

    init(from decoder: Decoder) throws {
        let container  = try decoder.container(keyedBy: RecipeKeys.self)

        let uriID  = try container.decode(String.self, forKey: .uriID)
        let ingredientLines  = try container.decode([String].self, forKey: .ingredientLines)
        let label = try container.decode(String.self, forKey: .label)
        let yield = try container.decode(Int.self, forKey: .yield)
        let time = try container.decode(Int.self, forKey: .time)
        let image = try container.decode(String.self, forKey: .image)
        let source = try container.decode(String.self, forKey: .source)
        let urlOrigin = try container.decode(String.self, forKey: .urlOrigin)

        self.init( uriID: uriID, label: label, image: image, source: source, urlOrigin: urlOrigin, yield: yield, ingredientLines: ingredientLines, time: time)
    }
}
