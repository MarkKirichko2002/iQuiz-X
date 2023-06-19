//
//  QuizAchievementsViewModelDelegate.swift
//  QUIZ
//
//  Created by Марк Киричко on 26.03.2023.
//

import Foundation

protocol QuizAchievementsViewModelDelegate: AnyObject {
    func achievementsDidLoaded(achievements: [QuizAchievementModel])
}
