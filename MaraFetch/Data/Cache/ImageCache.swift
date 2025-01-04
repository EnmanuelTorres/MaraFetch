//
//  ImageCache.swift
//  MaraFetch
//
//  Created by ENMANUEL TORRES on 30/12/24.
//

import Foundation

actor ImageCache: ImageCacheType {
    
    private let nsCache = NSCache<NSString, NSData>()
    private let  fileManager = FileManager.default
    private let cacheDirectory:  URL
    
    init() {
       
        cacheDirectory = fileManager.urls(for: .cachesDirectory,
                                          in: .userDomainMask)[0].appendingPathComponent("ImageCache")
        
        if !fileManager.fileExists(atPath: cacheDirectory.path) {
            try? fileManager.createDirectory(at: cacheDirectory,
                                             withIntermediateDirectories: true)
        }
    }
    
    func getImageFromCache(forKey key: String) async -> Data? {
        let safeKey = makeSafeKey(key)
        let cacheKey = NSString(string: safeKey)
        
        if let cachedData = nsCache.object(forKey: cacheKey) {
            return cachedData as Data
        }
        
        let filePath = cacheDirectory.appendingPathComponent(safeKey)
        
        guard fileManager.fileExists(atPath: filePath.path) else {
            return nil
        }
               
        do {
            let data = try Data(contentsOf: filePath)
            nsCache.setObject(data as NSData, forKey: cacheKey)
            return data
        } catch {
            print("ERROR: Could not read image: \(error)")
            return nil
            
        }
                
    }
    
    func saveImageToCache(_ data: Data, forkey key: String) async {
        let safeKey = makeSafeKey(key)
        let cacheKey = NSString(string: safeKey)
        
        nsCache.setObject(data as NSData, forKey: cacheKey)
        
        let filePath = cacheDirectory.appendingPathComponent(safeKey)
        
        do {
            try data.write(to: filePath)
        } catch {
            print("DEBUG: Could not save image: \(error)")
        }
    }
    
    
    private func makeSafeKey(_ key: String) -> String {
        return key.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? key
    }
    
}
