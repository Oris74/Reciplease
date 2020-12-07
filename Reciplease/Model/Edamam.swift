//
//  Edamam.swift
//  Reciplease
//
//  Created by Laurent Debeaujon on 04/11/2020.
//

import Foundation

// MARK: - Edamam
/// API Edamam.com 
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
