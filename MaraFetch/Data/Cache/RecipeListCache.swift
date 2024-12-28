//
//  RecipeListCache.swift
//  MaraFetch
//
//  Created by ENMANUEL TORRES on 20/12/24.
//

import Foundation

class RecipeListCache: RecipeListCacheType {
    
    private let recipeListKey = "recipeListKey"
    
    func getRecipeList() async -> [Recipe] {
        if let data = UserDefaults.standard.data(forKey: recipeListKey) {
            let decoder = JSONDecoder()
            if let recipeList = try? decoder.decode([Recipe].self, from: data) {
                print("Get data from cache")
                return recipeList
            }
        }
        return []
    }
    
    func saveRecipeList(recipeList: [Recipe]) async {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(recipeList) {
            UserDefaults.standard.set(data, forKey: recipeListKey)
            print("Save data")
        }
    }
    
    
}
