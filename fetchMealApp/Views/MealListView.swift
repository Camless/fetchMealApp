//
//  ContentView.swift
//  fetchMealApp
//
//  Created by Carlos Morales III on 7/30/24.
//

import SwiftUI

struct MealListView: View {
    
    @StateObject private var viewModel = RecipeListViewModel()
    @State private var presentingSheet: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.currentRecipes) { recipe in
                    NavigationLink(destination: RecipeDetailsView(viewModel: RecipeDetailsViewModel(recipeDetail: RecipeDetail),
                                                                  presentingSheet: $presentingSheet),
                                   label: { 
                        Text(recipe.name)
                    })
                }
            }
            .navigationTitle("Recipes")
        }
    }
}

#Preview {
    MealListView()
}
