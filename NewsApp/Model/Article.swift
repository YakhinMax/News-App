//
//  Article.swift
//  NewsApp
//
//  Created by Maxim Yakhin on 11.12.2020.
//  Copyright © 2020 Max Yakhin. All rights reserved.
//

import Foundation

struct ArticleSource: Decodable {
    var id: String?
    var name: String?
}

struct Article: Decodable {
    var source: ArticleSource
    var url: String?
    var title: String?
    var content: String?
    var author: String?
    var urlToImage: String?
    var description: String?
    var publishedAt: String?
}
