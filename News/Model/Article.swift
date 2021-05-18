//
//  Article.swift
//  News
//
//  Created by Ramazan Abdullayev on 18.05.21.
//

import Foundation

struct Article: Codable {
    let source: ArticleSource
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String
}
