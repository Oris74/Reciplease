//
//  VCUtilities.swift
//  Reciplease
//
//  Created by Laurent Debeaujon on 09/11/2020.
//

import UIKit

/// Controlers Utilities
protocol VCUtilities: UIViewController {
    func presentAlert(message: String)
}

extension VCUtilities {
    /// getting popup alert with description errors
    internal func presentAlert(message: String) {
        let alert = UIAlertController(title: "Erreur", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    internal func dismissKeyboard() {
        view.endEditing(true)
    }

    internal func manageErrors(errorCode: Utilities.ManageError?) {
        guard let error = errorCode else {
            presentAlert(message: Utilities.ManageError.undefinedError.rawValue)
            return
        }
        //popup display
        presentAlert(message: error.rawValue)
    }

    internal func toggleFavoriteStatus(recipe: RecipleaseStruct) -> RecipleaseStruct {
        var modifiedRecipe = recipe

        switch modifiedRecipe.favorite {
        case false:
            modifiedRecipe.favorite = true
            StoredFavorite.save(recipe: modifiedRecipe.id)
        case true:
            modifiedRecipe.favorite = false
            StoredFavorite.Delete(idRecipe: modifiedRecipe.id)
        }
        return modifiedRecipe
    }

    internal func refreshFavoriteColor(button: UIButton, recipe: RecipleaseStruct) {
        if recipe.favorite {
            button.tintColor = UIColor(red: 0.2937839031, green: 0.6239609122, blue: 0.4135306478, alpha: 1)
        } else {
            button.tintColor = UIColor(named:"white")
        }
    }
}
