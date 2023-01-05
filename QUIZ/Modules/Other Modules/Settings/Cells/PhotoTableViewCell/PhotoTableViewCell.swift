//
//  PhotoTableViewCell.swift
//  QUIZ
//
//  Created by Марк Киричко on 04.04.2022.
//

import UIKit
import SDWebImage

class PhotoTableViewCell: UITableViewCell {

    static let identifier = "PhotoTableViewCell"
    private let settingsManager = SettingsManager()
    
    @IBOutlet weak var SettingsImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        SettingsImage.sd_setImage(with: URL(string: settingsManager.profileImage))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
