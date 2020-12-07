//
//  RecipeElement.swift
//  Reciplease
//
//  Created by Laurent Debeaujon on 02/12/2020.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let recipeStruct = try? newJSONDecoder().decode(RecipeStruct.self, from: jsonData)

import Foundation

struct Result: Codable {
    let results: [Recipe]

    enum Codingkeys: CodingKey { case results }
    enum NodeKeys: CodingKey { case nodes }

    init(from decoder: Decoder) throws {
        let rootContainer  = try decoder.container(keyedBy: CodingKeys.self)

        let resultsNode  = try rootContainer.nestedContainer(keyedBy: NodeKeys.self, forKey: .results)
        var nodes = try resultsNode.nestedUnkeyedContainer(forKey: .nodes)
        var allResults: [Recipe] = []
        while !nodes.isAtEnd {
            let recipe = try nodes.decode(Recipe.self)
            allResults += [recipe]
        }
        results = allResults
    }
 }
