//
//  RecipeTableViewCell.swift
//  Reciplease
//
//  Created by Laurent Debeaujon on 10/11/2020.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {
    weak var cellDelegate: PassDataToVC?

    @IBOutlet weak var titleRecipe: UILabel!
    @IBOutlet weak var detailRecipe: UILabel!
    @IBOutlet weak var imageRecipe: UIImageView!
    @IBOutlet weak var yield: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var favorite: UIButton!

    @IBAction func favoriteButton(_ sender: UIButton) {
        cellDelegate?.didButtonPressed(cell: self)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
