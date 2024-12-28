//
//  RecipeListCacheType.swift
//  MaraFetch
//
//  Created by ENMANUEL TORRES on 20/12/24.
//

import Foundation

protocol RecipeListCacheType {
    func getRecipeList() async -> [Recipe]
    func saveRecipeList(recipeList: [Recipe]) async
}
