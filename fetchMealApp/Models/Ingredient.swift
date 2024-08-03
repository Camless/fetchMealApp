//
//  Ingredient.swift
//  fetchMealApp
//
//  Created by Carlos Morales III on 7/30/24.
//

import Foundation

struct Ingredient: Identifiable {
    let id = UUID()
    let name: String
    let measurement: String
}
