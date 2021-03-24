//
//  Cocktail.swift
//  Najito
//
//  Created by Emilio Del Castillo on 19/03/2021.
//

import Foundation

struct Cocktail: Codable {
    var identifier: String?
    var name: String?
    var glass: String?
    var ingredients: [String: String]? // Ingredient: measure
    var instructions: String?
    var category: String?
    var tags: String?
    var imageAttribution: String?
    var dateModified: String?
    var IBA: String?// International Bartenders Association
    var imageSource: String?
    var imageThumb: String?
    var CreativeCommonsConfirmed: String?
}

struct APIResults: Codable {
    var drinks: [[String: String?]]
}
