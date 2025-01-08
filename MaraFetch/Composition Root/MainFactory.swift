//
//  MainFactory.swift
//  MaraFetch
//
//  Created by ENMANUEL TORRES on 20/12/24.
//

import Foundation

actor MainFactory {
    
   private static let UrlSessionHttpClient = URLSessionHTTPClient(requestMaker: URLSessionRequestMaker())
    
    @MainActor
    static func create() -> MainView {
        return MainView(viewModel: createRecipeViewModel())
    }
    
    @MainActor
    private static  func createRecipeViewModel() -> MainViewModel {
        return MainViewModel(repository: createDessertListRepository(),
                             imageRepository: createImageRepository())
    }
    
    private static func createImageRepository() -> ImageRepositoryType {
        return ImageRepository(imageDataService: UrlSessionHttpClient,
                               imageCache: createImageCache())
    }
    
    private static func createImageCache() -> ImageCacheType {
        return ImageCache()
    }
    
    private static func createDessertListRepository() -> DessertListRepositoryType {
        return RecipeListRepository(apiDataSource: createApiDataSource(),
                                    recipeMapper: RecipeMapper(),
                                    cacheDataSource: createCacheDataSource())
    }
    
    private static func createCacheDataSource() -> RecipeListCacheType {
        return RecipeListCache()
    }
    
    private static func createApiDataSource() -> ApiDatasourceRecipeType {
        return APIRecipeDataSource(httpClient: UrlSessionHttpClient)
    }
    
}
