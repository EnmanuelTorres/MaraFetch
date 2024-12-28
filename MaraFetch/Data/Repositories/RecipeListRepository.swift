//
//  RecipeListRepository.swift
//  MaraFetch
//
//  Created by ENMANUEL TORRES on 20/12/24.
//

import Foundation

protocol DessertListRepositoryType {
    func getRecipeList() async -> Result<[Recipe], DataError>
}

class RecipeListRepository:  DessertListRepositoryType {
    
    private let apiDataSource: ApiDatasourceRecipeType
    private let recipeMapper: RecipeMapper
    private let cacheDataSource: RecipeListCacheType
    
    init(apiDataSource: ApiDatasourceRecipeType, recipeMapper: RecipeMapper, cacheDataSource: RecipeListCacheType) {
        self.apiDataSource = apiDataSource
        self.recipeMapper = recipeMapper
        self.cacheDataSource = cacheDataSource
    }
    
    
    func getRecipeList() async -> Result<[Recipe], DataError> {
        
        let recipeListCache = await cacheDataSource.getRecipeList()
        
        if !recipeListCache.isEmpty {
            return .success(recipeListCache)
        }
        
        
        let result:  Result<[RecipeDTO], DataError> =  await apiDataSource.getDessertList()
        guard case .success(let recipeList) = result else {
            return .failure(result.failureCase as! DataError)
        }
        let mappedRecipeList = recipeMapper.map(dto: recipeList)
        
        await cacheDataSource.saveRecipeList(recipeList: mappedRecipeList)
        
        return .success(mappedRecipeList)
    }
    
    
}
