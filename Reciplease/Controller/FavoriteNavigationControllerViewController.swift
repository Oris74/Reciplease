//
//  FavoriteNavigationControllerViewController.swift
//  Reciplease
//
//  Created by Laurent Debeaujon on 25/11/2020.
//

import UIKit

class FavoriteNavControllerViewController: UINavigationController, VCUtilities {
    private var recipes: [RecipleaseStruct] = []

    override func viewWillAppear(_ animated: Bool) {
        Services.shared.getFavorites(callback: { [weak self] (error, savedRecipes) in
            guard let depackedRecipes = savedRecipes,
               error == nil else {
                self?.manageErrors(errorCode: error)
                return
            }
            self?.recipes = depackedRecipes
        })
        super.viewWillAppear(animated)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navigationVC = segue.destination as? UINavigationController, let listRecipeVC = navigationVC.topViewController as? ListRecipeViewController {
            listRecipeVC.recipes = self.recipes
        }
    }
}
