//
//  Edamam+Equitable.swift
//  Reciplease
//
//  Created by Laurent Debeaujon on 17/12/2020.
//

import Foundation

///make Struct Recipe equatable
extension Edamam: Equatable {
    static func == (lhs: Edamam, rhs: Edamam) -> Bool {
        return lhs.query == rhs.query &&
            lhs.from == rhs.from &&
            lhs.toQty == rhs.toQty &&
            lhs.more == rhs.more &&
            lhs.count == rhs.count &&
            lhs.hits == rhs.hits
    }
}
