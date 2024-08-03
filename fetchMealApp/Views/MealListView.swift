//
//  MealListView.swift
//  fetchMealApp
//
//  Created by Carlos Morales III on 7/30/24.
//

import SwiftUI

struct MealListView: View {
    
    @StateObject var viewModel: MealListViewModel
    @EnvironmentObject var api: API
    @State private var path = [Meal]()
    
    var body: some View {
        switch viewModel.loadingState {
        case .loaded:
            NavigationStack(path: $path) {
                List {
                    ForEach(viewModel.currentMeals, id: \.self) { meal in
                        NavigationLink(value: meal) {
                            Text(meal.name)
                        }
                    }
                }
                .navigationDestination(for: Meal.self, destination: { meal in
                    let recipeDetailsViewModel = MealDetailsViewModel(selectedMeal: meal, api: api)
                    MealDetailsView(viewModel: recipeDetailsViewModel, path: $path)
                })
                .navigationTitle("Recipes")
            }
        case .loading:
            ProgressView()
                .task {
                    do {
                        try await viewModel.fetchMeals()
                    } catch {
                        if !Task.isCancelled {
                            viewModel.setErrorState()
                        }
                    }
                }
        case .error:
            Color(.clear)
                .alert("Error Loading!", isPresented: .constant(true), actions: {
                    Button("Retry") {
                        Task {
                            try await viewModel.fetchMeals()
                        }
                    }
                })
            
        }
    }
}

#Preview {
    MealListView(viewModel: MealListViewModel(api: API()))
}
