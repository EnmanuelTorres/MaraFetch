//
//  MainViewModel.swift
//  MaraFetch
//
//  Created by ENMANUEL TORRES on 20/12/24.
//

import Foundation


class MainViewModel: ObservableObject {
    
    @Published var RecipeList: [Recipe] = []
    private let repository: DessertListRepositoryType
    
    init(repository: DessertListRepositoryType) {
        self.repository = repository
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
}
