//
//  CacheDataSourceStub.swift
//  MaraFetchTests
//
//  Created by ENMANUEL TORRES on 28/12/24.
//

import Foundation
@testable import MaraFetch

class CacheDataSourceStub: RecipeListCacheType {
    
    private let getRecipeList: [Recipe]
    var cachedRecipeList: [Recipe]?
    
    init(getRecipeList: [Recipe]) {
        self.getRecipeList = getRecipeList
    }
    
    
    func getRecipeList() async -> [Recipe] {
        return getRecipeList
    }
    
    func saveRecipeList(recipeList: [Recipe]) async {
        cachedRecipeList = recipeList
    }
    
    
}
