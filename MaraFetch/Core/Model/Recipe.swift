//
//  Recipe.swift
//  MaraFetch
//
//  Created by ENMANUEL TORRES on 20/12/24.
//

import Foundation


struct Recipe: Codable, Identifiable {
    let id: String
    let name: String
    let cuisine: String
    let photoUrl: String
    
}
