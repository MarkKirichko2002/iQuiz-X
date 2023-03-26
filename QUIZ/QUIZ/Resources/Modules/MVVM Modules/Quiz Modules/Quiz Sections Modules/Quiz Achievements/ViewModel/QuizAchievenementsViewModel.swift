//
//  QuizAchievenementsViewModel.swift
//  QUIZ
//
//  Created by Марк Киричко on 26.03.2023.
//

import Foundation

class QuizAchievementsViewModel {
    
    weak var delegate: QuizAchievementsViewModelDelegate?
    
    private let firebaseManager = FirebaseManager()
    
    var achievements = [QuizAchievementModel(id: 1, name: "астроном", description: "пройдите категорию Астрономия на 100 баллов", icon: "astronomy", path: "quizastronomy", conditions: [ConditionModel(score: 100, complete: true)], complete: false)]
    
    func LoadData() {
        firebaseManager.LoadQuizAchievementsData(achievement: achievements[0]) { achievement in
            for i in self.achievements {
                if achievement.conditions == i.conditions {
                    self.achievements[i.id - 1].complete = true
                    self.delegate?.achievementsDidLoaded(achievements: self.achievements)
                }
            }
        }
    }
}


