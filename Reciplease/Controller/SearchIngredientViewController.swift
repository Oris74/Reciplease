//
//  SearchIngredientViewController.swift
//  Reciplease
//
//  Created by Laurent Debeaujon on 08/11/2020.
//

import UIKit
//import CoreData

class SearchIngredientViewController: UIViewController, VCUtilities {

    let recipesService: RecipesService = EdamamService.shared

    let fridgeService = FridgeService.shared

    private var fridgeContent: String

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var ingredientField: UITextField!
    @IBOutlet weak var ingredientsList: UITextView!
    @IBOutlet weak var searchButton: UIButton!

    @IBAction func addButtonTapped(_ sender: UIButton) {

        guard let ingredient = ingredientField.text else { return }
        fridgeService.getFoodTapped(new: ingredient)
        ingredientField.text = ""
        dislayFridgeList()
    }

    @IBAction func clearButtonTapped(_ sender: UIButton) {
        fridgeService.cleanFridge()
        dislayFridgeList()
    }

    @IBAction func searchButtonTapped(_ sender: UIButton) {
        sender.isEnabled = false
        toggleActivityIndicator(shown: true)
        fridgeContent = fridgeService.fridge.stringOfIngredients

        recipesService.getRecipes(ingredients: fridgeContent, callback: {[weak self] (recipesRange, error) in
            sender.isEnabled = true
            self?.toggleActivityIndicator(shown: false)
            guard let recipes = recipesRange else {
                self?.manageErrors(errorCode: error)
                return
            }

            if recipes.count > 0 {
                self?.presentList(with: recipes)
            } else {
                self?.manageErrors(errorCode: .noRecipeFound)
            }
        })
    }

    required init?(coder: NSCoder) {
        self.fridgeContent = ""
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        self.ingredientField.delegate = self
        toggleActivityIndicator(shown: false)
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        searchButton.isEnabled = true
        toggleActivityIndicator(shown: false)
        dislayFridgeList()
        super.viewDidAppear(animated)
    }

    internal func dislayFridgeList() {
        var ingredientsText = ""
        let ingredients = FridgeService.shared.fridge.ingredients
        for ingredient in ingredients {
            ingredientsText += "- " + ingredient.name + "\n"
        }
        ingredientsList.text = ingredientsText
    }

    private func toggleActivityIndicator(shown: Bool) {
        activityIndicator.isHidden = !shown
    }

    private func presentList(with recipes: [RecipleaseStruct]) {

        guard let listRecipeVC = getListRecipeVC() as? ListRecipeViewController else { return }

        listRecipeVC.recipes = recipes
        self.navigationController?.pushViewController(listRecipeVC, animated: true)
    }

    private func getListRecipeVC() -> UIViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let listRecipeVC = storyboard.instantiateViewController(identifier: "ListRecipeViewController") as? ListRecipeViewController
        else { return nil }
        return listRecipeVC
    }
}
