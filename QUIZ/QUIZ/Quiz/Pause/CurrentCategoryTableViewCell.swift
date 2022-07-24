//
//  CurrentCategoryTableViewCell.swift
//  QUIZ
//
//  Created by Марк Киричко on 04.05.2022.
//

import UIKit

class CurrentCategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var CurrentImage: UIImageView!
    @IBOutlet weak var CurrentName: UILabel!
    @IBOutlet weak var CurrentScore: UILabel!
    @IBOutlet weak var CurrentQuestion: UILabel!
    
    var currentquiz = UserDefaults.standard.object(forKey: "currentquiz") as? Int
    var currentscore = UserDefaults.standard.object(forKey: "currentscore") as? Int
    var currentquestion = UserDefaults.standard.object(forKey: "currentquestion") as? Int
    
    static let identifier = "CurrentCategoryTableViewCell"
    
    func configure() {
        
        CurrentScore.text = "счет: \(currentscore ?? 0)/100"
        CurrentQuestion.text = "вопрос: \(currentquestion ?? 0)/20"
        
        CurrentName.textColor = UIColor.white
        CurrentScore.textColor = UIColor.white
        CurrentQuestion.textColor = UIColor.white
        
        switch currentquiz {
            
        case 1:
            CurrentImage.image = UIImage(named: "planets.jpeg")
            CurrentName.text = "планеты"
            backgroundColor = UIColor(patternImage: UIImage(named: "earth.background.jpeg")!)
        case 2:
            CurrentImage.image = UIImage(named: "history.jpeg")
            CurrentName.text = "история"
            backgroundColor = UIColor(patternImage: UIImage(named: "history.background.jpeg")!)
        case 3:
            CurrentImage.image = UIImage(named: "anatomy.jpeg")
            CurrentName.text = "анатомия"
            backgroundColor = UIColor(patternImage: UIImage(named: "anatomy.background.jpeg")!)
        case 4:
            CurrentImage.image = UIImage(named: "sport.jpeg")
            CurrentName.text = "спорт"
            backgroundColor = UIColor(patternImage: UIImage(named: "sport.background.jpeg")!)
        case 5:
            CurrentImage.image = UIImage(named: "games.jpeg")
            CurrentName.text = "игры"
            backgroundColor = UIColor(patternImage: UIImage(named: "games.background.jpeg")!)
        case 6:
            CurrentImage.image = UIImage(named: "IQ.jpeg")
            CurrentName.text = "IQ"
            backgroundColor = UIColor(patternImage: UIImage(named: "IQ.background.jpeg")!)
        case 7:
            CurrentImage.image = UIImage(named: "economy.jpeg")
            CurrentName.text = "экономика"
            backgroundColor = UIColor(patternImage: UIImage(named: "economy.background.jpeg")!)
        case 8:
            CurrentImage.image = UIImage(named: "geography.jpeg")
            CurrentName.text = "география"
            backgroundColor = UIColor(patternImage: UIImage(named: "geography.background.jpeg")!)
        case 9:
            CurrentImage.image = UIImage(named: "ecology.jpeg")
            CurrentName.text = "экология"
            backgroundColor = UIColor(patternImage: UIImage(named: "ecology.background.jpeg")!)
        case 10:
            CurrentImage.image = UIImage(named: "physics.jpeg")
            CurrentName.text = "физика"
            backgroundColor = UIColor(patternImage: UIImage(named: "physics.background.jpeg")!)
        case 11:
            CurrentImage.image = UIImage(named: "chemistry.jpeg")
            CurrentName.text = "химия"
            backgroundColor = UIColor(patternImage: UIImage(named: "chemistry.background.jpeg")!)
        case 12:
            CurrentImage.image = UIImage(named: "informatics.jpeg")
            CurrentName.text = "информатика"
            backgroundColor = UIColor(patternImage: UIImage(named: "informatics.background.jpeg")!)
        case 13:
            CurrentImage.image = UIImage(named: "literature.jpeg")
            CurrentName.text = "литература"
            backgroundColor = UIColor(patternImage: UIImage(named: "literature.background.jpeg")!)
        case 14:
            CurrentImage.image = UIImage(named: "drive.jpeg")
            CurrentName.text = "ПДД"
            backgroundColor = UIColor(patternImage: UIImage(named: "drive.background.jpeg")!)
        case 15:
            CurrentImage.image = UIImage(named: "swift.jpeg")
            CurrentName.text = "Swift"
            backgroundColor = UIColor(patternImage: UIImage(named: "swift.background.jpeg")!)
        case 16:
            CurrentImage.image = UIImage(named: "underwater.png")
            CurrentName.text = "подводный мир"
            backgroundColor = UIColor(patternImage: UIImage(named: "underwater.background.jpeg")!)
        
        case 17:
            CurrentImage.image = UIImage(named: "chess.png")
            CurrentName.text = "шахматы"
            backgroundColor = UIColor(patternImage: UIImage(named: "chess.background.jpeg")!)
            
        default: break
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
