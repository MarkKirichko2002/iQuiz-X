//
//  CategoryTableViewCell.swift
//  QUIZ
//
//  Created by Марк Киричко on 26.02.2022.
//

import UIKit
import Firebase

class CategoryTableViewCell: UITableViewCell {
    
    static let identifier = "CategoryTableViewCell"
    var animation = AnimationClass()
    
    @IBOutlet weak var CategoryText: UILabel!
    @IBOutlet weak var CategoryImage: RoundedImageView!
    @IBOutlet weak var isComplete: UILabel!
    @IBOutlet weak var CategoryScore: UILabel!
    
    func didSelect(indexPath: IndexPath) {
        animation.springImage(image: CategoryImage)
        animation.springLabel(label: CategoryText)
        animation.springLabel(label: isComplete)
        animation.springLabel(label: CategoryScore)
    }
    
}
