//
//  Main+TableView.swift
//  Najito
//
//  Created by Emilio Del Castillo on 24/03/2021.
//

import UIKit

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cocktails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: "cocktail cell", for: indexPath) as! CocktailCell
        
        dequeuedCell.cocktailName.text = cocktails[indexPath.row].name
        
        // Get the thumbnail
        DispatchQueue.global(qos: .userInteractive).async {
            
            let url = URL(string: self.cocktails[indexPath.row].imageThumb!.appending("/preview"))!
            let image = try? UIImage(data: Data(contentsOf: url))
            DispatchQueue.main.async {
                dequeuedCell.cocktailThumb.image = image
                dequeuedCell.cocktailThumb.contentMode = .scaleAspectFill
            }
        }
        dequeuedCell.layoutIfNeeded()
        return dequeuedCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "show details", sender: tableView.cellForRow(at: indexPath))
    }
}
