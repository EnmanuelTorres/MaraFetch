//
//  ImageCacheType.swift
//  MaraFetch
//
//  Created by ENMANUEL TORRES on 30/12/24.
//

import Foundation

protocol ImageCacheType {
    func getImageFromCache(forKey key: String) async -> Data?
    func saveImageToCache(_ data: Data, forkey key: String) async
}
