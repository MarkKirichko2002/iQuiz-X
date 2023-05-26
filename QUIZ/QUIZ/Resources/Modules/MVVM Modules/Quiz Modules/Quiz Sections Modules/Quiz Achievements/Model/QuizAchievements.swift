//
//  QuizAchievements.swift
//  QUIZ
//
//  Created by Марк Киричко on 26.05.2023.
//

import Foundation

struct QuizAchievements {
    
    static let achievements = [
        QuizAchievementModel(id: 1, name: "астроном", description: "пройдите категорию Астрономия на 100 баллов", icon: "astronomy", path: "quizachievement1", conditions: [ConditionModel(score: 100, complete: true)], complete: false)
    ]
    
}
