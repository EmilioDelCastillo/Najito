//
//  ViewController.swift
//  Najito
//
//  Created by Emilio Del Castillo on 19/03/2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var cocktails = [Cocktail]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        searchByName()
        
    }
    
    func searchByName(name: String = "A") {
        cocktails.removeAll()
        NetworkManager.shared.searchBy(.name, name) { result in
            switch result {
            case .success(let res):
                res.drinks.forEach { (dict) in
                    let name = dict["strDrink"]!
                    let id = dict["idDrink"]!
                    let thumbURL = dict["strDrinkThumb"]!
                    let cocktail = Cocktail(identifier: id, name: name, imageThumb: thumbURL)
                    self.cocktails.append(cocktail)
                }
                
            case .failure(let error):
                print(error.rawValue)
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func searchByIngredient(name: String) {
        cocktails.removeAll()
        NetworkManager.shared.searchBy(.ingredient, name) { (result) in
            switch result {
            case .success(let res):
                res.drinks.forEach { (dict) in
                    let name = dict["strDrink"]!
                    let id = dict["idDrink"]!
                    let thumbURL = dict["strDrinkThumb"]!
                    let cocktail = Cocktail(identifier: id, name: name, imageThumb: thumbURL)
                    self.cocktails.append(cocktail)
                }
                
            case .failure(let error):
                print(error.rawValue)
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
