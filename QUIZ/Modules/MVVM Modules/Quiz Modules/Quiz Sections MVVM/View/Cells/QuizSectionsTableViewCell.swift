//
//  QuizSectionsTableViewCell.swift
//  QUIZ
//
//  Created by Марк Киричко on 18.01.2023.
//

import UIKit

class QuizSectionsTableViewCell: UITableViewCell {

    static let identifier = "QuizSectionsTableViewCell"
    private let animation = AnimationClass()
    
    @IBOutlet weak var QuizSectionIcon: RoundedImageView!
    @IBOutlet weak var QuizSectionCategoryName: UILabel!
    @IBOutlet weak var QuizSectionItemCount: UILabel!
    @IBOutlet weak var PercentageLabel: UILabel!
    
    func configure(section: QuizSectionModel) {
        QuizSectionIcon.image = UIImage(named: section.icon)
        QuizSectionIcon.sound = section.sound
        QuizSectionCategoryName.text = section.name
        QuizSectionItemCount.text = "пройдено: \(section.itemsCount)/20"
        PercentageLabel.text = "итог: \(section.percentage)%"
    }
    
    func didSelect(indexPath: IndexPath) {
        animation.springImage(image: QuizSectionIcon)
        animation.springLabel(label: QuizSectionCategoryName)
        animation.springLabel(label: QuizSectionItemCount)
        animation.springLabel(label: PercentageLabel)
    }
    
}
