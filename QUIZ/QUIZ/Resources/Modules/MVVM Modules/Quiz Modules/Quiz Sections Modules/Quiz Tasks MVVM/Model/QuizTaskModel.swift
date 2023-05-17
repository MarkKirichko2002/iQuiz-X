//
//  Tasks.swift
//  QUIZ
//
//  Created by Марк Киричко on 20.02.2022.
//

import Foundation

struct QuizTaskModel {
    let id: Int
    let name: String
    let image: String
    let background: String
    var complete: Bool
    let quizpath: String
    let sound: String
    let category: QuizCategoryModel
}

