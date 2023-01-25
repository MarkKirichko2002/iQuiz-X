//
//  PlayerTableViewCell.swift
//  QUIZ
//
//  Created by Марк Киричко on 25.02.2022.
//

import UIKit
import SDWebImage
import Firebase

class PlayerTableViewCell: UITableViewCell {
    
    static let identifier = "PlayerTableViewCell"
    private let animation = AnimationClass()
    
    @IBOutlet weak var PlayerImage: RoundedImageView!
    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var UserEmail: UILabel!
    @IBOutlet weak var PlayerBestScore: UILabel!
    
    func didSelect(indexPath: IndexPath) {
        animation.springImage(image: PlayerImage)
        animation.springLabel(label: UserName)
        animation.springLabel(label: UserEmail)
        animation.springLabel(label: PlayerBestScore)
    }
    
    func configure(players: Player) {
        PlayerImage.sd_setImage(with: URL(string: players.image))
        PlayerImage.sound = players.sound
        PlayerImage.color = UIColor.white
        if players.email == Auth.auth().currentUser?.email {
            UserName.text = "Вы (\(players.name))"
            UserName.textColor = UIColor.systemGreen
        } else {
            UserName.text = players.name
            UserName.textColor = UIColor.white
        }
        UserEmail.text = players.email
        UserEmail.textColor = UIColor.white
        PlayerBestScore.text = "\(players.counter)/100 (\(players.category))"
        PlayerBestScore.textColor = UIColor.white
        backgroundColor = UIColor(patternImage: UIImage(named: players.background)!)
    }
}
