//
//  API.swift
//  fetchMealApp
//
//  Created by Carlos Morales III on 7/30/24.
//

import Foundation

class API {
    var error = true
    var error2 = true
    
    enum APIError: Error {
        case serverError
        case invalidJSONResponse
        case badURL
    }
    
    enum EndPoint {
        static let baseURL = URL(string: "https://themealdb.com/api/json/v1/1/")
        
        case mealType(MealType)
        case mealId(String)
        
        var url: URL? {
            switch self {
            case let .mealType(mealType):
                let extendedURL = EndPoint.baseURL?.appending(path: "filter.php")
                return extendedURL?.appending(queryItems: [URLQueryItem(name: "c", value: mealType.rawValue)])
            case let .mealId(id):
                let extendedURL = EndPoint.baseURL?.appending(path: "lookup.php")
                return extendedURL?.appending(queryItems: [URLQueryItem(name: "i", value: id)])
            }
        }
    }
    
    #warning("Look into whether this is needed or not")
    @MainActor
    func fetchMeals(ofType type: MealType) async throws -> [Meal] {
        if error {
            error = false
            throw APIError.badURL
        }
        guard let url = EndPoint.mealType(type).url else {
            throw APIError.badURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw APIError.serverError
        }
        
        guard let meals = try? JSONDecoder().decode(MealData.self, from: data).meals else {
            throw APIError.invalidJSONResponse
        }
        
        return meals
    }
    
    
    @MainActor
    func fetchMeal(id: String) async throws -> MealDetails {
        if error2 {
            error2 = false
            throw APIError.badURL
        }
        guard let url = EndPoint.mealId(id).url else {
            throw APIError.badURL
        }
                
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw APIError.serverError
        }
        
        guard let mealDetails = try? JSONDecoder().decode(MealDetailsData.self, from: data) else {
            throw APIError.invalidJSONResponse
        }
        
        return mealDetails.meals.first!
    }
}
