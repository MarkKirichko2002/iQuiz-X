//
//  TasksTableViewCell.swift
//  QUIZ
//
//  Created by Марк Киричко on 20.02.2022.
//

import UIKit
import Firebase

class TasksTableViewCell: UITableViewCell {
    
    @IBOutlet weak var TaskText: UILabel!
    @IBOutlet weak var TaskImage: UIImageView!
    @IBOutlet weak var TaskStatus: UILabel!
    
    
    
    func LoadData(quizpath: String, background: String) {
            backgroundColor = UIColor(patternImage: UIImage(named: background)!)
            let docRef = db.collection("users").document((Auth.auth().currentUser?.email)!)

              docRef.getDocument { document, error in
                if let error = error as NSError? {
                print("Error getting document: \(error.localizedDescription)")
                }
                else {
                  if let document = document {
                      
                      
                      if let category = document[quizpath] as? [String: Any] {
                          let complete = category["complete"] as? Bool ?? false
                          let bestscore = category["bestscore"] as? Int ?? 228
    
                         
                          self.TaskStatus.text = "\(complete)"
                          
                          
                          if complete == nil {
                              self.TaskStatus.text = "еще не пройдено"
                              self.TaskStatus.textColor = UIColor.systemRed
                          } else if complete == true {
                              self.TaskStatus.text = "пройдено"
                              self.TaskStatus.textColor = UIColor.systemGreen
                          }
                                            
                      }
                    
                  }
                }
            }
        }
    
    
    var animation = AnimationClass()
    
    let db = Firestore.firestore()
    
