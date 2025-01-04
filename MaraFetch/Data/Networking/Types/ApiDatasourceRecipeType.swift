//
//  ApiDatasourceRecipeType.swift
//  MaraFetch
//
//  Created by ENMANUEL TORRES on 20/12/24.
//

import Foundation

protocol ApiDatasourceRecipeType {
    func getDessertList() async -> Result<[RecipeDTO], DataError>
}
