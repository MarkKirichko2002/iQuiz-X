//
//  QuizCategoryModel.swift
//  QUIZ
//
//  Created by Марк Киричко on 26.02.2022.
//

import Foundation

struct QuizCategoryModel {
    var name: String
    var image: String
    var base: QuizBaseViewModel
    var voiceCommand: String
    var background: String
    var complete: Bool
    var id: Int
    var score: Int
    var sound: String
    var music: String
}