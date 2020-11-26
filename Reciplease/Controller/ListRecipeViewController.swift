//
//  SearchTableViewController.swift
//  Reciplease
//
//  Created by Laurent Debeaujon on 08/11/2020.
//

import UIKit

class ListRecipeViewController: UIViewController, VCUtilities {
    var recipes:[RecipleaseStruct]!
    var indexSelectedRow = NSIndexPath()

    @IBOutlet weak var tableview: UITableView!

    @IBAction func segueRecipeViewController(_ sender: UIStoryboardSegue) {
    
        if let recipeViewController = sender.source as? RecipeViewController {
            updateRecipe(recipeToUPD: recipeViewController.recipe)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.delegate = self
        self.tableview.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableview.reloadData()
    }

    func updateRecipe(recipeToUPD: RecipleaseStruct) {
        for (index, recipe) in recipes.enumerated() {
            if recipe.id == recipeToUPD.id {
                recipes[index].favorite = recipeToUPD.favorite
            }
        }
    }
}

extension ListRecipeViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDetailledRecipe" {
            let recipeVC = segue.destination as! RecipeViewController
            if let selectedRecipe = self.tableview.indexPathForSelectedRow {
                recipeVC.recipe = recipes[selectedRecipe.row]
            } else { return }
        }
    }
}
