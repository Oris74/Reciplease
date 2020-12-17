//
//  RecipesService.swift
//  Reciplease
//
//  Created by Laurent Debeaujon on 17/11/2020.
//

import Foundation

protocol RecipesService {

    func getRecipes(ingredients: String, callback: @escaping  ([RecipleaseStruct]?, Utilities.ManageError? ) -> Void)
    func getRecipe(idRecipe: String, callback: @escaping ( RecipleaseStruct?, Utilities.ManageError?) -> Void)
}
