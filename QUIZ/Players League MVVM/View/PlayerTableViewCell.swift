//
//  PlayerTableViewCell.swift
//  QUIZ
//
//  Created by Марк Киричко on 25.02.2022.
//

import UIKit
import Firebase
import SDWebImage

class PlayerTableViewCell: UITableViewCell {
    
    static let identifier = "PlayerTableViewCell"
    
    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var UserEmail: UILabel!
    @IBOutlet weak var PlayerImage: UIImageView!
    @IBOutlet weak var PlayerBestScore: UILabel!
    
}
