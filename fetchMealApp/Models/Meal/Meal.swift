//
//  Recipe.swift
//  fetchMealApp
//
//  Created by Carlos Morales III on 7/30/24.
//

import Foundation

struct Meal: Identifiable, Decodable, Hashable {
    var id = UUID()
    let name: String
    let mealIdentifier: String
    
    private enum CodingKeys: String, CodingKey {
        case name = "strMeal"
        case mealIdentifier = "idMeal"
    }
}
