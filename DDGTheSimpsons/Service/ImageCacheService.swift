//
//  ImageCacheService.swift
//  DDGTheSimpsons
//
//  Created by Eduardo Santiz on 5/20/19.
//  Copyright © 2019 EduardoSantiz. All rights reserved.
//

import UIKit.UIImage

class ImageCacheService {
    let cacheAsset: NSCache = NSCache<NSString, UIImage>()
    
    static let shared = ImageCacheService()
    private init(){}
    
    func saveToCache(with id: String, item image: UIImage) {
        cacheAsset.setObject(image, forKey: id as NSString)
    }
    
    func loadFromCache(with id: String) -> UIImage? {
        return cacheAsset.object(forKey: id as NSString)
    }
}
