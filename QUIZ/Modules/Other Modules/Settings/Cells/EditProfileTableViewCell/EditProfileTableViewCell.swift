//
//  EditProfileTableViewCell.swift
//  QUIZ
//
//  Created by Марк Киричко on 14.05.2022.
//

import UIKit

class EditProfileTableViewCell: UITableViewCell {

    static let identifier = "EditProfileTableViewCell"
    private let settingsManager = SettingsManager()
    
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var EmailLabel: UILabel!
    @IBOutlet weak var PasswordLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        settingsManager.loadProfileInfo { info in
            DispatchQueue.main.async {
                self.NameLabel.text = info.name
                self.EmailLabel.text = info.email
                self.PasswordLabel.text = info.password
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
