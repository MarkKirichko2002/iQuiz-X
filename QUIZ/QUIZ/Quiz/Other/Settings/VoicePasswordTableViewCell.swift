//
//  VoicePasswordTableViewCell.swift
//  QUIZ
//
//  Created by Марк Киричко on 23.04.2022.
//

import UIKit
import LocalAuthentication

class VoicePasswordTableViewCell: UITableViewCell {

    static let identifier = "VoicePasswordTableViewCell"
    
    let mycontext: LAContext = LAContext()
    
    var auth = FBAuth()
    
    var biometric = ""
    
    var voicepassword = UserDefaults.standard.object(forKey: "voicepassword")
    
    @IBOutlet weak var VoicePasswordImage: UIImageView!
    @IBOutlet weak var Password: UILabel!
    @IBOutlet weak var PasswordStatus: UILabel!
    
    func CheckVoicePassword() {
        if self.voicepassword == nil {
            self.Password.text = "пароль: отсутствует"
            self.PasswordStatus.text = "❌"
        } else {
            self.Password.text = "пароль: \(voicepassword ?? "")"
            self.PasswordStatus.text = "✔️"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
            self.auth.loadVoiceInfo(passwordLabel: Password)
            self.CheckVoicePassword()
        }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

