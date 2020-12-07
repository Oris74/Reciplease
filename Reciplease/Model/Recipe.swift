//
//  Recipe.swift
//  Reciplease
//
//  Created by Laurent Debeaujon on 07/12/2020.
//

import Foundation

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
