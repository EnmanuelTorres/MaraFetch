//
//  URLSessionHTTPClient.swift
//  MaraFetch
//
//  Created by ENMANUEL TORRES on 20/12/24.
//

import Foundation

class URLSessionHTTPClient: HTTPClientType {
    
    private let session: URLSession
    private let requestMaker: URLSessionRequestMaker
    
    
    init(session: URLSession = .shared, requestMaker: URLSessionRequestMaker) {
        self.session = session
        self.requestMaker = requestMaker
    }
    
    
    func makeRequest(endPoint: String, baseUrl: String) async -> Result<Data, DataError> {
        guard let url = requestMaker.url(endPoint: endPoint, baseUrl: baseUrl) else {
            return .failure(.URLError)
        }
        
        
        do {
            let result = try await session.data(from: url)
            
            guard let response = result.1 as? HTTPURLResponse else {
                return .failure(.networkError)
            }
            
            guard response.statusCode == 200 else {
                return .failure(.apiError)
            }
            
            return .success(result.0)
            
        }catch {
            return .failure(.otherError(error))
        }
    }
    
    
}


extension URLSessionHTTPClient: ImageDataServiceType {
    
    func requestImage(url: URL) async -> Result<Data, DataError> {
        do {
            let result = try await session.data(from: url)
            
            guard let response = result.1 as? HTTPURLResponse else {
                return .failure(.networkError)
            }
            
            guard response.statusCode == 200 else {
                return .failure(.apiError)
            }
            
            return .success(result.0)
        } catch {
            return .failure(.otherError(error))
        }
    }
    
    
}
