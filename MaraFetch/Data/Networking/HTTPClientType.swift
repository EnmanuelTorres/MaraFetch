//
//  HTTPClientType.swift
//  MaraFetch
//
//  Created by ENMANUEL TORRES on 20/12/24.
//

import Foundation

protocol HTTPClientType {
    func makeRequest(endPoint: String, baseUrl: String) async -> Result<Data, DataError>
}
