//
//  Ingredient.swift
//  Reciplease
//
//  Created by Laurent Debeaujon on 10/11/2020.
//

import Foundation

struct Ingredient {
    let name: String
}

extension Ingredient: Equatable {
    static func == (lhs: Ingredient, rhs: Ingredient) -> Bool {
        return lhs.name == rhs.name
    }
}
