//
//  RecipesService.swift
//  Reciplease
//
//  Created by Laurent Debeaujon on 17/11/2020.
//

import Foundation

protocol RecipesService {
    var  recipes: [RecipleaseStruct] {get set}

    func getRecipes(ingredients: String, callback: @escaping  (Utilities.ManageError?, [RecipleaseStruct]?) -> Void)
    func getRecipe(idRecipe: String, callback: @escaping  (Utilities.ManageError?, RecipleaseStruct?) -> Void)

}
