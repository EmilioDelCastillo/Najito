//
//  Main+Navigation.swift
//  Najito
//
//  Created by Emilio Del Castillo on 24/03/2021.
//

import UIKit

extension ViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show details" {
            
            let cell = sender as! CocktailCell
            let index = (tableView.indexPath(for: cell)!).row
            let cocktail = cocktails[index]
            if let detailsVC = segue.destination as? CocktailDetailViewController {
                detailsVC.cocktailID = cocktail.identifier
            }
        }
    }
}
