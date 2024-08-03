//
//  MealDetailsViewModel.swift
//  fetchMealApp
//
//  Created by Carlos Morales III on 7/30/24.
//

import Foundation

class MealDetailsViewModel: ObservableObject {
    var recipeDetails = 
    private var api = API()
    
    init(selectedMeal: Meal) {
        self.selectedMeal = selectedMeal
    }
    
    func fetchSelectedMealDetails(_ meal: Meal) async throws {
        
    }
    
    
}
