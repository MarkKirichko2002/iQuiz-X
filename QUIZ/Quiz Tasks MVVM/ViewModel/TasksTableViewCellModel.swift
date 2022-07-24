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
    
    func LoadData(quizpath: String, background: String, TaskStatus: UILabel, view: UIView) {
        
        view.backgroundColor = UIColor(patternImage: UIImage(named: background)!)
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
        TaskImage.image = UIImage(named: task.image)
        TaskText.text = task.name
        
        if task.complete == nil || task.complete == false {
            TaskStatus.text = "еще не пройдено"
            TaskStatus.textColor = UIColor.gray
        }
        
        switch task.id {
            
        case 1:
            LoadData(quizpath: "quizplanets", background: "earth.background.jpeg", TaskStatus: TaskStatus, view: background)
            
        case 2:
            LoadData(quizpath: "quizhistory", background: "history.background.jpeg", TaskStatus: TaskStatus, view: background)
            
        case 3:
            LoadData(quizpath: "quizanatomy", background: "anatomy.background.jpeg", TaskStatus: TaskStatus, view: background)
            
        case 4:
            LoadData(quizpath: "quizsport", background: "sport.background.jpeg", TaskStatus: TaskStatus, view: background)
            
        case 5:
            LoadData(quizpath: "quizgames", background: "games.background.jpeg", TaskStatus: TaskStatus, view: background)
            
        case 6:
            LoadData(quizpath: "quiziq", background: "IQ.background.jpeg", TaskStatus: TaskStatus, view: background)
            
        case 7:
            LoadData(quizpath: "quizeconomy", background: "economy.background.jpeg", TaskStatus: TaskStatus, view: background)
            
        case 8:
            LoadData(quizpath: "quizgeography", background: "geography.background.jpeg", TaskStatus: TaskStatus, view: background)
            
        case 9:
            LoadData(quizpath: "quizecology", background: "ecology.background.jpeg", TaskStatus: TaskStatus, view: background)
            
        case 10:
            LoadData(quizpath: "quizphysics", background: "physics.background.jpeg", TaskStatus: TaskStatus, view: background)
            
        case 11:
            LoadData(quizpath: "quizchemistry", background: "chemistry.background.jpeg", TaskStatus: TaskStatus, view: background)
            
        case 12:
            LoadData(quizpath: "quizinformatics", background: "informatics.background.jpeg", TaskStatus: TaskStatus, view: background)
            
        case 13:
            LoadData(quizpath: "quizliterature", background: "literature.background.jpeg", TaskStatus: TaskStatus, view: background)
            
        case 14:
            LoadData(quizpath: "quizroadtraffic", background: "drive.background.jpeg", TaskStatus: TaskStatus, view: background)
            
        case 15:
            LoadData(quizpath: "quizswift", background: "swift.background.jpeg", TaskStatus: TaskStatus, view: background)
            
        case 16:
            LoadData(quizpath: "quizunderwater", background: "underwater.background.jpeg", TaskStatus: TaskStatus, view: background)
            
        case 17:
            LoadData(quizpath: "quizchess", background: "chess.background.jpeg", TaskStatus: TaskStatus, view: background)
            
        case 18:
            LoadData(quizpath: "lastquiz", background: "random.background.jpeg", TaskStatus: TaskStatus, view: background)
            
        default:
            //LoadData(quizpath: "quizplanets", background: "earth.background.jpeg")
            break
        }
    }
}
