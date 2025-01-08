//
//  RecipeDTO.swift
//  MaraFetch
//
//  Created by ENMANUEL TORRES on 20/12/24.
//

import Foundation


struct RecipesDTO: Codable{
    let recipes: [RecipeDTO?]
    
    enum CodingKeys: String, CodingKey {
        case recipes
    }
    
}

struct RecipeDTO: Codable, Hashable {
    let cuisine: String
    let name: String
    let photoUrlLarge: String
    let photoUrlSmall: String
    let uuid: String
    let sourceUrl: String?
    let youTubeUrl: String?

    enum CodingKeys: String, CodingKey {
        case cuisine
        case name
        case photoUrlLarge = "photo_url_large"
        case photoUrlSmall = "photo_url_small"
        case uuid
        case sourceUrl = "source_url"
        case youTubeUrl = "youtube_url"
    }
}
