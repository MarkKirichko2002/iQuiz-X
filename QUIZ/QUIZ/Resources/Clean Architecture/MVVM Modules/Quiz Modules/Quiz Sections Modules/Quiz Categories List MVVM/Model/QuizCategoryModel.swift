//
//  QuizCategoryModel.swift
//  QUIZ
//
//  Created by Марк Киричко on 26.02.2022.
//

import Foundation

struct QuizCategoryModel {
    let id: Int
    var name: String
    let image: String
    let AppIcon: String
    let base: QuizBaseViewModel
    let quizpath: String
    var voiceCommand: String
    var date: String
    let background: String
    var complete: Bool
    var score: Int
    let sound: String
    let music: String
}
