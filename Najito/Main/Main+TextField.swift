//
//  Main+TextField.swift
//  Najito
//
//  Created by Emilio Del Castillo on 24/03/2021.
//

import UIKit

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == 1 {return true}
        let name = textField.text?.appending(string)
        
        // If the user has just erased everything with backspace
        if range == NSRange(location: 0, length: 1) {
            // Clear!
            searchByName(name: "A")
            
        } else {
            searchByName(name: name!)
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 1 {
            let name = textField.text
            searchByIngredient(name: name!)
        }
        textField.resignFirstResponder()
        return true
    }
}
