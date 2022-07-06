//
//  PlayerTableViewCellModel.swift
//  QUIZ
//
//  Created by Марк Киричко on 02.07.2022.
//

import Foundation
import Firebase
import SDWebImage
import UIKit

class PlayerTableViewCellModel {
    
    var db = Firestore.firestore()
    
    var playersArray = [Player]()
    
    func loadData(player: Player, PlayerImage: UIImageView, UserName: UILabel, UserEmail:UILabel, PlayerBestScore: UILabel, view: UIView) {
        
        print(player.category)
        
        db.collection("users").getDocuments() { (QuerySnapshot, err) in
            if let err = err {
                print("Error getting documents : \(err)")
            } else {
                for document in QuerySnapshot!.documents {
                    let name = document.get("name") as? String
                    let email = document.get("email") as? String
                    let quizname = document.get("quizname") as? String
                    
                    UserName.text = ("\(player.name)")
                    UserEmail.text = player.email
            
                    
                    if player.name == player.name {
                        print(player.name)
                    }
                    
                    if let category = document["lastquiz"] as? [String: Any] {
                        
                        let image = category["image"] as? String
                        
                        if player.image == "" {
                            PlayerImage.image = UIImage(named: image ?? "IQ.jpeg")
                        }
                        
                    }
                    
                    DispatchQueue.main.async {
                        let imageURL = URL(string: player.image)
                        PlayerImage.sd_setImage(with: imageURL)
                        print("Фотка \(player.image)")
                        
                        view.backgroundColor = UIColor(patternImage: UIImage(named: player.background)!)
                        UserName.textColor = UIColor.white
                        UserEmail.textColor = UIColor.white
                        PlayerBestScore.textColor = UIColor.white
                        
                        if  UserEmail.text == Auth.auth().currentUser?.email {
                            UserName.text = ("Вы (\(player.name))")
                            UserName.textColor = UIColor.systemGreen
                            //self.UserName.font = UIFont.boldSystemFont(ofSize: 17)
                        }else {
                            //self.UserName.textColor = UIColor.darkText
                        }
                        
                    }
                    
                    if player.counter == 100 && player.CorrectAnswersCounter == 20  {
                        //self.PlayerBestScore.font = UIFont.boldSystemFont(ofSize: 17)
                        //self.UserName.font = UIFont.boldSystemFont(ofSize: 17)
                        UserName.text = ("\(player.name) 🏆")
                        //self.UserEmail.font = UIFont.boldSystemFont(ofSize: 17)
                        PlayerBestScore.text = "\(player.category) \(player.counter) баллов (\(player.CorrectAnswersCounter)/20)"
                        //self.PlayerImage.flash()
                    }
                    
                    PlayerImage.image = UIImage(named: player.image)
                    PlayerBestScore.text = "\(player.category) \(player.counter) баллов (\(player.CorrectAnswersCounter)/20)"
                            print(player.category)
                }
            }
        }
    }

    
}
