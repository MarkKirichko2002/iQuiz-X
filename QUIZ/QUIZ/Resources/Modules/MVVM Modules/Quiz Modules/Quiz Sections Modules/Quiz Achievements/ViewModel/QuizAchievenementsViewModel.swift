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
    
    var achievements = QuizAchievements.achievements
    
    func GetAchievementsData() {
        for i in self.achievements {
            self.firebaseManager.LoadQuizAchievementsData(quizachievement: i) { achievement in
                if achievement.conditions[0].complete == i.conditions[i.id - 1].complete && achievement.conditions[0].score == i.conditions[i.id - 1].score {
                    self.achievements[i.id - 1].complete = true
                    self.delegate?.achievementsDidLoaded(achievements: self.achievements)
                } 
            }
        }
    }
}
