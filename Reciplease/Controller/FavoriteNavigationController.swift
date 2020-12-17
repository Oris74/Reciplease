//
//  FavoriteNavigationControllerViewController.swift
//  Reciplease
//
//  Created by Laurent Debeaujon on 25/11/2020.
//

import UIKit

class FavoriteNavigationController: UINavigationController, VCUtilities {

    let favoriteService: FavoriteService = FavoriteService.shared

    override func viewWillAppear(_ animated: Bool) {
        guard let listRecipeVC = self.viewControllers.first as? ListRecipeViewController else {
            self.manageErrors(errorCode: Utilities.ManageError.undefinedError)
            return
        }
        listRecipeVC.recipes = []
        favoriteService.getRecipes(callback: { [weak self] ( savedRecipes, error) in
            guard let depackedRecipes = savedRecipes, depackedRecipes.count > 0 else {

                self?.manageErrors(errorCode: error)
                return
            }
            if let depackedError = error {
                self?.manageErrors(errorCode: depackedError)
            }
            listRecipeVC.recipes = depackedRecipes
            listRecipeVC.tableview.reloadData()
        })
        super.viewWillAppear(animated)
    }
}
