//
//  Recipe+Equitable.swift
//  Reciplease
//
//  Created by Laurent Debeaujon on 17/12/2020.
//

import Foundation

///make Struct Recipe equatable
extension Recipe: Equatable {
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        return lhs.uriID == rhs.uriID &&
            lhs.label == rhs.label &&
            lhs.image == rhs.image &&
            lhs.source == rhs.source &&
            lhs.urlOrigin == rhs.urlOrigin &&
            lhs.yield == rhs.yield &&
            lhs.ingredientLines == rhs.ingredientLines &&
            lhs.time == rhs.time
    }
}
