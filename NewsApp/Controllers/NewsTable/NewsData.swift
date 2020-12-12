//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Maxim Yakhin on 12.12.2020.
//  Copyright © 2020 Max Yakhin. All rights reserved.
//

import UIKit

class NewsData {
    var image: UIImage?
    var title: String
    var info: String
    var date: String
    var url: String?
    
    init(article: Article, tableview: UITableView) {
        
        if article.publishedAt != nil {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
            let publishDate = formatter.date(from: article.publishedAt!)
            formatter.dateFormat = "dd.MM HH:mm"
            if publishDate == nil {
                date = ""
            }
            else {
                date = formatter.string(from: publishDate!)
            }
        }
        else {
            date = ""
        }
        
        self.title = article.title ?? ""
        if let author = article.author {
            if let source = article.source.name {
                self.info = author + ", " + source
            }
            else {
                self.info = author
            }
        }
        else {
            if let source = article.source.name {
                self.info = source
            }
            else {
                self.info = ""
            }
        }
        self.url = article.url
        self.image = nil
        if article.urlToImage != nil {
            NewsClient.shared.getImage(urlString: article.urlToImage!, success: {data in
                if data != nil {
                    self.image = UIImage(data: data!)
    //                tableview.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
                    tableview.reloadData()
                }
            })
        }
    }
}
