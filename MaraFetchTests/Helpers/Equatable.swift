//
//  Equatable.swift
//  MaraFetchTests
//
//  Created by ENMANUEL TORRES on 28/12/24.
//

import Foundation
@testable import MaraFetch

extension Recipe: @retroactive Equatable {
  public static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        lhs.id == rhs.id
        && lhs.name == rhs.name
        && lhs.cuisine == rhs.cuisine
        && lhs.photoUrl == rhs.photoUrl
    }
    
    
}

extension DataError: @retroactive Equatable {
    public static func == (lhs: DataError, rhs: DataError) -> Bool {
        return lhs.localizedDescription == rhs.localizedDescription
    }
}
