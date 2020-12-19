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

    @IBOutlet weak var viewInfo: UIView!
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
        self.viewInfo.layer.borderWidth = 1
        self.viewInfo.layer.borderColor = UIColor.white.cgColor
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
}

extension RecipeViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToWebView" {
            let recipeVC = segue.destination as! WebViewController
            recipeVC.recipeURL = recipe.urlOrigin
        }
    }
}
