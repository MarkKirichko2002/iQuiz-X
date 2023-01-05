//
//  QuizCategoryModel.swift
//  QUIZ
//
//  Created by Марк Киричко on 26.02.2022.
//

import Foundation

struct QuizCategoryModel {
    var id: Int
    var name: String
    var image: String
    var base: QuizBaseViewModel
    var quizpath: String
    var voiceCommand: String
    var background: String
    var complete: Bool
    var score: Int
    var sound: String
    var music: String
}
