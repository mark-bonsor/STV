//
//  TableViewCell.swift
//  STV
//
//  Created by mark.bonsor on 15/11/2018.
//  Copyright © 2018 MarkBonsor. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsSubheadline: UILabel!
    @IBOutlet weak var newsImage: NewsImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(_ newsItem: NewsItem) {
        self.newsTitle.text = newsItem.title
        self.newsSubheadline.text = newsItem.subHeadline
        
        if let imageId = newsItem.imageId {
            let imgWidth = self.newsImage.frame.width
            let imgHeight = self.newsImage.frame.height
            self.newsImage.setNewsImage(idString: imageId, width: imgWidth, height: imgHeight)
        } else {
            self.newsImage.image = UIImage(named: "placeholder")
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
