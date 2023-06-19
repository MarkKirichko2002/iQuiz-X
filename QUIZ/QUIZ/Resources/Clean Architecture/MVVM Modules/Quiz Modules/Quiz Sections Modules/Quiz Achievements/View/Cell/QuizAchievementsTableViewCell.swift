//
//  QuizAchievementsTableViewCell.swift
//  QUIZ
//
//  Created by Марк Киричко on 26.03.2023.
//

import UIKit

class QuizAchievementsTableViewCell: UITableViewCell {
    
    static let identifier = "QuizAchievementsTableViewCell"
    
    @IBOutlet weak var QuizAchievementIcon: RoundedImageView!
    @IBOutlet weak var QuizAchievementName: UILabel!
    @IBOutlet weak var QuizAchievementDescription: UILabel!
    @IBOutlet weak var QuizAchievementComplete: UILabel!
    
    func configureCell(achievements: QuizAchievementModel) {
        QuizAchievementIcon.image = UIImage(named: achievements.icon)
        QuizAchievementName.text = achievements.name
        QuizAchievementDescription.text = achievements.description
        switch achievements.complete {
        case true:
            QuizAchievementComplete.text = "пройдено"
            QuizAchievementComplete.textColor = .systemGreen
        case false:
            QuizAchievementComplete.text = "еще нет"
            QuizAchievementComplete.textColor = .gray
        }
    }
}
