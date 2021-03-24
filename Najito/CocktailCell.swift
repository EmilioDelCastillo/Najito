//
//  CocktailCell.swift
//  Najito
//
//  Created by Emilio Del Castillo on 20/03/2021.
//

import UIKit

class CocktailCell: UITableViewCell {
    @IBOutlet weak var cocktailName : UILabel!
    
    @IBOutlet weak var cocktailThumb: UIImageView!
 
    override func prepareForReuse() {
        cocktailThumb.image = nil
    }
}
