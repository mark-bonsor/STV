//
//  NewsDataClient.swift
//  STV
//
//  Created by mark.bonsor on 17/11/2018.
//  Copyright © 2018 MarkBonsor. All rights reserved.
//

import Foundation

class NewsDataClient {
    
    let URL_NEWSFEED: String = "http://api.stv.tv/articles/?count=50&navigationLevelId=1218&orderBy=ranking+ASC%2C+createdAt+ASC&full=1&count=20"
    
    static let sharedClient = NewsDataClient()
    
    var newsItems: [NewsItem] = []
    
    func getNewsItems(completion: @escaping ([NewsItem]) -> ()) {
        let url = NSURL(string: URL_NEWSFEED)
        
        dataTask(url: url!) { (success, result) in
            var newsItems: [NewsItem] = []
            if let result = result as? [Dictionary<String, AnyObject>] {
                for object in result {
                    if let newsItem = NewsItem(json: object) {
                        newsItems.append(newsItem)
                    }
                }
            }
            
            completion(newsItems)
        }
    }
    
    private func dataTask(url: NSURL, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        session.dataTask(with: (url as URL?)!) { (data, response, error) -> Void in
            if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                    completion(true, json as AnyObject)
                } else {
                    completion(false, json as AnyObject)
                }
            }
            }.resume()
        
    }
    
}
