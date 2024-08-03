//
//  RecipeDetailsView.swift
//  fetchMealApp
//
//  Created by Carlos Morales III on 7/30/24.
//

import SwiftUI

struct MealDetailsView: View {
    @StateObject var viewModel: MealDetailsViewModel
    @Binding var path: [Meal]
    
    var body: some View {
        switch viewModel.loadingState {
        case .loading:
            ProgressView()
                .task {
                    do {
                        try await viewModel.fetchSelectedMealDetails()
                    } catch {
                        if !Task.isCancelled {
                            viewModel.setErrorState()
                        }
                    }
                }
                .navigationTitle(viewModel.selectedMeal.name)
                .navigationBarTitleDisplayMode(.inline)
        case .loaded:
            ScrollView {
                Spacer()
                VStack {
                    HStack {
                        Text("Instructions")
                            .frame(alignment: .leading)
                            .padding(.bottom, 16)
                            .padding(.leading, 16)
                            .bold()
                        Spacer()
                    }
                    Text(viewModel.mealDetails.instructions)
                        .padding(.leading, 16)
                        .padding(.trailing, 16)
                        .padding(.bottom, 16)
                    HStack {
                        Text("Ingredients")
                            .padding(.bottom)
                            .padding(.leading, 16)
                            .bold()
                        Spacer()
                    }
                    ForEach(viewModel.mealDetails.ingredients) { ingredient in
                        HStack {
                            Text("\(ingredient.measurement) \(ingredient.name)")
                                .padding(.leading, 16)
                            Spacer()
                        }
                        Spacer()
                    }
                    
                }
            }
            .navigationTitle(viewModel.mealDetails.mealName)
            .navigationBarTitleDisplayMode(.inline)
        case .error:
            Color(.clear)
                .alert("Error Loading!", isPresented: .constant(true), actions: {
                    Button("Back") {
                        path.removeAll()
                    }
                    Button("Retry") {
                        Task {
                            try await viewModel.fetchSelectedMealDetails()
                        }
                    }
                })
        }
    }
}

#Preview {
    MealDetailsView(viewModel: MealDetailsViewModel(selectedMeal: Meal(name: "Meal One",
                                                                       mealIdentifier: "123"),
                                                    api: API()),
                    path: .constant([Meal(name: "Name", mealIdentifier: "123")]))
}
