//
//  NewsCategoryModel.swift
//  QUIZ
//
//  Created by Марк Киричко on 06.01.2023.
//

import Foundation

struct NewsCategoryModel {
    let id: Int
    let name: String
    let icon: String
    let sound: String
    let endpoint: NewsCategory
    var articlesCount: Int
    let voiceCommand: String
}
