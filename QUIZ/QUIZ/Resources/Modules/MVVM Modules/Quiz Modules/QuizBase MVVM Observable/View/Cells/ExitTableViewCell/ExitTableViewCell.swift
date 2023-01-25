//
//  ExitTableViewCell.swift
//  QUIZ
//
//  Created by Марк Киричко on 03.04.2022.
//

import UIKit

class ExitTableViewCell: UITableViewCell {

    static let identifier = "ExitTableViewCell"
    private let animation = AnimationClass()
    
    @IBOutlet weak var ExitIcon: RoundedImageView!
    @IBOutlet weak var ExitLabel: UILabel!
    
    func didSelect(indexPath: IndexPath) {
        animation.springImage(image: ExitIcon)
        animation.springLabel(label: ExitLabel)
    }
    
}
