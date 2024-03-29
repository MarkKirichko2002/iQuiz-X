//
//  QuizPageModel.swift
//  QUIZ
//
//  Created by Марк Киричко on 18.01.2023.
//

import Foundation

struct QuizSectionModel {
    let id: Int
    var name: String
    var icon: String
    var sound: String
    var info: String
    var itemsCount: Int
    var completedItemsCount: Int?
    var percentage: Int?
}
