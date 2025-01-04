//
//  MainViewModel.swift
//  MaraFetch
//
//  Created by ENMANUEL TORRES on 20/12/24.
//

import Foundation
import UIKit


class MainViewModel: ObservableObject {
    
    @Published var RecipeList: [Recipe] = []
    @Published var images: [String: UIImage] = [:]
    
    private let repository: DessertListRepositoryType
    private let imageRepository: ImageRepositoryType
    
    init(repository: DessertListRepositoryType, imageRepository: ImageRepositoryType) {
        self.repository = repository
        self.imageRepository = imageRepository
    }
    
    
    func getRecipeList() async {
        Task { @MainActor in
            let result = await repository.getRecipeList()
            
            DispatchQueue.main.async {
                switch result {
                case .success(let recipeList):
                    Task { @MainActor in
                        self.RecipeList = recipeList
                    }
                    
                case .failure(let error):
                    print("Error fetching desserts: \(error.localizedDescription)")
                    
                }
            }
        }
    }
    
    func fetchImages(for recipe: Recipe) async {
        let imageUrl = recipe.photoUrl
        
        let result = await imageRepository.getImage(url: URL(string: imageUrl))
        
        switch result {
            
        case .success(let imageData):
            let image = UIImage(data: imageData)
            self.images[recipe.photoUrl] = image
        case .failure(let error):
            print("Error fetching image: \(error)")
        }
        
    }
}
