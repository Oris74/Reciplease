//
//  RecipepleaseStruct.swift
//  
//
//  Created by Laurent Debeaujon on 18/11/2020.
//

import Foundation

struct RecipleaseStruct: Decodable {
    let id: String
    let name: String
    let image: String?
    let source: String
    let urlOrigin: String
    let portion: Int
    let ingredients: [String]
    let time: Int
    var favorite: Bool

    init(id:String, name: String, image: String?, source: String, origin: String, portion: Int, ingredients: [String], time: Int, favorite: Bool = false) {
        self.id = id
        self.name = name
        self.image = image
        self.source = source
        self.urlOrigin = origin
        self.portion = portion
        self.ingredients = ingredients
        self.time = time
        self.favorite = favorite
    }
}
