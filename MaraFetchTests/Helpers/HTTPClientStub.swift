//
//  HTTPClientStub.swift
//  MaraFetchTests
//
//  Created by ENMANUEL TORRES on 3/01/25.
//

import Foundation
@testable import MaraFetch

class HttpClientStub: HTTPClientType {
    
    let result: Result<Data, DataError>
    
    init(result: Result<Data, DataError>) {
        self.result = result
    }
    
    func makeRequest(endPoint: String, baseUrl: String) async -> Result<Data, MaraFetch.DataError> {
        return result
    }
    
    
}
