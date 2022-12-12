//
//  PhotoTableViewCell.swift
//  QUIZ
//
//  Created by Марк Киричко on 04.04.2022.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {

    
    
    static let identifier = "PhotoTableViewCell"
    
    var auth = FBManager()
    
    @IBOutlet weak var SettingsImage: UIImageView!
    
 

    override func awakeFromNib() {
        super.awakeFromNib()
        self.auth.load(profileimage: SettingsImage)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
