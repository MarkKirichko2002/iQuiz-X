//
//  QuizSectionsTableViewCell.swift
//  QUIZ
//
//  Created by Марк Киричко on 18.01.2023.
//

import UIKit
import SCLAlertView

class QuizSectionsTableViewCell: UITableViewCell {

    static let identifier = "QuizSectionsTableViewCell"
    private let animation = AnimationClass()
    private var section: QuizSectionModel?
    var vc: UIViewController?
    
    @IBOutlet weak var QuizSectionIcon: RoundedImageView!
    @IBOutlet weak var QuizSectionCategoryName: UILabel!
    @IBOutlet weak var QuizSectionItemCount: UILabel!
    @IBOutlet weak var PercentageLabel: UILabel!
    @IBOutlet weak var InfoButton: UIButton!
    
    @IBAction func ShowInfo() {
        animation.SpringAnimation(view: self.InfoButton)
        if let section = section {
            ShowAlert(message: section.name, info: section.info)
        }
    }
    
    private func ShowAlert(message: String, info: String) {
        
        let dialogMessage = UIAlertController(title: message, message: info, preferredStyle: .alert)
         
         let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
             
          })
         
         dialogMessage.addAction(ok)
         
        self.vc?.present(dialogMessage, animated: true, completion: nil)
    }
    
    func configure(section: QuizSectionModel) {
        QuizSectionIcon.image = UIImage(named: section.icon)
        QuizSectionIcon.sound = section.sound
        QuizSectionCategoryName.text = section.name
        if section.completedItemsCount != nil {
            QuizSectionItemCount.text = "пройдено: \(section.completedItemsCount ?? 0)/\(section.itemsCount)"
        } else {
            QuizSectionItemCount.text = "элементов: \(section.itemsCount)"
        }
        if section.percentage != nil {
            PercentageLabel.text = "итог: \(section.percentage ?? 0)%"
        } else {
            PercentageLabel.text = nil
        }
        self.section = section
    }
    
    func didSelect(indexPath: IndexPath) {
        animation.SpringAnimation(view: QuizSectionIcon)
        animation.SpringAnimation(view: QuizSectionCategoryName)
        animation.SpringAnimation(view: QuizSectionItemCount)
        animation.SpringAnimation(view: PercentageLabel)
    }
    
}
