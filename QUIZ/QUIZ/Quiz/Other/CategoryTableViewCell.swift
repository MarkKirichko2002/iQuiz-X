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
                          
//                          if complete == nil {
//                              self.isComplete.text = "еще не пройдено"
//                              self.isComplete.textColor = UIColor.systemRed
//                          } else if complete == true {
//                              self.isComplete.text = "пройдено"
//                              self.isComplete.textColor = UIColor.systemGreen
//                          }
                      }
                  }
                }
            }
        }
    
    var animation = AnimationClass()
    
    let db = Firestore.firestore()
    
    static let identifier = "CategoryTableViewCell"
    
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
            LoadData(quizpath: "lastquiz", background: "random.background.jpeg")
    
            
        default:
           //LoadData(quizpath: "quizplanets", background: "earth.background.jpeg")
            break
        }
        
//        if category.id == 1 {
//            backgroundColor = UIColor(patternImage: UIImage(named: "earth.background.jpeg")!)
//            let docRef = db.collection("users").document((Auth.auth().currentUser?.email)!)
//
//              docRef.getDocument { document, error in
//                if let error = error as NSError? {
//                print("Error getting document: \(error.localizedDescription)")
//                }
//                else {
//                  if let document = document {
//
//
//                      if let category = document["quizplanets"] as? [String: Any] {
//                          let complete = category["complete"] as? Bool ?? false
//                          let counter = category["bestscore"] as? Int
//                          let bestscore = category["bestscore"] as? Int ?? 228
//                          let category = category["category"] as? String ?? "lol"
//                          if  category == "planets" {
//                              self.CategoryScore.text = "\(counter ?? 0)/100 баллов"
//                              self.isComplete.text = "\(complete)"
//                          }
//
//
//                          if complete == nil {
//                              self.isComplete.text = "еще не пройдено"
//                              self.isComplete.textColor = UIColor.systemRed
//                          } else if complete == true {
//                              self.isComplete.text = "пройдено"
//                              self.isComplete.textColor = UIColor.systemGreen
//                          }
//
//                      }
//
//                  }
//                }
//            }
//        }
//
//        if category.id == 2 {
//            backgroundColor = UIColor(patternImage: UIImage(named: "history.background.jpeg")!)
//            let docRef = db.collection("users").document((Auth.auth().currentUser?.email)!)
//
//              docRef.getDocument { document, error in
//                if let error = error as NSError? {
//                print("Error getting document: \(error.localizedDescription)")
//                }
//                else {
//                  if let document = document {
//
//
//                      if let category = document["quizhistory"] as? [String: Any] {
//                          let complete = category["complete"] as? Bool ?? false
//                          let counter = category["bestscore"] as? Int
//                          let bestscore = category["bestscore"] as? Int ?? 228
//                          let category = category["category"] as? String ?? "lol"
//                          if  category == "history" {
//                              self.CategoryScore.text = "\(counter ?? 0)/100 баллов"
//                              self.isComplete.text = "\(complete)"
//                          }
//
//
//                          if complete == nil {
//                              self.isComplete.text = "еще не пройдено"
//                              self.isComplete.textColor = UIColor.systemRed
//                          } else if complete == true {
//                              self.isComplete.text = "пройдено"
//                              self.isComplete.textColor = UIColor.systemGreen
//                          }
//
//                      }
//
//                  }
//                }
//            }
//        }
//
//        if category.id == 3 {
//            backgroundColor = UIColor(patternImage: UIImage(named: "anatomy.background.jpeg")!)
//            let docRef = db.collection("users").document((Auth.auth().currentUser?.email)!)
//
//              docRef.getDocument { document, error in
//                if let error = error as NSError? {
//                print("Error getting document: \(error.localizedDescription)")
//                }
//                else {
//                  if let document = document {
//
//
//                      if let category = document["quizanatomy"] as? [String: Any] {
//                          let complete = category["complete"] as? Bool ?? false
//                          let counter = category["bestscore"] as? Int
//                          let bestscore = category["bestscore"] as? Int ?? 228
//                          let category = category["category"] as? String ?? "lol"
//                          if  category == "anatomy" {
//                              self.CategoryScore.text = "\(counter ?? 0)/100 баллов"
//                              self.isComplete.text = "\(complete)"
//                          }
//
//
//                          if complete == nil {
//                              self.isComplete.text = "еще не пройдено"
//                              self.isComplete.textColor = UIColor.systemRed
//                          } else if complete == true {
//                              self.isComplete.text = "пройдено"
//                              self.isComplete.textColor = UIColor.systemGreen
//                          }
//
//                      }
//
//                  }
//                }
//            }
//        }
//
//
//
//        if category.id == 4 {
//            backgroundColor = UIColor(patternImage: UIImage(named: "sport.background.jpeg")!)
//            let docRef = db.collection("users").document((Auth.auth().currentUser?.email)!)
//
//              docRef.getDocument { document, error in
//                if let error = error as NSError? {
//                print("Error getting document: \(error.localizedDescription)")
//                }
//                else {
//                  if let document = document {
//
//
//                      if let category = document["quizsport"] as? [String: Any] {
//                          let complete = category["complete"] as? Bool ?? false
//                          let counter = category["bestscore"] as? Int
//                          let bestscore = category["bestscore"] as? Int ?? 228
//                          let category = category["category"] as? String ?? "lol"
//                          if  category == "sport" {
//                              self.CategoryScore.text = "\(counter ?? 0)/100 баллов"
//                              self.isComplete.text = "\(complete)"
//                          }
//
//
//                          if complete == nil {
//                              self.isComplete.text = "еще не пройдено"
//                              self.isComplete.textColor = UIColor.systemRed
//                          } else if complete == true {
//                              self.isComplete.text = "пройдено"
//                              self.isComplete.textColor = UIColor.systemGreen
//                          }
//
//                      }
//
//                  }
//                }
//            }
//        }
//
//        if category.id == 5 {
//            backgroundColor = UIColor(patternImage: UIImage(named: "games.background.jpeg")!)
//            let docRef = db.collection("users").document((Auth.auth().currentUser?.email)!)
//
//              docRef.getDocument { document, error in
//                if let error = error as NSError? {
//                print("Error getting document: \(error.localizedDescription)")
//                }
//                else {
//                  if let document = document {
//
//
//                      if let category = document["quizgames"] as? [String: Any] {
//                          let complete = category["complete"] as? Bool ?? false
//                          let counter = category["bestscore"] as? Int
//                          let bestscore = category["bestscore"] as? Int ?? 228
//                          let category = category["category"] as? String ?? "lol"
//                          if  category == "games" {
//                              self.CategoryScore.text = "\(counter ?? 0)/100 баллов"
//                              self.isComplete.text = "\(complete)"
//                          }
//
//
//                          if complete == nil {
//                              self.isComplete.text = "еще не пройдено"
//                              self.isComplete.textColor = UIColor.systemRed
//                          } else if complete == true {
//                              self.isComplete.text = "пройдено"
//                              self.isComplete.textColor = UIColor.systemGreen
//                          }
//
//                      }
//
//                  }
//                }
//            }
//        }
//
//        if category.id == 6 {
//            backgroundColor = UIColor(patternImage: UIImage(named: "IQ.background.jpeg")!)
//            let docRef = db.collection("users").document((Auth.auth().currentUser?.email)!)
//
//              docRef.getDocument { document, error in
//                if let error = error as NSError? {
//                print("Error getting document: \(error.localizedDescription)")
//                }
//                else {
//                  if let document = document {
//
//
//                      if let category = document["quiziq"] as? [String: Any] {
//                          let complete = category["complete"] as? Bool ?? false
//                          let counter = category["bestscore"] as? Int
//                          let bestscore = category["bestscore"] as? Int ?? 228
//                          let category = category["category"] as? String ?? "lol"
//                          if  category == "IQ" {
//                              self.CategoryScore.text = "\(counter ?? 0)/100 баллов"
//                              self.isComplete.text = "\(complete)"
//                          }
//
//
//                          if complete == nil {
//                              self.isComplete.text = "еще не пройдено"
//                              self.isComplete.textColor = UIColor.systemRed
//                          } else if complete == true {
//                              self.isComplete.text = "пройдено"
//                              self.isComplete.textColor = UIColor.systemGreen
//                          }
//
//                      }
//
//                  }
//                }
//            }
//        }
//
//        if category.id == 7 {
//            backgroundColor = UIColor(patternImage: UIImage(named: "economy.background.jpeg")!)
//            let docRef = db.collection("users").document((Auth.auth().currentUser?.email)!)
//
//              docRef.getDocument { document, error in
//                if let error = error as NSError? {
//                print("Error getting document: \(error.localizedDescription)")
//                }
//                else {
//                  if let document = document {
//
//
//                      if let category = document["quizeconomy"] as? [String: Any] {
//                          let complete = category["complete"] as? Bool ?? false
//                          let counter = category["bestscore"] as? Int
//                          let bestscore = category["bestscore"] as? Int ?? 228
//                          let category = category["category"] as? String ?? "lol"
//                          if  category == "economy" {
//                              self.CategoryScore.text = "\(counter ?? 0)/100 баллов"
//                              self.isComplete.text = "\(complete)"
//                          }
//
//
//                          if complete == nil {
//                              self.isComplete.text = "еще не пройдено"
//                              self.isComplete.textColor = UIColor.systemRed
//                          } else if complete == true {
//                              self.isComplete.text = "пройдено"
//                              self.isComplete.textColor = UIColor.systemGreen
//                          }
//
//                      }
//
//                  }
//                }
//            }
//        }
//
//        if category.id == 8 {
//            backgroundColor = UIColor(patternImage: UIImage(named: "geography.background.jpeg")!)
//            let docRef = db.collection("users").document((Auth.auth().currentUser?.email)!)
//
//              docRef.getDocument { document, error in
//                if let error = error as NSError? {
//                print("Error getting document: \(error.localizedDescription)")
//                }
//                else {
//                  if let document = document {
//
//
//                      if let category = document["quizgeography"] as? [String: Any] {
//                          let complete = category["complete"] as? Bool ?? false
//                          let counter = category["bestscore"] as? Int
//                          let bestscore = category["bestscore"] as? Int ?? 228
//                          let category = category["category"] as? String ?? "lol"
//                          if  category == "geography" {
//                              self.CategoryScore.text = "\(counter ?? 0)/100 баллов"
//                              self.isComplete.text = "\(complete)"
//                          }
//
//
//                          if complete == nil {
//                              self.isComplete.text = "еще не пройдено"
//                              self.isComplete.textColor = UIColor.systemRed
//                          } else if complete == true {
//                              self.isComplete.text = "пройдено"
//                              self.isComplete.textColor = UIColor.systemGreen
//                          }
//
//                      }
//
//                  }
//                }
//            }
//        }
//
//
//        if category.id == 9 {
//            backgroundColor = UIColor(patternImage: UIImage(named: "ecology.background.jpeg")!)
//            let docRef = db.collection("users").document((Auth.auth().currentUser?.email)!)
//
//              docRef.getDocument { document, error in
//                if let error = error as NSError? {
//                print("Error getting document: \(error.localizedDescription)")
//                }
//                else {
//                  if let document = document {
//
//
//                      if let category = document["quizecology"] as? [String: Any] {
//                          let complete = category["complete"] as? Bool ?? false
//                          let counter = category["bestscore"] as? Int
//                          let bestscore = category["bestscore"] as? Int ?? 228
//                          let category = category["category"] as? String ?? "lol"
//                          if  category == "ecology" {
//                              self.CategoryScore.text = "\(counter ?? 0)/100 баллов"
//                              self.isComplete.text = "\(complete)"
//                          }
//
//
//                          if complete == nil {
//                              self.isComplete.text = "еще не пройдено"
//                              self.isComplete.textColor = UIColor.systemRed
//                          } else if complete == true {
//                              self.isComplete.text = "пройдено"
//                              self.isComplete.textColor = UIColor.systemGreen
//                          }
//
//                      }
//
//                  }
//                }
//            }
//        }
//
//        if category.id == 10 {
//            backgroundColor = UIColor(patternImage: UIImage(named: "physics.background.jpeg")!)
//            let docRef = db.collection("users").document((Auth.auth().currentUser?.email)!)
//
//              docRef.getDocument { document, error in
//                if let error = error as NSError? {
//                print("Error getting document: \(error.localizedDescription)")
//                }
//                else {
//                  if let document = document {
//
//
//                      if let category = document["quizphysics"] as? [String: Any] {
//                          let complete = category["complete"] as? Bool ?? false
//                          let counter = category["bestscore"] as? Int
//                          let bestscore = category["bestscore"] as? Int ?? 228
//                          let category = category["category"] as? String ?? "lol"
//                          if  category == "physics" {
//                              self.CategoryScore.text = "\(counter ?? 0)/100 баллов"
//                              self.isComplete.text = "\(complete)"
//                          }
//
//
//                          if complete == nil {
//                              self.isComplete.text = "еще не пройдено"
//                              self.isComplete.textColor = UIColor.systemRed
//                          } else if complete == true {
//                              self.isComplete.text = "пройдено"
//                              self.isComplete.textColor = UIColor.systemGreen
//                          }
//
//                      }
//
//                  }
//                }
//            }
//        }
//
//
//        if category.id == 11 {
//            backgroundColor = UIColor(patternImage: UIImage(named: "chemistry.background.jpeg")!)
//            let docRef = db.collection("users").document((Auth.auth().currentUser?.email)!)
//
//              docRef.getDocument { document, error in
//                if let error = error as NSError? {
//                print("Error getting document: \(error.localizedDescription)")
//                }
//                else {
//                  if let document = document {
//
//
//                      if let category = document["quizchemistry"] as? [String: Any] {
//                          let complete = category["complete"] as? Bool ?? false
//                          let counter = category["bestscore"] as? Int
//                          let bestscore = category["bestscore"] as? Int ?? 228
//                          let category = category["category"] as? String ?? "lol"
//                          if  category == "chemistry" {
//                              self.CategoryScore.text = "\(counter ?? 0)/100 баллов"
//                              self.isComplete.text = "\(complete)"
//                          }
//
//
//                          if complete == nil {
//                              self.isComplete.text = "еще не пройдено"
//                              self.isComplete.textColor = UIColor.systemRed
//                          } else if complete == true {
//                              self.isComplete.text = "пройдено"
//                              self.isComplete.textColor = UIColor.systemGreen
//                          }
//
//                      }
//
//                  }
//                }
//            }
//        }
//
//        if category.id == 12 {
//            backgroundColor = UIColor(patternImage: UIImage(named: "informatics.background.jpeg")!)
//            let docRef = db.collection("users").document((Auth.auth().currentUser?.email)!)
//
//              docRef.getDocument { document, error in
//                if let error = error as NSError? {
//                print("Error getting document: \(error.localizedDescription)")
//                }
//                else {
//                  if let document = document {
//
//
//                      if let category = document["quizinformatics"] as? [String: Any] {
//                          let complete = category["complete"] as? Bool ?? false
//                          let counter = category["bestscore"] as? Int
//                          let bestscore = category["bestscore"] as? Int ?? 228
//                          let category = category["category"] as? String ?? "lol"
//                          if  category == "informatics" {
//                              self.CategoryScore.text = "\(counter ?? 0)/100 баллов"
//                              self.isComplete.text = "\(complete)"
//                          }
//
//
//                          if complete == nil {
//                              self.isComplete.text = "еще не пройдено"
//                              self.isComplete.textColor = UIColor.systemRed
//                          } else if complete == true {
//                              self.isComplete.text = "пройдено"
//                              self.isComplete.textColor = UIColor.systemGreen
//                          }
//
//                      }
//
//                  }
//                }
//            }
//         }
        
        
        
        if category.id == 0 {
            backgroundColor = UIColor.black
            isComplete.text = nil
            CategoryScore.text = nil
        }
        
    }
}
