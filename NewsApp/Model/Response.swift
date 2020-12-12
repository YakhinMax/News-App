//
//  Response.swift
//  NewsApp
//
//  Created by Maxim Yakhin on 11.12.2020.
//  Copyright © 2020 Max Yakhin. All rights reserved.
//

import Foundation

struct Response: Decodable {
    var status: String?
    var totalResults: Int?
    var articles: [Article]?
    var sources: [Source]?
}


