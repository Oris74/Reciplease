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
    var results: [Recipe]
 }
