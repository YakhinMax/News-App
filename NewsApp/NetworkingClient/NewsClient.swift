//
//  NewsClient.swift
//  NewsApp
//
//  Created by Maxim Yakhin on 11.12.2020.
//  Copyright © 2020 Max Yakhin. All rights reserved.
//

import Foundation

class NewsClient {
    private let apiKey = "6099418aef4c4111ad10623a7caf8814"
    //"feb4208f6f4443138a49bcea89f6dd65"
    
    private var filters: [String: String] = ["country": "us"] // Does not support queries without parameters
//    private var filters: [String: String] = ["q": "Trump"]
    
    public static let shared: NewsClient = {
        return NewsClient()
    }()
    
    
    public func getArticles(success: @escaping ([Article]) -> Void) {
        var urlString = "https://newsapi.org/v2/top-headlines?"
//        var urlString = "https://newsapi.org/v2/everything?"
        for (key, val) in filters {
            urlString += "\(key)=\(val)&"
        }
        DispatchQueue.global().async {
            guard let url = URL(string: "\(urlString)apiKey=\(self.apiKey)") else { return }
            URLSession.shared.dataTask(with: url) {
                data, response, error in
                guard data != nil else { return }
                do {
                    let res = try JSONDecoder().decode(Response.self, from: data!)
                    guard res.status == "ok", res.articles != nil else { print(res); return }
                    
                    DispatchQueue.main.async {
                        success(res.articles!)
                    }
                }
                catch let err {
                    print(err)
                }
            }.resume()
        }
    }
    
    /*
    public func getArticles(success: @escaping ([Article]) -> Void) {
        var articles = [
            Article(source: ArticleSource(), title: "Article1"),
            Article(source: ArticleSource(), title: "Article2"),
            Article(source: ArticleSource(), title: "Article3"),
            Article(source: ArticleSource(), title: "Article4"),
            Article(source: ArticleSource(), title: "Article5"),
            Article(source: ArticleSource(), title: "Article6"),
            Article(source: ArticleSource(), title: "Article7")]
        if filters.keys.contains("page") {
            if Int(filters["page"]!)! >= 2 {
                articles = [
                    Article(source: ArticleSource(), title: "Article\(Int(filters["page"]!)! * 7 - 6)"),
                    Article(source: ArticleSource(), title: "Article\(Int(filters["page"]!)! * 7 - 5)"),
                    Article(source: ArticleSource(), title: "Article\(Int(filters["page"]!)! * 7 - 4)"),
                    Article(source: ArticleSource(), title: "Article\(Int(filters["page"]!)! * 7 - 3)"),
                    Article(source: ArticleSource(), title: "Article\(Int(filters["page"]!)! * 7 - 2)"),
                    Article(source: ArticleSource(), title: "Article\(Int(filters["page"]!)! * 7 - 1)"),
                    Article(source: ArticleSource(), title: "Article\(Int(filters["page"]!)! * 7)")]
            }
        }
        success(articles)
    }
    */
    public func getImage(urlString: String?, success: @escaping (Data?) -> Void) {
        guard urlString != nil else { return }
        DispatchQueue.global().async {
            guard let url = URL(string: urlString!) else { return }
            URLSession.shared.dataTask(with: url) {
                data, response, error in
                DispatchQueue.main.async {
                    success(data)
                }
            }.resume()
        }
    }
    
    public func addFilter(key: String, value: String) {
        filters[key] = value
    }
    
    public func removeFilterKey(key: String) {
        filters.removeValue(forKey: key)
    }
}
