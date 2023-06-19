//
//  QuizAchievementModel.swift
//  QUIZ
//
//  Created by Марк Киричко on 26.03.2023.
//

import Foundation

struct QuizAchievementModel {
    let id: Int
    let name: String
    let description: String
    let icon: String
    let path: String
    let conditions: [ConditionModel]
    var complete: Bool
}
