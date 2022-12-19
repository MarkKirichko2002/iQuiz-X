//
//  DeleteTableViewCell.swift
//  QUIZ
//
//  Created by Марк Киричко on 04.04.2022.
//

import UIKit
import Firebase

class DeleteTableViewCell: UITableViewCell {

    static let identifier = "DeleteTableViewCell"
    
    var auth = FirebaseManager()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        //auth.delete()
    }

}
