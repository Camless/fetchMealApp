//
//  RecipeListViewModel.swift
//  fetchMealApp
//
//  Created by Carlos Morales III on 7/30/24.
//

import Foundation

class MealListViewModel: ObservableObject {
    @Published var currentRecipes: [Meal] = []
}
