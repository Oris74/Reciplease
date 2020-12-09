//
//  ViewDelegate.swift
//  Reciplease
//
//  Created by Laurent Debeaujon on 08/12/2020.
//

import UIKit

protocol PassDataToVC: AnyObject {
    func sendToVC(updatedRecipe: RecipleaseStruct)
    func didButtonPressed( cell: RecipeTableViewCell)
}
