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
    case emptyData
    case otherError(Error)
    
    var localizedDescription: String {
        switch self {
            
        case .URLError:
            return "Invalid Url"
        case .networkError:
            return "Network error"
        case .apiError:
            return "API responded with error"
        case .dataError:
            return "Data error ocurred"
        case .decodingError:
            return "Error decoding the data"
        case .otherError(let error):
            return "Error occurred: \(error.localizedDescription)"
        case .emptyData:
            return "Empty Data"
        }
    }
}
