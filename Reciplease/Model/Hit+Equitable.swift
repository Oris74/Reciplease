//
//  Hit+Equitable.swift
//  Reciplease
//
//  Created by Laurent Debeaujon on 17/12/2020.
//

import Foundation

///make Struct Recipe equatable
extension Hit: Equatable {
    static func == (lhs: Hit, rhs: Hit) -> Bool {
        return lhs.recipeHits == rhs.recipeHits &&
            lhs.bookmarked == rhs.bookmarked &&
            lhs.bought == rhs.bought
    }
}
