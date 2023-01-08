//
//  ImageCache.swift
//  AroundTown
//
//  Created by Jocelyn Icaza on 1/7/23.
//

import Foundation

class ImageCache {
    
    static var cache = [String:Data]()
    
    static func saveImage(url: String, imageData: Data){
        
        //Save the data with url as the key
        cache[url] = imageData
    }
    
    static func getImage(url: String) -> Data? {
        
        //Return saved image
        return cache[url]
    }
    
}
