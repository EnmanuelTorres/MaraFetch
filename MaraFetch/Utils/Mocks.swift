//
//  Mocks.swift
//  MaraFetch
//
//  Created by ENMANUEL TORRES on 20/12/24.
//

import Foundation


let recipeMock = Recipe(id: "7e529e52-f56d-49a2-938f-81aac853cc65",
                        name: "Carrot Cake",
                        cuisine: "British",
                        photoUrl: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/32afc698-d927-4a90-990f-ec25e9520c08/small.jpg")


let recipesMock = [
    Recipe(id: "1",
           name: "Chocolate Caramel Crispy",
           cuisine: "British",
           photoUrl: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/1c1616f6-81d2-447d-a1ae-51352edfde0c/small.jpg"),
    
    Recipe(id: "2",
           name: "Chocolate Gateau",
           cuisine: "French",
           photoUrl: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/bfc6bc1d-3e24-4f9e-a496-bd4f3f002539/small.jpg"),
    
    Recipe(id: "3",
           name: "Chocolate Caramel Crispy",
           cuisine: "British",
           photoUrl: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/1c1616f6-81d2-447d-a1ae-51352edfde0c/small.jpg"),
    
    Recipe(id: "4",
           name: "Chocolate Gateau",
           cuisine: "French",
           photoUrl: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/bfc6bc1d-3e24-4f9e-a496-bd4f3f002539/small.jpg"),
    
    Recipe(id: "5",
           name: "Chocolate Caramel Crispy",
           cuisine: "British",
           photoUrl: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/1c1616f6-81d2-447d-a1ae-51352edfde0c/small.jpg"),
    
    Recipe(id: "6",
           name: "Chocolate Gateau",
           cuisine: "French",
           photoUrl: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/bfc6bc1d-3e24-4f9e-a496-bd4f3f002539/small.jpg"),
    
    Recipe(id: "7",
           name: "Chocolate Caramel Crispy",
           cuisine: "British",
           photoUrl: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/1c1616f6-81d2-447d-a1ae-51352edfde0c/small.jpg"),
    
    Recipe(id: "8",
           name: "Chocolate Gateau",
           cuisine: "French",
           photoUrl: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/bfc6bc1d-3e24-4f9e-a496-bd4f3f002539/small.jpg"),
    
    Recipe(id: "9",
           name: "Chocolate Caramel Crispy",
           cuisine: "British",
           photoUrl: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/1c1616f6-81d2-447d-a1ae-51352edfde0c/small.jpg"),
    
    Recipe(id: "10",
           name: "Chocolate Gateau",
           cuisine: "French",
           photoUrl: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/bfc6bc1d-3e24-4f9e-a496-bd4f3f002539/small.jpg")
]


let mainViewModelMock = MainViewModel(repository: RecipeListRepository(apiDataSource: APIRecipeDataSource(httpClient: urlSessionHttpclient), recipeMapper: RecipeMapper(), cacheDataSource: RecipeListCache()), imageRepository: ImageRepository(imageDataService: urlSessionHttpclient, imageCache: ImageCache()))

let urlSessionHttpclient = URLSessionHTTPClient(requestMaker: URLSessionRequestMaker())
