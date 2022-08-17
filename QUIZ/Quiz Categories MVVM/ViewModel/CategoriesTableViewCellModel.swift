//
//  CategoriesTableViewCellModel.swift
//  QUIZ
//
//  Created by Марк Киричко on 02.07.2022.
//

import Foundation
import UIKit
import Firebase


class CategoriesTableViewCellModel {
    
    let db = Firestore.firestore()
    
    func LoadData(quizpath: String, background: String, isComplete: UILabel, CategoryScore: UILabel, view: UIView) {
        view.backgroundColor = UIColor(patternImage: UIImage(named: background)!)
        let docRef = db.collection("users").document(Auth.auth().currentUser?.email ?? "")
        
        docRef.getDocument { document, error in
            if let error = error as NSError? {
                print("Error getting document: \(error.localizedDescription)")
            } else {
                if let document = document {
                    
                    if let category = document[quizpath] as? [String: Any] {
                        let complete = category["complete"] as? Bool ?? false
                        let bestscore = category["bestscore"] as? Int ?? 0
                        
                        CategoryScore.text = "\(bestscore ?? 0)/100 баллов"
                        isComplete.text = "\(complete)"
                        
                        if bestscore == 100 && complete == true {
                            isComplete.text = "пройдено 100 %"
                            isComplete.textColor = UIColor.systemGreen
                            //self.CategoryImage.flash()
                        } else if complete == nil {
                            isComplete.text = "еще не пройдено"
                            isComplete.textColor = UIColor.gray
                        } else if complete == true {
                            isComplete.text = "пройдено"
                            isComplete.textColor = UIColor.systemGreen
                        }
                    }
                }
            }
        }
    }
    
    
    func configure(_ category: QuizModel, CategoryImage: UIImageView, CategoryText: UILabel, isComplete: UILabel, CategoryScore: UILabel, background: UIView)  {
        CategoryImage.image = UIImage(named: category.image)
        CategoryText.text = category.name
        CategoryScore.text = "\(category.score)/100"
        
        if category.complete == nil || category.complete == false {
            isComplete.text = "еще не пройдено"
            isComplete.textColor = UIColor.gray
        }
        
        switch category.id {
            
        case 1:
            LoadData(quizpath: "quizplanets", background: "earth.background.jpeg", isComplete: isComplete, CategoryScore: CategoryScore, view: background)
            
        case 2:
            LoadData(quizpath: "quizhistory", background: "history.background.jpeg", isComplete: isComplete, CategoryScore: CategoryScore, view: background)
            
        case 3:
            LoadData(quizpath: "quizanatomy", background: "anatomy.background.jpeg", isComplete: isComplete, CategoryScore: CategoryScore, view: background)
            
        case 4:
            LoadData(quizpath: "quizsport", background: "sport.background.jpeg", isComplete: isComplete, CategoryScore: CategoryScore, view: background)
            
        case 5:
            LoadData(quizpath: "quizgames", background: "games.background.jpeg", isComplete: isComplete, CategoryScore: CategoryScore, view: background)
            
        case 6:
            LoadData(quizpath: "quiziq", background: "IQ.background.jpeg", isComplete: isComplete, CategoryScore: CategoryScore, view: background)
            
        case 7:
            LoadData(quizpath: "quizeconomy", background: "economy.background.jpeg", isComplete: isComplete, CategoryScore: CategoryScore, view: background)
            
        case 8:
            LoadData(quizpath: "quizgeography", background: "geography.background.jpeg", isComplete: isComplete, CategoryScore: CategoryScore, view: background)
            
        case 9:
            LoadData(quizpath: "quizecology", background: "ecology.background.jpeg", isComplete: isComplete, CategoryScore: CategoryScore, view: background)
            
        case 10:
            LoadData(quizpath: "quizphysics", background: "physics.background.jpeg", isComplete: isComplete, CategoryScore: CategoryScore, view: background)
            
        case 11:
            LoadData(quizpath: "quizchemistry", background: "chemistry.background.jpeg", isComplete: isComplete, CategoryScore: CategoryScore, view: background)
            
        case 12:
            LoadData(quizpath: "quizinformatics", background: "informatics.background.jpeg", isComplete: isComplete, CategoryScore: CategoryScore, view: background)
            
        case 13:
            LoadData(quizpath: "quizliterature", background: "literature.background.jpeg", isComplete: isComplete, CategoryScore: CategoryScore, view: background)
            
        case 14:
            LoadData(quizpath: "quizroadtraffic", background: "drive.background.jpeg", isComplete: isComplete, CategoryScore: CategoryScore, view: background)
            
        case 15:
            LoadData(quizpath: "quizswift", background: "swift.background.jpeg", isComplete: isComplete, CategoryScore: CategoryScore, view: background)
            
        case 16:
            LoadData(quizpath: "quizunderwater", background: "underwater.background.jpeg", isComplete: isComplete, CategoryScore: CategoryScore, view: background)
           
        case 17:
            LoadData(quizpath: "quizchess", background: "chess.background.jpeg", isComplete: isComplete, CategoryScore: CategoryScore, view: background)
            
        case 18:
            LoadData(quizpath: "lastquiz", background: "random.background.jpeg", isComplete: isComplete, CategoryScore: CategoryScore, view: background)
        
        default:
            //LoadData(quizpath: "quizplanets", background: "earth.background.jpeg")
            break
        }
        
    }
    
}
