//
//  RecipeViewController.swift
//  Reciplease
//
//  Created by Laurent Debeaujon on 08/11/2020.
//

import UIKit

class RecipeViewController: UIViewController, VCUtilities {
    weak var delegate: ListRecipeViewController?
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
        super.viewWillAppear(animated)
        titleRecipe.text = recipe.name
        timeRecipe.text = String(recipe.time)
        imageRecipe.load(url: recipe.image ?? "")
        descriptionRecipe.text = recipe.ingredients.map { " - " + String($0)}.joined(separator: "\n")
        yieldRecipe.text = String(recipe.portion)
        timeRecipe.text = String(recipe.time)

        setFavoriteStatus()
    }
    override func didMove(toParent parent: UIViewController?) {
        if let listRecipesVC = self.delegate {
            for (index, recipeVC) in listRecipesVC.recipes.enumerated()
            where self.recipe.id == recipeVC.id {
                    listRecipesVC.recipes[index].favorite = self.recipe.favorite
                }
            }
    }

    private func toggleFavorite() {
        switch self.recipe.favorite {
        case false:
            self.recipe.favorite = true
            StoredFavorite.save(recipe: self.recipe.id)

        case true:
            recipe.favorite = false
            StoredFavorite.Delete(idRecipe: self.recipe.id)
        }
        setFavoriteStatus()
        updateParentList()
    }

    private func setFavoriteStatus() {
        switch recipe.favorite {
        case true:
            favorite.tintColor = UIColor(red: 0.2937839031, green: 0.6239609122, blue: 0.4135306478, alpha: 1)
        case false:
            favorite.tintColor = UIColor(named:"white")
        }
    }

    func updateParentList() {
        if let listRecipeVC = self.parent as? ListRecipeViewController {
            for (index, recipe) in listRecipeVC.recipes.enumerated()
            where recipe.id == self.recipe.id {
                listRecipeVC.recipes[index].favorite = self.recipe.favorite
            }
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
