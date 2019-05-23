//
//  NetworkService.swift
//  DDGTheSimpsons
//
//  Created by Eduardo Santiz on 5/20/19.
//  Copyright © 2019 EduardoSantiz. All rights reserved.
//

import UIKit.UIImage

class NetworkService {
    let urlSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    func downloadData(from url: String, completion: @escaping (Data?) -> Void) {
        guard let validURL = URL(string: url) else { completion(nil); return }
        
        dataTask?.cancel()
        
        urlSession.dataTask(with: validURL) { (data, _, error) in
            if let error = error {
                fatalError(error.localizedDescription)
            }
            
            if let jsonData = data {
                completion(jsonData)
            } else {
                completion(nil)
            }
        }.resume()
    }
    
    func downloadImage(from url: String, completion: @escaping (UIImage?) -> Void) {
        if let image = ImageCacheService.shared.loadFromCache(with: url) {
            completion(image)
        } else {
            guard let validURL = URL(string: url) else { completion(nil); return }
            
            dataTask?.cancel()
            
            urlSession.dataTask(with: validURL) { (data, _, error) in
                if let error = error {
                    fatalError(error.localizedDescription)
                }
                
                guard let imageData = data else { completion(nil); return }
                
                if let image = UIImage(data: imageData) {
                    ImageCacheService.shared.saveToCache(with: url, item: image)
                    completion(image)
                } else {
                    completion(nil)
                }
            }
        }
    }
}
