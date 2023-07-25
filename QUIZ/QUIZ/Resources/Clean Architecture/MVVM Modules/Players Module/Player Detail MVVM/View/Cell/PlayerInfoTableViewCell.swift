//
//  PlayerInfoTableViewCell.swift
//  QUIZ
//
//  Created by Марк Киричко on 15.05.2023.
//

import UIKit
import SDWebImage

class PlayerInfoTableViewCell: UITableViewCell {
    
    static let identifier = "PlayerInfoTableViewCell"
    
    @IBOutlet weak var PlayerImage: RoundedImageView!
    @IBOutlet weak var PlayerName: UILabel!
    @IBOutlet weak var PlayerEmail: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    
    func configure(player: Player) {
        PlayerImage.sd_setImage(with: URL(string: player.image))
        PlayerName.text = player.name
        PlayerEmail.text = player.email
        DateLabel.text = player.date
    }
}
