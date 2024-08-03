//
//  fetchMealAppApp.swift
//  fetchMealApp
//
//  Created by Carlos Morales III on 7/30/24.
//

import SwiftUI

@main
struct fetchMealAppApp: App {
    
    let api = API()
    var body: some Scene {
        WindowGroup {
            let mealListViewModel = MealListViewModel(api: api)
            MealListView(viewModel: mealListViewModel)
        }
        .environmentObject(api)
    }
}
