//
//  RecipleaseStruct+Equitable.swift
//  Reciplease
//
//  Created by Laurent Debeaujon on 18/12/2020.
//

import Foundation

extension RecipleaseStruct: Equatable {
    static func == (lhs: RecipleaseStruct, rhs: RecipleaseStruct) -> Bool {
        return lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.image == rhs.image &&
            lhs.source == rhs.source &&
            lhs.urlOrigin == rhs.urlOrigin &&
            lhs.portion == rhs.portion &&
            lhs.ingredients == rhs.ingredients &&
            lhs.time == rhs.time
    }
}
