//
//  APIRecipeDataSource.swift
//  MaraFetch
//
//  Created by ENMANUEL TORRES on 20/12/24.
//

import Foundation

class APIRecipeDataSource {
    private let httpClient : HTTPClientType
    private let baseUrl = "https://d3jbb8n5wk0qxi.cloudfront.net/"
    
    init(httpClient: HTTPClientType) {
        self.httpClient = httpClient
    }
}

extension APIRecipeDataSource: ApiDatasourceRecipeType {
    func getDessertList() async -> Result<[RecipeDTO], DataError> {
        
        //  let endPoint = "recipes-empty.json"
        let endPoint = "recipes.json"
        
        
        
        let result = await httpClient.makeRequest(endPoint: endPoint, baseUrl: baseUrl)
        
        guard case .success(let data) = result else {
            return .failure(.dataError)
        }
        
        guard let recipesList = try? JSONDecoder().decode(RecipesDTO.self, from: data) else {
            return .failure(.decodingError)
        }
        
        let validRecipeList = recipesList.recipes.compactMap{ $0 }
        
        guard !validRecipeList.isEmpty else {
            return .failure(.emptyData)
        }
        
        return .success(recipesList.recipes.sorted(by: {$0.name < $1.name}))
    }
    
    
}
