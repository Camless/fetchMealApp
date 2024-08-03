//
//  MealListViewModel.swift
//  fetchMealApp
//
//  Created by Carlos Morales III on 7/30/24.
//

import Foundation

@MainActor
class MealListViewModel: ObservableObject {
    @Published var currentMeals: [Meal] = []
    @Published var loadingState: LoadingState = .loading
    
    private let api: API
    
    init(api: API) {
        self.api = api
    }
    
    func fetchMeals() async throws {
        loadingState = .loading
        currentMeals = try await api.fetchMeals(ofType: .dessert)
        currentMeals.sort { $0.name < $1.name }
        loadingState = .loaded
    }
    
    func setErrorState() {
        loadingState = .error
    }
}
