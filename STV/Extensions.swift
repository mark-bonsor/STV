//
//  Extensions.swift
//  STV
//
//  Created by mark.bonsor on 16/11/2018.
//  Copyright © 2018 MarkBonsor. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func loadImageUsingCacheWithURLString(_ URLString: String,
                                          placeHolder: UIImage?) {
        
        self.image = nil
        if let cachedImage = imageCache.object(forKey: NSString(string: URLString)) {
            self.image = cachedImage
            return
        }
        
        self.image = placeHolder
        
        if let url = URL(string: URLString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                
                if error != nil {
                    print("ERROR LOADING IMAGES FROM URL: \(error!)")
                    DispatchQueue.main.async {
                        self.image = placeHolder
                    }
                    return
                }
                DispatchQueue.main.async {
                    if let data = data, let downloadedImage = UIImage(data: data) {
                        imageCache.setObject(downloadedImage, forKey: NSString(string: URLString))
                        self.image = downloadedImage
                    }
                }
            }).resume()
        }
    }
}
