//
//  DataError.swift
//  MaraFetch
//
//  Created by ENMANUEL TORRES on 20/12/24.
//

import Foundation


import Foundation

enum DataError: Error {
    case URLError
    case networkError
    case apiError
    case dataError
    case decodingError
    case otherError(Error)
}
