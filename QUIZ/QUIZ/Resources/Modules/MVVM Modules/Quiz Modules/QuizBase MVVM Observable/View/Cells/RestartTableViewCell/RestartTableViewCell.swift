//
//  RetryTableViewCell.swift
//  QUIZ
//
//  Created by Марк Киричко on 05.05.2022.
//

import UIKit

class RestartTableViewCell: UITableViewCell {

    static let identifier = "RestartTableViewCell"
    private let animation = AnimationClass()
    
    @IBOutlet weak var RestartIcon: RoundedImageView!
    @IBOutlet weak var RestartLabel: UILabel!
    
    func didSelect(indexPath: IndexPath) {
        animation.springImage(image: RestartIcon)
        animation.springLabel(label: RestartLabel)
    }
}
