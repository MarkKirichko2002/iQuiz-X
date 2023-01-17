//
//  QuizSectionsTableViewCell.swift
//  QUIZ
//
//  Created by Марк Киричко on 18.01.2023.
//

import UIKit

class QuizSectionsTableViewCell: UITableViewCell {

    static let identifier = "QuizSectionsTableViewCell"
    
    @IBOutlet weak var QuizSectionIcon: RoundedImageView!
    @IBOutlet weak var QuizSectionCategoryName: UILabel!
    
    func configure(section: QuizSectionModel) {
        QuizSectionIcon.image = UIImage(named: section.icon)
        QuizSectionCategoryName.text = section.name
    }
    
}
