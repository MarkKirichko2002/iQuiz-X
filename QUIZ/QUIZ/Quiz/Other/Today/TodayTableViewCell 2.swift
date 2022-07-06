//
//  TodayTableViewCell.swift
//  QUIZ
//
//  Created by Марк Киричко on 24.03.2022.
//

import UIKit
import Firebase

class TodayTableViewCell: UITableViewCell {
    
    @IBOutlet weak var TodayName: UILabel!
    @IBOutlet weak var TodayImage: UIImageView!
    
    

    static let identifier = "TodayTableViewCell"
    
    // создаем ячейку в таблице
    func configure(_ today: TodayModel)  {
        TodayImage.image = UIImage(named: today.image)
        TodayName.text = today.name
        backgroundColor = UIColor(patternImage: UIImage(named: today.background)!)
    }
    
}
