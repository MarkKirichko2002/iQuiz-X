//
//  QuizAchievementsTableViewController + Extensions.swift
//  QUIZ
//
//  Created by Марк Киричко on 25.06.2023.
//

import Foundation

// MARK: - QuizAchievementsViewModelDelegate
extension QuizAchievementsTableViewController: QuizAchievementsViewModelDelegate {
    
    func achievementsDidLoaded(achievements: [QuizAchievementModel]) {
        quizAchievementsViewModel.achievements = achievements
        self.tableView.reloadData()
    }
}
