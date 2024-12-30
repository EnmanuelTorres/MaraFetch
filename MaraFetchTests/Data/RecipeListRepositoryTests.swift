//
//  RecipeListRepositoryTests.swift
//  MaraFetchTests
//
//  Created by ENMANUEL TORRES on 28/12/24.
//

import XCTest
@testable import MaraFetch

final class MaraFetchTests: XCTestCase {
    
    func test_getRecipeList_returns_success_the_cache_is_empty() async throws {
        //Given
        let expectedRecipeList = Recipe.makeRecipeList()
        let recipeDTO = RecipeDTO.makeRecipeDTOList()
        
        let (sut, _) = makeSUT(apiDataSourceResult: .success(recipeDTO),
                               cachedValue: [])
        
        //When
        let result = await sut.getRecipeList()
        
        //Then
        let recipeList = try XCTUnwrap(result.get())
        XCTAssertEqual(recipeList, expectedRecipeList)
    }

    
    func test_getRecipeList_returns_success_when_cache_is_not_empty() async throws {
        //Given
        let expectedRecipeList = Recipe.makeRecipeList()
        
        let (sut, _) = makeSUT(apiDataSourceResult: .success([]),
                               cachedValue: Recipe.makeRecipeList())
        
        //When
        let result = await sut.getRecipeList()
        
        //Then
        
        let recipeList = try XCTUnwrap(result.get())
        
        XCTAssertEqual(recipeList, expectedRecipeList)
    }
    
    func test_getRecipeList_saves_in_cache_when_gets_data_from_apiDataSource() async throws {
        
      // Given
        
        let recipeDTO = RecipeDTO.makeRecipeDTOList()
        let expectedRecipeList = Recipe.makeRecipeList()
        
        let (sut, cacheDataSource) = makeSUT(apiDataSourceResult: .success(recipeDTO),
                                             cachedValue: [])

      // When
        _ = await sut.getRecipeList()
        
       // Then
        
        XCTAssertEqual(cacheDataSource.cachedRecipeList, expectedRecipeList)
      
    }
    
    func test_getRecipeList_returns_failure_when_there_is_empty_cache_and_apiDataSource_returns_URLError() async throws {
        
        //Given
        let (sut, _) = makeSUT(apiDataSourceResult: .failure(.URLError),
                               cachedValue: [])
        
        //When
        let result = await sut.getRecipeList()
        
        //Then
        
        guard case .failure(let failure) = result else {
            XCTFail("Expected failure, got success")
            return
        }

        
        XCTAssertEqual(failure, DataError.URLError)
    }
    
    func test_getRecipeList_returns_failure_when_there_is_empty_cache_and_apiDataSource_returns_dataError() async throws {
        
        //Given
        let (sut, _) = makeSUT(apiDataSourceResult: .failure(.dataError),
                               cachedValue: [])
        
        //When
        let result = await sut.getRecipeList()
        
        //Then
        
        guard case .failure(let failure) = result else {
            XCTFail("Expected failure, got success")
            return
        }

        
        XCTAssertEqual(failure, DataError.dataError)
    }
    
    func test_getRecipeList_returns_failure_when_there_is_empty_cache_and_apiDataSource_returns_decodingError() async throws {
        
        //Given
        let (sut, _) = makeSUT(apiDataSourceResult: .failure(.decodingError),
                               cachedValue: [])
        
        //When
        let result = await sut.getRecipeList()
        
        //Then
        
        guard case .failure(let failure) = result else {
            XCTFail("Expected failure, got success")
            return
        }

        
        XCTAssertEqual(failure, DataError.decodingError)
    }
    
    func test_getRecipeList_returns_failure_when_there_is_empty_cache_and_apiDataSource_returns_apiError() async throws {
        
        //Given
        let (sut, _) = makeSUT(apiDataSourceResult: .failure(.apiError),
                               cachedValue: [])
        
        //When
        let result = await sut.getRecipeList()
        
        //Then
        
        guard case .failure(let failure) = result else {
            XCTFail("Expected failure, got success")
            return
        }

        
        XCTAssertEqual(failure, DataError.apiError)
    }
    
    
    private func makeSUT(apiDataSourceResult: Result<[RecipeDTO], DataError>, cachedValue: [Recipe]) -> (sut: RecipeListRepository, cache: CacheDataSourceStub) {
        
        let apiDataSource = apiDataSourceStub(recipeList: apiDataSourceResult)
        
        let cacheDataSource = CacheDataSourceStub(getRecipeList: cachedValue)
        
        let sut = RecipeListRepository(apiDataSource: apiDataSource,
                                       recipeMapper: RecipeMapper(),
                                       cacheDataSource: cacheDataSource)
        
        
        return (sut: sut, cache: cacheDataSource)
    }

}

extension Recipe {
    static func makeRecipeList() -> [Recipe] {
        return [
            
            .init(id: "39ad8233-c470-4394-b65f-2a6c3218b935",
                  name: "Canadian Butter Tarts",
                  cuisine: "Canadian",
                  photoUrl: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/f18384e7-3da7-4714-8f09-bbfa0d2c8913/small.jpg"),
            
            .init(id: "7e529e52-f56d-49a2-938f-81aac853cc65",
                  name: "Carrot Cake",
                  cuisine: "British",
                  photoUrl: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/32afc698-d927-4a90-990f-ec25e9520c08/small.jpg"),
            
            .init(id: "7eeb0865-b41c-4a3b-80dd-a69d32dccc7d",
                  name: "Cashew Ghoriba Biscuits",
                  cuisine: "Tunisian",
                  photoUrl: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/9c7fa988-1bbe-4bed-9f1a-c9d4d8b311da/small.jpg"),
            
        ]
        
    }
}

extension RecipeDTO {
    static func makeRecipeDTOList() ->  [RecipeDTO] {
        return [
            .init(cuisine: "Canadian",
                  name: "Canadian Butter Tarts",
                  photoUrlLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/f18384e7-3da7-4714-8f09-bbfa0d2c8913/large.jpg",
                  photoUrlSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/f18384e7-3da7-4714-8f09-bbfa0d2c8913/small.jpg",
                  uuid: "39ad8233-c470-4394-b65f-2a6c3218b935",
                  sourceUrl: "https://www.bbcgoodfood.com/recipes/1837/canadian-butter-tarts",
                  youTubeUrl: "https://www.youtube.com/watch?v=WUpaOGghOdo"),
            
                .init(cuisine: "British",
                      name: "Carrot Cake",
                      photoUrlLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/32afc698-d927-4a90-990f-ec25e9520c08/large.jpg",
                      photoUrlSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/32afc698-d927-4a90-990f-ec25e9520c08/small.jpg",
                      uuid: "7e529e52-f56d-49a2-938f-81aac853cc65",
                      sourceUrl: "https://www.bbc.co.uk/food/recipes/classic_carrot_cake_08513",
                      youTubeUrl: "https://www.youtube.com/watch?v=WUpaOGghOdo"),
            
                .init(cuisine: "Tunisian",
                      name: "Cashew Ghoriba Biscuits",
                      photoUrlLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/9c7fa988-1bbe-4bed-9f1a-c9d4d8b311da/large.jpg",
                      photoUrlSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/9c7fa988-1bbe-4bed-9f1a-c9d4d8b311da/small.jpg",
                      uuid: "7eeb0865-b41c-4a3b-80dd-a69d32dccc7d",
                      sourceUrl: "http://allrecipes.co.uk/recipe/40152/cashew-ghoriba-biscuits.aspx",
                      youTubeUrl: "https://www.youtube.com/watch?v=IqXEZUk4hWI"),
            
        ]
    }
}
