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
    
    func LoadData(quizpath: String, isComplete: UILabel, CategoryScore: UILabel) {
        let docRef = db.collection("users").document(Auth.auth().currentUser?.email ?? "")
        
        docRef.getDocument { document, error in
            if let error = error as NSError? {
                print("Error getting document: \(error.localizedDescription)")
            } else {
                if let document = document {
                    
                    if let category = document[quizpath] as? [String: Any] {
                        let complete = category["complete"] as? Bool ?? false
                        let bestscore = category["bestscore"] as? Int ?? 0
                        let CorrectAnswersCounter = category["CorrectAnswersCounter"] as? Int ?? 0
                        
                        CategoryScore.text = "\(bestscore)/100 баллов"
                        isComplete.text = "\(complete)"
                        
                        if complete == true && CorrectAnswersCounter != nil {
                            isComplete.text = "пройдено \(CorrectAnswersCounter)/20"
                            isComplete.textColor = UIColor.systemGreen
                        } else if complete == nil || complete == false {
                            isComplete.text = "еще не пройдено"
                            isComplete.textColor = UIColor.gray
                        }
                    }
                }
            }
        }
    }
    
    
    func configure(_ category: QuizModel, CategoryImage: UIImageView, CategoryText: UILabel, isComplete: UILabel, CategoryScore: UILabel, background: UIView)  {
        background.backgroundColor = UIColor(patternImage: UIImage(named: category.background)!)
        CategoryImage.image = UIImage(named: category.image)
        CategoryText.text = category.name
        CategoryScore.text = "\(category.score)/100"
        
        if category.complete == nil || category.complete == false {
            isComplete.text = "еще не пройдено 0/20"
            isComplete.textColor = UIColor.gray
        }
        
        switch category.id {
            
        case 1:
            LoadData(quizpath: "quizplanets", isComplete: isComplete, CategoryScore: CategoryScore)
            
        case 2:
            LoadData(quizpath: "quizhistory", isComplete: isComplete, CategoryScore: CategoryScore)
            
        case 3:
            LoadData(quizpath: "quizanatomy", isComplete: isComplete, CategoryScore: CategoryScore)
            
        case 4:
            LoadData(quizpath: "quizsport", isComplete: isComplete, CategoryScore: CategoryScore)
            
        case 5:
            LoadData(quizpath: "quizgames", isComplete: isComplete, CategoryScore: CategoryScore)
            
        case 6:
            LoadData(quizpath: "quiziq", isComplete: isComplete, CategoryScore: CategoryScore)
            
        case 7:
            LoadData(quizpath: "quizeconomy", isComplete: isComplete, CategoryScore: CategoryScore)
            
        case 8:
            LoadData(quizpath: "quizgeography", isComplete: isComplete, CategoryScore: CategoryScore)
            
        case 9:
            LoadData(quizpath: "quizecology", isComplete: isComplete, CategoryScore: CategoryScore)
            
        case 10:
            LoadData(quizpath: "quizphysics", isComplete: isComplete, CategoryScore: CategoryScore)
            
        case 11:
            LoadData(quizpath: "quizchemistry", isComplete: isComplete, CategoryScore: CategoryScore)
            
        case 12:
            LoadData(quizpath: "quizinformatics", isComplete: isComplete, CategoryScore: CategoryScore)
            
        case 13:
            LoadData(quizpath: "quizliterature", isComplete: isComplete, CategoryScore: CategoryScore)
            
        case 14:
            LoadData(quizpath: "quizroadtraffic", isComplete: isComplete, CategoryScore: CategoryScore)
            
        case 15:
            LoadData(quizpath: "quizswift", isComplete: isComplete, CategoryScore: CategoryScore)
            
        case 16:
            LoadData(quizpath: "quizunderwater", isComplete: isComplete, CategoryScore: CategoryScore)
           
        case 17:
            LoadData(quizpath: "quizchess", isComplete: isComplete, CategoryScore: CategoryScore)
            
        case 18:
            LoadData(quizpath: "quizhalloween", isComplete: isComplete, CategoryScore: CategoryScore)
            
        case 19:
            LoadData(quizpath: "lastquiz", isComplete: isComplete, CategoryScore: CategoryScore)
        
        default:
            //LoadData(quizpath: "quizplanets", background: "earth.background.jpeg")
            break
        }
        
    }
    
}
