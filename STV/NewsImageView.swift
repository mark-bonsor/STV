//
//  NewsImage.swift
//  STV
//
//  Created by mark.bonsor on 17/11/2018.
//  Copyright © 2018 MarkBonsor. All rights reserved.
//

import UIKit

class NewsImageView: UIImageView {
    
    let placeHolderImage: UIImage = UIImage(named: "placeholder")!
    
    public func setNewsImage(idString:String, width:CGFloat, height:CGFloat) {
        
        self.image = placeHolderImage
        let imgWidth = Int(width)
        let imgHeight = Int(height)
        if let imageUrlString = getImageUrl(idString: idString, width: imgWidth, height: imgHeight) {
            self.loadImageUsingCacheWithURLString(imageUrlString, placeHolder: placeHolderImage)
        }
    }
    
    func getImageUrl(idString:String, width:Int, height:Int) -> String? {
        
        let urlString:String = String(format: "http://api.stv.tv/images/%@/rendition/?width=%i&height=%i", idString, width, height)
        
        let url = NSURL(string: urlString)
        var imageUrlString:String? = nil
        
        URLSession.shared.dataTask(with: (url as URL?)!, completionHandler: {(data, response, error) -> Void in
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                
                imageUrlString = jsonObj?.value(forKey: "url") as? String
                
                DispatchQueue.main.async(execute: {
                    self.loadImageUsingCacheWithURLString(imageUrlString!, placeHolder: self.placeHolderImage)
                })
                
            }
            
        }).resume()
        
        return imageUrlString
    }
    
}