    static let identifier = "TasksTableViewCell"
    
    
    func configure(_ task: TaskModel)  {
        TaskImage.image = UIImage(named: task.image)
        TaskText.text = task.name
        
        if task.complete == nil || task.complete == false {
            self.TaskStatus.text = "еще не пройдено"
            self.TaskStatus.textColor = UIColor.systemRed
        }
        
        switch task.id {
            
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
        
//        let db = Firestore.firestore()
//
//        if task.id == 1 {
//            backgroundColor = UIColor(patternImage: UIImage(named: "earth.background.jpeg")!)
//            let docRef = db.collection("users").document((Auth.auth().currentUser?.email)!)
//
//            docRef.getDocument { document, error in
//                if let error = error as NSError? {
//                    print("Error getting document: \(error.localizedDescription)")
//                }
//                else {
//                    if let document = document {
//                        if let category = document["quizplanets"] as? [String: Any] {
//                            let complete = category["complete"] as? Bool ?? false
//                            let counter = category["bestscore"] as? Int
//                            let category = category["category"] as? String ?? "lol"
//                            if  category == "planets" {
//                                self.TaskStatus.text = "\(complete)"
//                            }
//
//                            if complete == nil {
//                                self.TaskStatus.text = "еще не пройдено"
//                                self.TaskStatus.textColor = UIColor.systemRed
//                            } else if complete == true {
//                                self.TaskStatus.text = "пройдено"
//                                self.TaskStatus.textColor = UIColor.systemGreen
//                            }
//
//                        }
//                    }
//                }
//            }
//        }
//
//
//        if task.id == 2 {
//            backgroundColor = UIColor(patternImage: UIImage(named: "history.background.jpeg")!)
//            let docRef = db.collection("users").document((Auth.auth().currentUser?.email)!)
//
//            docRef.getDocument { document, error in
//                if let error = error as NSError? {
//                    print("Error getting document: \(error.localizedDescription)")
//                }
//                else {
//                    if let document = document {
//                        if let category = document["quizhistory"] as? [String: Any] {
//                            let complete = category["complete"] as? Bool ?? false
//                            let counter = category["bestscore"] as? Int
//                            let category = category["category"] as? String ?? "lol"
//                            if  category == "history" {
//                                self.TaskStatus.text = "\(complete)"
//                            }
//
//                            if complete == nil {
//                                self.TaskStatus.text = "еще не пройдено"
//                                self.TaskStatus.textColor = UIColor.systemRed
//                            } else if complete == true {
//                                self.TaskStatus.text = "пройдено"
//                                self.TaskStatus.textColor = UIColor.systemGreen
//                            }
//
//                        }
//                    }
//                }
//            }
//        }
//
//        if task.id == 3 {
//            backgroundColor = UIColor(patternImage: UIImage(named: "anatomy.background.jpeg")!)
//            let docRef = db.collection("users").document((Auth.auth().currentUser?.email)!)
//
//            docRef.getDocument { document, error in
//                if let error = error as NSError? {
//                    print("Error getting document: \(error.localizedDescription)")
//                }
//                else {
//                    if let document = document {
//                        if let category = document["quizanatomy"] as? [String: Any] {
//                            let complete = category["complete"] as? Bool ?? false
//                            let counter = category["bestscore"] as? Int
//                            let category = category["category"] as? String ?? "lol"
//                            if  category == "anatomy" {
//                                self.TaskStatus.text = "\(complete)"
//                            }
//
//                            if complete == nil {
//                                self.TaskStatus.text = "еще не пройдено"
//                                self.TaskStatus.textColor = UIColor.systemRed
//                            } else if complete == true {
//                                self.TaskStatus.text = "пройдено"
//                                self.TaskStatus.textColor = UIColor.systemGreen
//                            }
//
//                        }
//                    }
//                }
//            }
//        }
//
//        if task.id == 4 {
//            backgroundColor = UIColor(patternImage: UIImage(named: "sport.background.jpeg")!)
//            let docRef = db.collection("users").document((Auth.auth().currentUser?.email)!)
//
//            docRef.getDocument { document, error in
//                if let error = error as NSError? {
//                    print("Error getting document: \(error.localizedDescription)")
//                }
//                else {
//                    if let document = document {
//                        if let category = document["quizsport"] as? [String: Any] {
//                            let complete = category["complete"] as? Bool ?? false
//                            let counter = category["bestscore"] as? Int
//                            let category = category["category"] as? String ?? "lol"
//                            if  category == "sport" {
//                                self.TaskStatus.text = "\(complete)"
//                            }
//
//                            if complete == nil {
//                                self.TaskStatus.text = "еще не пройдено"
//                                self.TaskStatus.textColor = UIColor.systemRed
//                            } else if complete == true {
//                                self.TaskStatus.text = "пройдено"
//                                self.TaskStatus.textColor = UIColor.systemGreen
//                            }
//
//                        }
//                    }
//                }
//            }
//        }
//
//        if task.id == 5 {
//            backgroundColor = UIColor(patternImage: UIImage(named: "games.background.jpeg")!)
//            let docRef = db.collection("users").document((Auth.auth().currentUser?.email)!)
//
//            docRef.getDocument { document, error in
//                if let error = error as NSError? {
//                    print("Error getting document: \(error.localizedDescription)")
//                }
//                else {
//                    if let document = document {
//                        if let category = document["quizgames"] as? [String: Any] {
//                            let complete = category["complete"] as? Bool ?? false
//                            let counter = category["bestscore"] as? Int
//                            let category = category["category"] as? String ?? "lol"
//                            if  category == "games" {
//                                self.TaskStatus.text = "\(complete)"
//                            }
//
//                            if complete == nil {
//                                self.TaskStatus.text = "еще не пройдено"
//                                self.TaskStatus.textColor = UIColor.systemRed
//                            } else if complete == true {
//                                self.TaskStatus.text = "пройдено"
//                                self.TaskStatus.textColor = UIColor.systemGreen
//                            }
//
//                        }
//                    }
//                }
//            }
//        }
//
//        if task.id == 6 {
//            backgroundColor = UIColor(patternImage: UIImage(named: "IQ.background.jpeg")!)
//            let docRef = db.collection("users").document((Auth.auth().currentUser?.email)!)
//
//            docRef.getDocument { document, error in
//                if let error = error as NSError? {
//                    print("Error getting document: \(error.localizedDescription)")
//                }
//                else {
//                    if let document = document {
//                        if let category = document["quiziq"] as? [String: Any] {
//                            let complete = category["complete"] as? Bool ?? false
//                            let counter = category["bestscore"] as? Int
//                            let category = category["category"] as? String ?? "lol"
//                            if  category == "IQ" {
//                                self.TaskStatus.text = "\(complete)"
//                            }
//
//                            if complete == nil {
//                                self.TaskStatus.text = "еще не пройдено"
//                                self.TaskStatus.textColor = UIColor.systemRed
//                            } else if complete == true {
//                                self.TaskStatus.text = "пройдено"
//                                self.TaskStatus.textColor = UIColor.systemGreen
//                            }
//
//                        }
//                    }
//                }
//            }
//        }
//
//        if task.id == 7 {
//            backgroundColor = UIColor(patternImage: UIImage(named: "economy.background.jpeg")!)
//            let docRef = db.collection("users").document((Auth.auth().currentUser?.email)!)
//
//            docRef.getDocument { document, error in
//                if let error = error as NSError? {
//                    print("Error getting document: \(error.localizedDescription)")
//                }
//                else {
//                    if let document = document {
//                        if let category = document["quizeconomy"] as? [String: Any] {
//                            let complete = category["complete"] as? Bool ?? false
//                            let counter = category["bestscore"] as? Int
//                            let category = category["category"] as? String ?? "lol"
//                            if  category == "economy" {
//                                self.TaskStatus.text = "\(complete)"
//                            }
//
//                            if complete == nil {
//                                self.TaskStatus.text = "еще не пройдено"
//                                self.TaskStatus.textColor = UIColor.systemRed
//                            } else if complete == true {
//                                self.TaskStatus.text = "пройдено"
//                                self.TaskStatus.textColor = UIColor.systemGreen
//                            }
//
//                        }
//                    }
//                }
//            }
//        }
//
//        if task.id == 8 {
//            backgroundColor = UIColor(patternImage: UIImage(named: "geography.background.jpeg")!)
//            let docRef = db.collection("users").document((Auth.auth().currentUser?.email)!)
//
//            docRef.getDocument { document, error in
//                if let error = error as NSError? {
//                    print("Error getting document: \(error.localizedDescription)")
//                }
//                else {
//                    if let document = document {
//                        if let category = document["quizgeography"] as? [String: Any] {
//                            let complete = category["complete"] as? Bool ?? false
//                            let counter = category["bestscore"] as? Int
//                            let category = category["category"] as? String ?? "lol"
//                            if  category == "geography" {
//                                self.TaskStatus.text = "\(complete)"
//                            }
//
//                            if complete == nil {
//                                self.TaskStatus.text = "еще не пройдено"
//                                self.TaskStatus.textColor = UIColor.systemRed
//                            } else if complete == true {
//                                self.TaskStatus.text = "пройдено"
//                                self.TaskStatus.textColor = UIColor.systemGreen
//                            }
//
//                        }
//                    }
//                }
//            }
//        }
//
//        if task.id == 9 {
//            backgroundColor = UIColor(patternImage: UIImage(named: "ecology.background.jpeg")!)
//            let docRef = db.collection("users").document((Auth.auth().currentUser?.email)!)
//
//            docRef.getDocument { document, error in
//                if let error = error as NSError? {
//                    print("Error getting document: \(error.localizedDescription)")
//                }
//                else {
//                    if let document = document {
//                        if let category = document["quizecology"] as? [String: Any] {
//                            let complete = category["complete"] as? Bool ?? false
//                            let counter = category["bestscore"] as? Int
//                            let category = category["category"] as? String ?? "lol"
//                            if  category == "ecology" {
//                                self.TaskStatus.text = "\(complete)"
//                            }
//
//                            if complete == nil {
//                                self.TaskStatus.text = "еще не пройдено"
//                                self.TaskStatus.textColor = UIColor.systemRed
//                            } else if complete == true {
//                                self.TaskStatus.text = "пройдено"
//                                self.TaskStatus.textColor = UIColor.systemGreen
//                            }
//
//                        }
//                    }
//                }
//            }
//        }
//
//        if task.id == 10 {
//            backgroundColor = UIColor(patternImage: UIImage(named: "physics.background.jpeg")!)
//            let docRef = db.collection("users").document((Auth.auth().currentUser?.email)!)
//
//            docRef.getDocument { document, error in
//                if let error = error as NSError? {
//                    print("Error getting document: \(error.localizedDescription)")
//                }
//                else {
//                    if let document = document {
//                        if let category = document["quizphysics"] as? [String: Any] {
//                            let complete = category["complete"] as? Bool ?? false
//                            let counter = category["bestscore"] as? Int
//                            let category = category["category"] as? String ?? "lol"
//                            if  category == "physics" {
//                                self.TaskStatus.text = "\(complete)"
//                            }
//
//                            if complete == nil {
//                                self.TaskStatus.text = "еще не пройдено"
//                                self.TaskStatus.textColor = UIColor.systemRed
//                            } else if complete == true {
//                                self.TaskStatus.text = "пройдено"
//                                self.TaskStatus.textColor = UIColor.systemGreen
//                            }
//
//                        }
//                    }
//                }
//            }
//        }
//
//        if task.id == 11 {
//            backgroundColor = UIColor(patternImage: UIImage(named: "chemistry.background.jpeg")!)
//            let docRef = db.collection("users").document((Auth.auth().currentUser?.email)!)
//
//            docRef.getDocument { document, error in
//                if let error = error as NSError? {
//                    print("Error getting document: \(error.localizedDescription)")
//                }
//                else {
//                    if let document = document {
//                        if let category = document["quizchemistry"] as? [String: Any] {
//                            let complete = category["complete"] as? Bool ?? false
//                            let counter = category["bestscore"] as? Int
//                            let category = category["category"] as? String ?? "lol"
//                            if  category == "chemistry" {
//                                self.TaskStatus.text = "\(complete)"
//                            }
//
//                            if complete == nil {
//                                self.TaskStatus.text = "еще не пройдено"
//                                self.TaskStatus.textColor = UIColor.systemRed
//                            } else if complete == true {
//                                self.TaskStatus.text = "пройдено"
//                                self.TaskStatus.textColor = UIColor.systemGreen
//                            }
//
//                        }
//                    }
//                }
//            }
//        }
//
//        if task.id == 12 {
//            backgroundColor = UIColor(patternImage: UIImage(named: "informatics.background.jpeg")!)
//            let docRef = db.collection("users").document((Auth.auth().currentUser?.email)!)
//
//            docRef.getDocument { document, error in
//                if let error = error as NSError? {
//                    print("Error getting document: \(error.localizedDescription)")
//                }
//                else {
//                    if let document = document {
//                        if let category = document["quizinformatics"] as? [String: Any] {
//                            let complete = category["complete"] as? Bool ?? false
//                            let counter = category["bestscore"] as? Int
//                            let category = category["category"] as? String ?? "lol"
//                            if  category == "informatics" {
//                                self.TaskStatus.text = "\(complete)"
//                            }
//
//                            if complete == nil {
//                                self.TaskStatus.text = "еще не пройдено"
//                                self.TaskStatus.textColor = UIColor.systemRed
//                            } else if complete == true {
//                                self.TaskStatus.text = "пройдено"
//                                self.TaskStatus.textColor = UIColor.systemGreen
//                            }
//
//                        }
//                    }
//                }
//            }
//        }

        
        
        
    }
}
