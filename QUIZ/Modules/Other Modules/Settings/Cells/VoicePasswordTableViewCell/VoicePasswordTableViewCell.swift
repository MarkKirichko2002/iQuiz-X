//
//  VoicePasswordTableViewCell.swift
//  QUIZ
//
//  Created by Марк Киричко on 23.04.2022.
//

import UIKit

class VoicePasswordTableViewCell: UITableViewCell {

    static let identifier = "VoicePasswordTableViewCell"
    private let settingsManager = SettingsManager()
    @IBOutlet weak var VoicePasswordImage: UIImageView!
    @IBOutlet weak var Password: UILabel!
    @IBOutlet weak var PasswordStatus: UILabel!
    
    func CheckVoicePassword() {
        if self.settingsManager.voicepassword == nil {
            self.Password.text = "пароль: отсутствует"
            self.PasswordStatus.text = "❌"
        } else {
            self.Password.text = "пароль: \(settingsManager.voicepassword)"
            self.PasswordStatus.text = "✔️"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
            Password.text = settingsManager.voicepassword
            self.CheckVoicePassword()
        }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

