//
//  FullStoryViewController.swift
//  STV
//
//  Created by mark.bonsor on 17/11/2018.
//  Copyright © 2018 MarkBonsor. All rights reserved.
//

import UIKit

class FullStoryViewController: UIViewController {

    @IBOutlet weak var newsContent: UIWebView! {
        didSet { updateUI() }
    }
    
    @IBOutlet weak var newsImage: NewsImageView! {
        didSet { updateUI() }
    }
    
    private var newsItem:NewsItem? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func configure(_ newsItem: NewsItem) {
        self.newsItem = newsItem
        updateUI()
    }

    func updateUI() {
        
        if (self.newsContent != nil) {
            let newsContentHtml = newsItem!.contentHTML
            let formattedContentHtml = String(format: "<html><head><style type=\"text/css\">body{font-family: '-apple-system','HelveticaNeue'; font-size:17;}</style></head><body>%@</body></html>", newsContentHtml)
            self.newsContent.loadHTMLString(formattedContentHtml, baseURL: nil)
        }
        
        if (self.newsImage != nil) {
            if let imageId = newsItem!.imageId {
                let imgWidth = self.newsImage!.frame.width
                let imgHeight = self.newsImage!.frame.height
                self.newsImage!.setNewsImage(idString: imageId, width: imgWidth, height: imgHeight)
            } else {
                self.newsImage!.image = UIImage(named: "placeholder")
            }
        }
    }
    

}
