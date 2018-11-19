//
//  TableViewController.swift
//  STV
//
//  Created by mark.bonsor on 15/11/2018.
//  Copyright © 2018 MarkBonsor. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var newsItems: [NewsItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "News Headlines"
        self.navigationItem.setHidesBackButton(true, animated:false);
        
        self.clearsSelectionOnViewWillAppear = false
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
        NewsDataClient.sharedClient.getNewsItems {[weak self](newsItems) in
            self?.newsItems = newsItems
            
            DispatchQueue.main.async(execute: {
                self?.tableView.reloadData()
            })
        }
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! TableViewCell
        cell.newsImage.image = nil
        let newsItem = newsItems[indexPath.row]
        cell.configure(newsItem)
        return cell
    }
    
    
    // MARK: - Navigation
    
    var newsItemToPass:NewsItem? = nil
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        newsItemToPass = newsItems[indexPath.row]
        self.performSegue(withIdentifier: "segueToFullStory", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier  == "segueToFullStory") {
            let backItem = UIBarButtonItem()
            backItem.title = "Back"
            navigationItem.backBarButtonItem = backItem
            if let fullStoryVC = (segue.destination as? FullStoryViewController) {
                fullStoryVC.configure(newsItemToPass!)
            }
        }
    }
    
}
