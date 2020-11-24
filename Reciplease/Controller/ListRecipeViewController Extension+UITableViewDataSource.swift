//
//  ListRecipeViewController Extension+.swift
//  Reciplease
//
//  Created by Laurent Debeaujon on 10/11/2020.
//

import UIKit

// MARK: - Table view data source
extension ListRecipeViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as! RecipeTableViewCell
        let recipe = recipes[indexPath.row]

        cell.titleRecipe.text = recipe.name
        cell.detailRecipe.text = recipe.ingredients.joined(separator: ", ")

        cell.imageRecipe.load(url: recipe.image ?? "")

        cell.time.text = String(recipe.time)
        cell.yield.text = String(recipe.portion)

        return cell
    }
}

extension ListRecipeViewController: UITableViewDelegate {
    private func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.indexSelectedRow = indexPath
        self.performSegue(withIdentifier: "segueToDetailledRecipe", sender: indexPath)
    }
}