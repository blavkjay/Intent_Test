//
//  ImageCacheManager.swift
//  IntentTakeHomeTest
//
//  Created by Admin on 09/10/2021.
//

import Foundation
import UIKit

class ImageCacheManager {
    static let cache = NSCache<NSString, NSData>()

    static func fetchImageData(from url: String, completion: @escaping (NSData) -> (Void)){
        let key = NSString(string: url)
        if let cachedVersion = cache.object(forKey: key) {
            DispatchQueue.global(qos: .background).async {
                completion(cachedVersion)
            }
        } else {
            DispatchQueue.global(qos: .background).async {
                guard let url = URL(string: url) else {return}
                guard let ddata = try? Data(contentsOf: url) else {return}
                let ns = NSData(data: ddata)
                cache.setObject(ns, forKey: key)
                completion(ns)
            }
        }
    }
    
}
