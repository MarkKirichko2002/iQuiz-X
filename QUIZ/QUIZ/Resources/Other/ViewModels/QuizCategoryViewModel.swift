//
//  QuizCategoryViewModel.swift
//  QUIZ
//
//  Created by Марк Киричко on 19.12.2022.
//

import Foundation

struct QuizCategoryViewModel: Hashable, Codable {
    let category: String
    let score: Int
    let UnCorrectAnswersCounter: Int
    let CorrectAnswersCounter: Int
    let complete: Bool
    let date: String
    let music: String
    var voiceCommand: String
}
