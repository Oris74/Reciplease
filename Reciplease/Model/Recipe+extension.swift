//
//  Recipe+extension.swift
//  Reciplease
//
//  Created by Laurent Debeaujon on 07/12/2020.
//

import Foundation

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
