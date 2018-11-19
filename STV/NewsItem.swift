//
//  NewsItem.swift
//  STV
//
//  Created by mark.bonsor on 17/11/2018.
//  Copyright © 2018 MarkBonsor. All rights reserved.
//

struct NewsItem {
    
    let id: String
    let title: String
    let subHeadline: String
    let contentHTML: String
    let images: Array<Dictionary<String, Any>>
    let imageId: String?
    
    
    init?(json: Dictionary<String, AnyObject>) {
        
        guard let id = json["id"] as? String else {
            return nil
        }
        self.id = id
        
        guard let title = json["title"] as? String else {
            return nil
        }
        self.title = title
        
        guard let subHeadline = json["subHeadline"] as? String else {
            return nil
        }
        self.subHeadline = subHeadline
        
        guard let contentHTML = json["contentHTML"] as? String else {
            return nil
        }
        self.contentHTML = contentHTML
        
        if let images = json["images"] as? Array<Dictionary<String, Any>> {
            self.images = images
            var myImageId:String? = nil
            if (self.images.count > 0) {
                if let imageDict = self.images.first {
                    if let imageId:String = imageDict["id"] as? String {
                        myImageId = imageId
                    }
                }
            }
            self.imageId = myImageId
        } else {
            self.images = []
            self.imageId = nil
        }
        
        
    }
}
