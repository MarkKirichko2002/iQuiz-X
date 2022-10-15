//
//  NewsModel.swift
//  QUIZ
//
//  Created by Марк Киричко on 29.06.2022.
//

import Foundation

struct NewsResponse: Codable {
    let status: String
    let totalResults: Int
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
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String
}
