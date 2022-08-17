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
    
    func configure(players: Player) {
        PlayerImage.sd_setImage(with: URL(string: players.image))
        UserName.text = players.name
        UserName.textColor = UIColor.white
        UserEmail.text = players.email
        UserEmail.textColor = UIColor.white
        PlayerBestScore.text = "\(players.counter)/100 (\(players.category))"
        PlayerBestScore.textColor = UIColor.white
        backgroundColor = UIColor(patternImage: UIImage(named: players.background)!)
    }
    
}
