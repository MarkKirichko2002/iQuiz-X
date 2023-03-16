//
//  NewsResponse.swift
//  QUIZ
//
//  Created by Марк Киричко on 29.06.2022.
//

import Foundation

struct NewsResponse: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
}
