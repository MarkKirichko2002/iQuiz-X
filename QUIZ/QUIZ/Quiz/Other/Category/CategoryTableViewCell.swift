//
//  CategoryTableViewCell.swift
//  QUIZ
//
//  Created by Марк Киричко on 26.02.2022.
//

import UIKit
import Firebase

class CategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var CategoryText: UILabel!
    @IBOutlet weak var CategoryImage: UIImageView!
    @IBOutlet weak var isComplete: UILabel!
    @IBOutlet weak var CategoryScore: UILabel!
    
    
    var animation = AnimationClass()
    
    let db = Firestore.firestore()
    
    static let identifier = "CategoryTableViewCell"
    
    var player = SoundClass()
    
    func LoadData(quizpath: String, background: String) {
            backgroundColor = UIColor(patternImage: UIImage(named: background)!)
        let docRef = db.collection("users").document(Auth.auth().currentUser?.email ?? "")

              docRef.getDocument { document, error in
                if let error = error as NSError? {
                print("Error getting document: \(error.localizedDescription)")
                }
                else {
                  if let document = document {
                      
                      
                      if let category = document[quizpath] as? [String: Any] {
                          let complete = category["complete"] as? Bool ?? false
                          let bestscore = category["bestscore"] as? Int ?? 228
    
                         
                          self.CategoryScore.text = "\(bestscore ?? 0)/100 баллов"
                          self.isComplete.text = "\(complete)"
                          
                          
                          if bestscore == 100 && complete == true {
                              self.isComplete.text = "пройдено 100 %"
                              self.isComplete.textColor = UIColor.systemGreen
                              //self.CategoryImage.flash()
                          } else if complete == nil {
                              self.isComplete.text = "еще не пройдено"
                              self.isComplete.textColor = UIColor.systemRed
                          } else if complete == true {
                              self.isComplete.text = "пройдено"
                              self.isComplete.textColor = UIColor.systemGreen
                          }
                      }
                  }
                }
            }
        }

    // создаем ячейку в таблице
    func configure(_ category: QuizModel)  {
        CategoryImage.image = UIImage(named: category.image)
        CategoryText.text = category.name
        CategoryScore.text = "\(category.score)/100"
        
        if category.complete == nil || category.complete == false {
            self.isComplete.text = "еще не пройдено"
            self.isComplete.textColor = UIColor.systemRed
        }
        
        switch category.id {
            
        case 1:
           LoadData(quizpath: "quizplanets", background: "earth.background.jpeg")
            
        case 2:
           LoadData(quizpath: "quizhistory", background: "history.background.jpeg")
        
        case 3:
            LoadData(quizpath: "quizanatomy", background: "anatomy.background.jpeg")
            
        case 4:
            LoadData(quizpath: "quizsport", background: "sport.background.jpeg")
        
        case 5:
            LoadData(quizpath: "quizgames", background: "games.background.jpeg")
            
        case 6:
            LoadData(quizpath: "quiziq", background: "IQ.background.jpeg")
            
        case 7:
            LoadData(quizpath: "quizeconomy", background: "economy.background.jpeg")
            
        case 8:
            LoadData(quizpath: "quizgeography", background: "geography.background.jpeg")
            
        case 9:
            LoadData(quizpath: "quizecology", background: "ecology.background.jpeg")
            
        case 10:
            LoadData(quizpath: "quizphysics", background: "physics.background.jpeg")
            
        case 11:
            LoadData(quizpath: "quizchemistry", background: "chemistry.background.jpeg")
            
        case 12:
            LoadData(quizpath: "quizinformatics", background: "informatics.background.jpeg")
        
        case 13:
            LoadData(quizpath: "quizliterature", background: "literature.background.jpeg")
            
        case 14:
            LoadData(quizpath: "quizroadtraffic", background: "drive.background.jpeg")
        
        case 15:
            LoadData(quizpath: "quizswift", background: "swift.background.jpeg")
            
        case 16:
            LoadData(quizpath: "quizunderwater", background: "underwater.background.jpeg")
            
        case 17:
            LoadData(quizpath: "lastquiz", background: "random.background.jpeg")
            
        default:
           //LoadData(quizpath: "quizplanets", background: "earth.background.jpeg")
            break
        }
        
    }
}
