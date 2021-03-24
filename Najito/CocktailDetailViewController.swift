//
//  CocktailDetailViewController.swift
//  Najito
//
//  Created by Emilio Del Castillo on 20/03/2021.
//

import UIKit

class CocktailDetailViewController: UIViewController {
    
    @IBOutlet weak var cocktailPicture: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var IBALabel: UILabel!
    @IBOutlet weak var glassLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var instructionsLabel: UILabel!
    
    var cocktailID: String!
    var imageUrl: URL!
    var dateModified: String!
    var cocktailName: String!
    var cocktailCategory: String!
    var IBA: String!
    var glass: String!
    var ingredients: String!
    var instructions: String!
    
    var cocktail: Cocktail!

    override func viewDidLoad() {
        super.viewDidLoad()
        getCocktail(identifier: cocktailID)
    }
    
    func getCocktail(identifier: String) {
        NetworkManager.shared.searchBy(.identifier, identifier) { (result) in
            switch result {
            case .success(let res):
                let cocktailDict = res.drinks[0]
                
                let urlString           = cocktailDict["strDrinkThumb"]!
                self.imageUrl           = URL(string: urlString!)
                self.dateModified       = cocktailDict["dateModified"]!
                self.cocktailName       = cocktailDict["strDrink"]!
                self.cocktailCategory   = cocktailDict["strCategory"]!
                self.IBA                = cocktailDict["strIBA"]!
                self.glass              = cocktailDict["strGlass"]!
                self.instructions       = cocktailDict["strInstructions"]!
                
                self.ingredients = String()
                for i in 1...15 {
                    if let ingredient = cocktailDict["strIngredient\(i)"]!, let measure = cocktailDict["strMeasure\(i)"]! {
                        self.ingredients.append("\(ingredient): \(measure)\n")
                    }
                }
                
                self.updateUI()
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    func updateUI() {
        // Get the picture
        DispatchQueue.global(qos: .userInteractive).async {
            
            let url = self.imageUrl!
            let image = try? UIImage(data: Data(contentsOf: url))
            DispatchQueue.main.async {
                self.cocktailPicture.image = image
                self.cocktailPicture.contentMode = .scaleAspectFill
            }
        }
        
        DispatchQueue.main.async {
            self.dateLabel.text             = self.dateModified
            self.nameLabel.text             = self.cocktailName
            self.categoryLabel.text         = self.cocktailCategory
            self.IBALabel.text              = self.IBA ?? "None"
            self.glassLabel.text            = self.glass
            self.ingredientsLabel.text      = self.ingredients
            self.instructionsLabel.text     = self.instructions
        }
    }

}
