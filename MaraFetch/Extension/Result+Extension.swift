//
//  Result+Extension.swift
//  MaraFetch
//
//  Created by ENMANUEL TORRES on 20/12/24.
//

import Foundation


extension Result {
    var failureCase: Error? {
        switch self {
            
        case .success(_):
            return nil
        case .failure(let error):
            return error
        }
    }
}
