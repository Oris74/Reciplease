//
//  RecipeViewController.swift
//  Reciplease
//
//  Created by Laurent Debeaujon on 08/11/2020.
//

import UIKit

class RecipeViewController: UIViewController, VCUtilities {
    weak var delegate: PassDataToVC?

    var recipe: RecipleaseStruct!

    @IBOutlet weak var favorite: UIButton!
    @IBOutlet weak var imageRecipe: UIImageView!
    @IBOutlet weak var descriptionRecipe: UITextView!
    @IBOutlet weak var titleRecipe: UILabel!
    @IBOutlet weak var yieldRecipe: UILabel!
    @IBOutlet weak var timeRecipe: UILabel!

    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        self.recipe = toggleFavoriteStatus(recipe: self.recipe)
        delegate?.sendToVC(updatedRecipe: self.recipe)
        refreshFavoriteColor(button: favorite, recipe: self.recipe)
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

        refreshFavoriteColor(button: favorite, recipe: recipe)

        super.viewWillAppear(animated)
    }

   /* private func toggleFavorite() {
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

    }*/
}

extension RecipeViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToWebView" {
            let recipeVC = segue.destination as! WebViewController
            recipeVC.recipeURL = recipe.urlOrigin
        }
    }
}
