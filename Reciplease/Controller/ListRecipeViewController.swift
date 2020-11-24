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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.delegate = self
        self.tableview.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableview.reloadData()
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
