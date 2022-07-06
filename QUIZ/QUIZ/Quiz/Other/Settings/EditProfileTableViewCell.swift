//
//  EditProfileTableViewCell.swift
//  QUIZ
//
//  Created by Марк Киричко on 14.05.2022.
//

import UIKit

class EditProfileTableViewCell: UITableViewCell {

    static let identifier = "EditProfileTableViewCell"
    
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var EmailLabel: UILabel!
    @IBOutlet weak var PasswordLabel: UILabel!
    
    var auth = FBAuth()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        auth.loadSecretInfo(namelabel: NameLabel, emailLabel: EmailLabel, passwordLabel: PasswordLabel)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
