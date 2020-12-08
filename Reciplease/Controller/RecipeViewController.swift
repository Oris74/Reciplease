//
//  RecipeViewController.swift
//  Reciplease
//
//  Created by Laurent Debeaujon on 08/11/2020.
//

import UIKit

class RecipeViewController: UIViewController, VCUtilities {
    weak var ListRecipeDelegate: ListRecipeViewController?
    var recipe: RecipleaseStruct!

    @IBOutlet weak var favorite: UIButton!
    @IBOutlet weak var imageRecipe: UIImageView!
    @IBOutlet weak var descriptionRecipe: UITextView!
    @IBOutlet weak var titleRecipe: UILabel!
    @IBOutlet weak var yieldRecipe: UILabel!
    @IBOutlet weak var timeRecipe: UILabel!

    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        toggleFavorite()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {

        titleRecipe.text = recipe.name
        timeRecipe.text = String(recipe.time)
        imageRecipe.load(url: recipe.image ?? "")
        descriptionRecipe.text = recipe.ingredients.map { " - " + String($0)}.joined(separator: "\n")
        yieldRecipe.text = String(recipe.portion)
        timeRecipe.text = String(recipe.time)

        if recipe.favorite {
            setToGreen(button: favorite)
        } else {
            setToWhite(button: favorite)
        }
        super.viewWillAppear(animated)
    }

    private func toggleFavorite() {
        switch self.recipe.favorite {
        case false:
            self.recipe.favorite = true
            StoredFavorite.save(recipe: self.recipe.id)
            setToGreen(button: favorite)
        case true:
            recipe.favorite = false
            StoredFavorite.Delete(idRecipe: self.recipe.id)
            setToWhite(button: favorite)
        }
        updateParentList()
    }

    func updateParentList() {
        if let listRecipeVC = self.ListRecipeDelegate {
            for (index, recipe) in listRecipeVC.recipes.enumerated()
            where recipe.id == self.recipe.id {
                listRecipeVC.recipes[index].favorite = self.recipe.favorite
            }
            listRecipeVC.tableview.reloadData()
        }
    }
}

extension RecipeViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToWebView" {
            let recipeVC = segue.destination as! WebViewController
            recipeVC.recipeURL = recipe.urlOrigin
        }
    }
}
