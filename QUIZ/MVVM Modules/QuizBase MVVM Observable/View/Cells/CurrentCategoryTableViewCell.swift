//
//  CurrentCategoryTableViewCell.swift
//  QUIZ
//
//  Created by Марк Киричко on 04.05.2022.
//

import UIKit

class CurrentCategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var CurrentImage: RoundedImageView!
    @IBOutlet weak var CurrentName: UILabel!
    @IBOutlet weak var CurrentScore: UILabel!
    @IBOutlet weak var CurrentQuestion: UILabel!
    
    static let identifier = "CurrentCategoryTableViewCell"
    
}
