//
//  apiDataSourceStub.swift
//  MaraFetchTests
//
//  Created by ENMANUEL TORRES on 28/12/24.
//

import Foundation
@testable import MaraFetch

class apiDataSourceStub {
    private let recipeList: Result<[RecipeDTO], DataError>
    
    init(recipeList: Result<[RecipeDTO], DataError>) {
        self.recipeList = recipeList
    }
    
}


extension apiDataSourceStub: ApiDatasourceRecipeType {
    func getDessertList() async -> Result<[MaraFetch.RecipeDTO], MaraFetch.DataError> {
        return recipeList
    }
}
