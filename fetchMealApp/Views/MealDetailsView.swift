//
//  RecipeDetailsView.swift
//  fetchMealApp
//
//  Created by Carlos Morales III on 7/30/24.
//

import SwiftUI

struct MealDetailsView: View {
    @ObservedObject var viewModel: MealDetailsViewModel
    @Binding var presentingSheet: Bool
    
    var body: some View {
        ScrollView {
            VStack {
                Spacer()
                Text("Instructions")
                    .padding(.leading, 16)
                    .padding(.bottom, 16)
                    .bold()
                Text("")
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
                    .padding(.bottom, 16)
                Text("Ingredients")
                    .padding(.bottom)
                    .bold()
//                ForEach(viewModel.ingredients) {
//                    Text("\($0.measurement) \($0.name)")
//                }
            }
        }
    }
}

#Preview {
    MealDetailsView(viewModel: MealDetailsViewModel(selectedMeal: Meal(name: "Meal One",
                                                                           mealIdentifier: "123")),
                      presentingSheet: .constant(true))
}
