//
//  ListRecipeVC+ Extension+Protocol.swift
//  Reciplease
//
//  Created by Laurent Debeaujon on 09/12/2020.
//

import Foundation
import UIKit
extension ListRecipeViewController: PassDataToVC {

    func didButtonPressed(cell: RecipeTableViewCell) {

        if let indexPath = self.tableview.indexPath(for: cell) {
            self.recipes[indexPath.row] = toggleFavoriteStatus(recipe: self.recipes[indexPath.row])
        }
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
    }

    func sendToVC(updatedRecipe: RecipleaseStruct) {
        for (index, recipe) in recipes.enumerated()
        where updatedRecipe.id == recipe.id {
            recipes[index].favorite = updatedRecipe.favorite
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        }
    }
}
