//
//  NewsModel.swift
//  QUIZ
//
//  Created by Марк Киричко on 29.06.2022.
//

import Foundation
import DynamicJSON

// MARK: - News
struct News: Codable {
    let status: String
    let totalResults: Int
    let response: NewsResponse
}

struct NewsResponse: Codable {
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable {
    //let source: Source
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    //let publishedAt: Date
    //let content: String?

    init(json: JSON) {
        self.author = json["author"] as! String
        self.title =  json["title"] as! String
        self.description = json["description"] as! String
        self.url = json["url"] as! String
        self.urlToImage = json["urlToImage"] as! String
    }
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String
}
