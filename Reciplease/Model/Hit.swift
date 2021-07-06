//
//  Hit.swift
//  Reciplease
//
//  Created by Laurent Debeaujon on 07/12/2020.
//

import Foundation

// MARK: - Hit
struct Hit: Codable {
    let recipeHits: Recipe?

    enum CodingKeys: String, CodingKey {
        case recipeHits = "recipe"
    }
}
