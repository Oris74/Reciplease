//
//  Hit+Equitable.swift
//  Reciplease
//
//  Created by Laurent Debeaujon on 17/12/2020.
//

import Foundation

///make Struct Hit equatable
extension Hit: Equatable {
    static func == (lhs: Hit, rhs: Hit) -> Bool {
        return lhs.recipeHits == rhs.recipeHits
    }
}
