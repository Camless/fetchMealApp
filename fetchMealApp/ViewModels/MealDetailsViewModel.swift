//
//  MealDetailsViewModel.swift
//  fetchMealApp
//
//  Created by Carlos Morales III on 7/30/24.
//

import Foundation

@MainActor
class MealDetailsViewModel: ObservableObject {
    @Published var mealDetails = MealDetails()
    @Published var loadingState: LoadingState = .loading
    
    let selectedMeal: Meal
    private let api: API
    
    init(selectedMeal: Meal, api: API) {
        self.selectedMeal = selectedMeal
        self.api = api
    }
    
    func fetchSelectedMealDetails() async throws {
        loadingState = .loading
        mealDetails = try await api.fetchMeal(id: selectedMeal.mealIdentifier)
        loadingState = .loaded
    }
    
    func setErrorState() {
        loadingState = .error
    }
}
