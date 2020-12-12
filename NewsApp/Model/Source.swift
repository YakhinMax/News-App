//
//  Source.swift
//  NewsApp
//
//  Created by Maxim Yakhin on 11.12.2020.
//  Copyright © 2020 Max Yakhin. All rights reserved.
//

import Foundation

struct Source: Decodable {
    var id: String
    var name: String
    var description: String
    var url: String
    var category: String
    var language: String
    var country: String
}
