//
//  MealDetail.swift
//  fetchMealApp
//
//  Created by Carlos Morales III on 7/30/24.
//

import Foundation

struct MealDetails: Identifiable, Decodable {
    var id = UUID()
    let mealName: String
    let instructions: String
    var ingredients: [Ingredient]
    
    init() {
        mealName = ""
        instructions = ""
        ingredients = [Ingredient]()
    }
    
    enum CodingKeys: String, CodingKey {
        case mealName = "strMeal"
        case instructions = "strInstructions"
    }
    
    struct IngredientNameKey: CodingKey {
        private let key: String
        var intValue: Int? { nil }
        var stringValue: String { key }
        
        private init(_ key: String) {
            self.key = key
        }
        
        init?(stringValue: String) {
            if stringValue.hasPrefix("strIngredient") {
                self = .init(stringValue)
            } else {
                return nil
            }
        }
        
        init?(intValue: Int) { nil }
        
        public static func < (lhs: IngredientNameKey, rhs: IngredientNameKey) -> Bool {
            lhs.stringValue < rhs.stringValue
        }
    }
    
    struct IngredientMeasurementKey: CodingKey {
        private let key: String
        var intValue: Int? { nil }
        var stringValue: String { key }
        
        private init(_ key: String) {
            self.key = key
        }
        
        init?(stringValue: String) {
            if stringValue.hasPrefix("strMeasure") {
                self = .init(stringValue)
            } else {
                return nil
            }
        }
        
        init?(intValue: Int) {
            nil
        }
        
        public static func < (lhs: IngredientMeasurementKey, rhs: IngredientMeasurementKey) -> Bool {
            lhs.stringValue < rhs.stringValue
        }
    }
}

extension MealDetails {
    init(from decoder: any Decoder) throws {
        
        let mealDictionary = try decoder.container(keyedBy: CodingKeys.self)
        mealName = try mealDictionary.decode(String.self, forKey: .mealName)
        instructions = try mealDictionary.decode(String.self, forKey: .instructions)
        
        var fetchedIngredients = [Ingredient]()
        
        let ingredientNameContainer = try decoder.container(keyedBy: IngredientNameKey.self)
        let ingredientMeasurementContainer = try decoder.container(keyedBy: IngredientMeasurementKey.self)
        
        let sortedIngredientNameContainerKeys = ingredientNameContainer.allKeys.sorted { $0 < $1 }
        let sortedIngredientMeasurementContainerKeys = ingredientMeasurementContainer.allKeys.sorted { $0 < $1 }
        
        for (nameKey, measurementKey) in zip(sortedIngredientNameContainerKeys, sortedIngredientMeasurementContainerKeys) {
            if let nameValue = try ingredientNameContainer.decodeIfPresent(String.self, forKey: nameKey), let measurementValue = try ingredientMeasurementContainer.decodeIfPresent(String.self, forKey: measurementKey), !nameValue.isEmpty, !measurementValue.isEmpty {
                let fetchedIngredient = Ingredient(name: nameValue, measurement: measurementValue)
                fetchedIngredients.append(fetchedIngredient)
            }
        }
        
        ingredients = fetchedIngredients
    }
}
