//
//  URLSessionRequestMaker.swift
//  MaraFetch
//
//  Created by ENMANUEL TORRES on 20/12/24.
//

import Foundation


class URLSessionRequestMaker{
    
    func url(endPoint: String, baseUrl: String) -> URL? {
        let urlString = "\(baseUrl)\(endPoint)"
        return URL(string: urlString)
    }
}
