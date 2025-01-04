//
//  ImageDataServiceType.swift
//  MaraFetch
//
//  Created by ENMANUEL TORRES on 2/01/25.
//

import Foundation


protocol ImageDataServiceType {
    func requestImage(url: URL) async -> Result<Data, DataError>
}
