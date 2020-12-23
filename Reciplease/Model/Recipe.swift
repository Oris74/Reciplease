//
//  Recipe.swift
//  Reciplease
//
//  Created by Laurent Debeaujon on 07/12/2020.
//

import Foundation

// MARK: - Recipe
///API Edamam.com Struct Recipe
struct Recipe: Codable {
    var uriID: String
    var label: String
    var image: String
    var source: String
    var urlOrigin: String
    var yield: Int
    var ingredientLines: [String]
    var time: Int

    enum CodingKeys: String, CodingKey {
        case uriID = "uri"
        case label, image, source
        case urlOrigin = "url"
        case yield
        case ingredientLines
        case time = "totalTime"
    }
}
