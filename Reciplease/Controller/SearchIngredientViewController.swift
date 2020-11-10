//
//  SearchIngredientViewController.swift
//  Reciplease
//
//  Created by Laurent Debeaujon on 08/11/2020.
//

import UIKit
//import CoreData

class SearchIngredientViewController: UIViewController, VCUtilities {
    @IBOutlet weak var ingredientField: UITextField!

    @IBOutlet weak var ingredientsList: UITextView!

    @IBAction func addButtonTapped(_ sender: Any) {
        guard let ingredient = ingredientField.text else { return }
        Ingredient.addToFridge(new: ingredient)
        ingredientField.text = ""
        dislayIngredientsList()
    }

    @IBAction func clearButtonTapped(_ sender: UIButton) {
        Ingredient.emptyFridge()
        dislayIngredientsList()
    }

    @IBAction func searchButtonTapped(_ sender: Any) {

    }

    override func viewDidLoad() {
        self.ingredientField.delegate = self
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        dislayIngredientsList()
        super.viewDidAppear(animated)
    }

   internal func dislayIngredientsList() {
        var ingredientsText = ""
        for ingredient in Ingredient.all {
            if let name = ingredient.name {
                ingredientsText += "- " + name + "\n"
            }
        }
        ingredientsList.text = ingredientsText
        }
}
