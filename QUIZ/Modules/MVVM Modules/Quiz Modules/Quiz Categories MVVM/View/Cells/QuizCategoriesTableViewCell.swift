//
//  QuizCategoriesTableViewCell.swift
//  QUIZ
//
//  Created by Марк Киричко on 26.02.2022.
//

import UIKit

class QuizCategoriesTableViewCell: UITableViewCell {
    
    static let identifier = "QuizCategoriesTableViewCell"
    private let animation = AnimationClass()
    private var percentage = 0
    var delegate: CustomViewCellDelegate?
    
    @IBOutlet weak var CategoryText: UILabel!
    @IBOutlet weak var CategoryImage: RoundedImageView!
    @IBOutlet weak var isComplete: UILabel!
    @IBOutlet weak var CategoryScore: UILabel!
    
    func ConfigureCell(category: QuizCategoryModel) {
        CategoryImage.image = UIImage(named: category.image)
        CategoryImage.sound = category.sound
        CategoryImage.music = category.music
        CategoryImage.color = .white
        CategoryText.text = category.name
        CategoryScore.text = "\(category.score)/100 баллов"
        percentage = (category.score * 100) / 100
        contentView.backgroundColor = UIColor(patternImage: UIImage(named: category.background)!)
        switch category.complete {
        case true:
            isComplete.text = "пройдено: \(percentage)%"
            isComplete.textColor = .systemGreen
        case false:
            isComplete.text = "пройдено: \(percentage)%"
            isComplete.textColor = .white
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
