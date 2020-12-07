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
        if let listRecipeViewController = self.viewControllers.first as? ListRecipeViewController {
           // listRecipeViewController.recipes = []
        }

        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        favoriteService.getRecipes(callback: { [weak self] (error, savedRecipes) in
            guard let depackedRecipes = savedRecipes,
                  error == nil, depackedRecipes.count > 0 else {
                self?.manageErrors(errorCode: error)
                return
            }
            if let listRecipeViewController = self?.viewControllers.first as? ListRecipeViewController {
                listRecipeViewController.recipes = depackedRecipes
            }
        })
        super.viewDidAppear(animated)
    }

}
