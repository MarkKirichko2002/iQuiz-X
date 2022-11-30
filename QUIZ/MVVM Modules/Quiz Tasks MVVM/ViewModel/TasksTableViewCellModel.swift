//
//  TasksTableViewCellModel.swift
//  QUIZ
//
//  Created by Марк Киричко on 02.07.2022.
//

import Foundation
import UIKit
import Firebase

class TasksTableViewCellModel {
    
    let db = Firestore.firestore()
    
    func LoadData(quizpath: String, TaskStatus: UILabel) {
        
        let docRef = db.collection("users").document((Auth.auth().currentUser?.email)!)
        
        docRef.getDocument { document, error in
            if let error = error as NSError? {
                print("Error getting document: \(error.localizedDescription)")
            } else {
                if let document = document {
                    
                    if let category = document[quizpath] as? [String: Any] {
                        let complete = category["complete"] as? Bool ?? false
                        let bestscore = category["bestscore"] as? Int ?? 0
                        
                        TaskStatus.text = "\(complete)"
                        
                        if complete == nil {
                            TaskStatus.text = "еще не пройдено"
                            TaskStatus.textColor = UIColor.gray
                        } else if complete == true {
                            TaskStatus.text = "пройдено"
                            TaskStatus.textColor = UIColor.systemGreen
                        }
                    }
                }
            }
        }
    }
    
    
    func configure(_ task: TaskModel, TaskImage: UIImageView, TaskText: UILabel, TaskStatus: UILabel, background: UIView)  {
        background.backgroundColor = UIColor(patternImage: UIImage(named: task.background)!)
        TaskImage.image = UIImage(named: task.image)
        TaskText.text = task.name
        
        if task.complete == nil || task.complete == false {
            TaskStatus.text = "еще не пройдено"
            TaskStatus.textColor = UIColor.gray
        }
        
        switch task.id {
            
        case 1:
            LoadData(quizpath: "quizplanets", TaskStatus: TaskStatus)
            
        case 2:
            LoadData(quizpath: "quizhistory", TaskStatus: TaskStatus)
            
        case 3:
            LoadData(quizpath: "quizanatomy", TaskStatus: TaskStatus)
            
        case 4:
            LoadData(quizpath: "quizsport", TaskStatus: TaskStatus)
            
        case 5:
            LoadData(quizpath: "quizgames", TaskStatus: TaskStatus)
            
        case 6:
            LoadData(quizpath: "quiziq", TaskStatus: TaskStatus)
            
        case 7:
            LoadData(quizpath: "quizeconomy", TaskStatus: TaskStatus)
            
        case 8:
            LoadData(quizpath: "quizgeography", TaskStatus: TaskStatus)
            
        case 9:
            LoadData(quizpath: "quizecology", TaskStatus: TaskStatus)
            
        case 10:
            LoadData(quizpath: "quizphysics", TaskStatus: TaskStatus)
            
        case 11:
            LoadData(quizpath: "quizchemistry", TaskStatus: TaskStatus)
            
        case 12:
            LoadData(quizpath: "quizinformatics", TaskStatus: TaskStatus)
            
        case 13:
            LoadData(quizpath: "quizliterature", TaskStatus: TaskStatus)
            
        case 14:
            LoadData(quizpath: "quizroadtraffic", TaskStatus: TaskStatus)
            
        case 15:
            LoadData(quizpath: "quizswift", TaskStatus: TaskStatus)
            
        case 16:
            LoadData(quizpath: "quizunderwater", TaskStatus: TaskStatus)
            
        case 17:
            LoadData(quizpath: "quizchess", TaskStatus: TaskStatus)
            
        case 18:
            LoadData(quizpath: "quizhalloween", TaskStatus: TaskStatus)
            
        case 19:
            LoadData(quizpath: "lastquiz", TaskStatus: TaskStatus)
            
        default:
            //LoadData(quizpath: "quizplanets", background: "earth.background.jpeg")
            break
        }
    }
}
