//
//  PlayerViewModel.swift
//  QUIZ
//
//  Created by Марк Киричко on 02.07.2022.
//

import Foundation
import FirebaseFirestore

class PlayerViewModel {
    
    var playersArray: [Player] = []
    var documents: [DocumentSnapshot] = []
    
    var db = Firestore.firestore()
    var sorted = false
    var player = SoundClass()
    
    
    func SortedScore(this:Player, that:Player) -> Bool {
        return this.CorrectAnswersCounter > that.CorrectAnswersCounter
    }
    
    func SortedScore2(this:Player, that:Player) -> Bool {
        return this.CorrectAnswersCounter < that.CorrectAnswersCounter
    }
    
    
    func SortTable(tableView: UITableView) {
        player.Sound(resource: "future click sound.wav")
        if sorted == true {
            self.playersArray.sort(by: self.SortedScore)
            sorted = false
            //SortButton.image = UIImage(systemName: "arrow.down")
            tableView.reloadData()
            print(sorted)
        } else if sorted == false {
            self.playersArray.sort(by: self.SortedScore2)
            sorted = true
            //SortButton.image = UIImage(systemName: "arrow.up")
            tableView.reloadData()
            print(sorted)
        }
    }
    
    
    func loadData(tableView: UITableView) {
        db.collection("users").getDocuments() { (QuerySnapshot, err) in
            if let err = err {
                print("Error getting documents : \(err)")
            } else {
                for document in QuerySnapshot!.documents {
                    let name = document.get("name") as? String
                    let email = document.get("email") as? String
                    let counter = document.get("counter") as? Int
                    let quizname = document.get("quizname") as? String
                    let photo = document.get("image") as? String
                    
                    if let category = document["lastquiz"] as? [String: Any] {
                        let CorrectAnswersCounter = category["CorrectAnswersCounter"] as? Int
                        let image = category["image"] as? String ?? "planets.jpeg"
                        let background = category["background"] as? String
                        let bestscore = category["bestscore"] as? Int ?? 228
                        let category = category["category"] as? String ?? "lol"
                        self.playersArray.append(Player(name: name ?? "", counter: bestscore , email: email ?? "", quizname: quizname ?? "", CorrectAnswersCounter: CorrectAnswersCounter ?? 0, category: category, image: photo ?? image, background: background ?? ""))
                        print(self.playersArray)
                    }
                    self.playersArray.sort(by: self.SortedScore)
                    
                }
                tableView.reloadData()
            }
        }
    }
}
