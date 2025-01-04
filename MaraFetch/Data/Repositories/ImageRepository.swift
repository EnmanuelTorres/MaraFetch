//
//  ImageRepository.swift
//  MaraFetch
//
//  Created by ENMANUEL TORRES on 30/12/24.
//

import Foundation

protocol ImageRepositoryType {
    func getImage(url: URL?) async -> Result<Data, DataError>
}

class ImageRepository: ImageRepositoryType {
    
    private let imageCache : ImageCacheType
    private let imageDataService: ImageDataServiceType
    
    init(imageDataService: ImageDataServiceType, imageCache: ImageCacheType) {
        self.imageDataService = imageDataService
        self.imageCache = imageCache
    }
    
    func getImage(url: URL?) async -> Result<Data, DataError> {
        guard let url = url else {
            return .failure(.URLError)
        }
        
        if let cacheImage = await imageCache.getImageFromCache(forKey: url.absoluteString) {
            return .success(cacheImage)
        }
        
        let remoteResult = await imageDataService.requestImage(url: url)
        
        switch remoteResult {
            
        case .success(let data):
            await imageCache.saveImageToCache(data, forkey: url.absoluteString)
            return .success(data)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    
}
