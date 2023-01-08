//
//  QuizCategoriesTableViewCell.swift
//  QUIZ
//
//  Created by Марк Киричко on 26.02.2022.
//

import UIKit
import Firebase

class QuizCategoriesTableViewCell: UITableViewCell {
    
    static let identifier = "QuizCategoriesTableViewCell"
    private let animation = AnimationClass()
    var delegate: CustomViewCellDelegate?
    
    @IBOutlet weak var CategoryText: UILabel!
    @IBOutlet weak var CategoryImage: RoundedImageView!
    @IBOutlet weak var isComplete: UILabel!
    @IBOutlet weak var CategoryScore: UILabel!
    
    func ConfigureCell(category: QuizCategoryModel) {
        CategoryImage.image = UIImage(named: category.image)
        CategoryImage.sound = category.sound
        CategoryImage.color = .white
        CategoryText.text = category.name
        CategoryScore.text = "\(category.score)/100 баллов"
        contentView.backgroundColor = UIColor(patternImage: UIImage(named: category.background)!)
        switch category.complete {
        case true:
            isComplete.text = "пройдено"
            isComplete.textColor = .systemGreen
        case false:
            isComplete.text = "не пройдено"
            isComplete.textColor = .systemGray
        }
    }
    
    func didSelect(indexPath: IndexPath) {
        animation.springImage(image: CategoryImage)
        animation.springLabel(label: CategoryText)
        animation.springLabel(label: isComplete)
        animation.springLabel(label: CategoryScore)
        delegate?.didElementClick()
    }
    
}
