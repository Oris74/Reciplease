//
//  SearchIngredientViewController+UITextFieldDelegate.swift
//  Reciplease
//
//  Created by Laurent Debeaujon on 09/11/2020.
//

import UIKit

// MARK: - Keyboard

extension SearchIngredientViewController: UITextFieldDelegate {

    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        ingredientField.resignFirstResponder()
    }

    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let ingredient = ingredientField.text else { return false }

        Ingredient.addToFridge(new: ingredient)
        ingredientField.text = ""
        textField.resignFirstResponder()
        dismissKeyboard()
        dislayIngredientsList()
        return true
    }
}
