//
//  RecipeViewController.swift
//  Reciplease
//
//  Created by Laurent Debeaujon on 08/11/2020.
//

import UIKit

class RecipeViewController: UIViewController, VCUtilities {

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

    @IBAction func directionButtonTapped(_ sender: UIButton) {
        print("test")
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

    private func setFavoriteStatus() {
        switch recipe.favorite {
        case true:
            favorite.tintColor = UIColor(red: 0.2937839031, green: 0.6239609122, blue: 0.4135306478, alpha: 1)
        case false:
            favorite.tintColor = UIColor(named:"white")
        }
    }
    private func toggleFavorite() {

        switch recipe.favorite {
        case false:
            recipe.favorite = true
            StoredFavorite.save(recipe: recipe.id)
        case true:
            recipe.favorite = false
            StoredFavorite.Delete(idRecipe: recipe.id)
        }
        setFavoriteStatus()
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
