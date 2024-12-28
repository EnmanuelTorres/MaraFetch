//
//  RecipeMapper.swift
//  MaraFetch
//
//  Created by ENMANUEL TORRES on 20/12/24.
//

import Foundation


struct RecipeMapper {
    
    func map(dto: [RecipeDTO]) -> [Recipe] {
        let mappedRecipeList = dto.map({
            Recipe(id: $0.uuid, name: $0.name, cuisine: $0.cuisine, photoUrl: $0.photoUrlSmall)
        })
        
        return mappedRecipeList
        
    }
}

