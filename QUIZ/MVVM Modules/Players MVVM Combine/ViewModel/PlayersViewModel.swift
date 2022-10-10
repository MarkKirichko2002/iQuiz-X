//
//  PlayerViewModel.swift
//  QUIZ
//
//  Created by Марк Киричко on 02.07.2022.
//

import FirebaseFirestore
import Combine

class PlayersViewModel {
    
    @Published var players = [Player]()
    
    let db = Firestore.firestore()
    
    func GetPlayers() {
        db.collection("users").getDocuments() { (QuerySnapshot, err) in
            if let err = err {
                print("Error getting documents : \(err)")
            } else {
                for document in QuerySnapshot!.documents {
                    let name = document.get("name") as? String
                    let email = document.get("email") as? String
                    let photo = document.get("image") as? String
                    
                    if let category = document["lastquiz"] as? [String: Any] {
                        let CorrectAnswersCounter = category["CorrectAnswersCounter"] as? Int
                        let background = category["background"] as? String
                        let bestscore = category["bestscore"] as? Int ?? 0
                        let category = category["category"] as? String ?? ""
                        
                        self.players.append(Player(name: name ?? "", counter: bestscore , email: email ?? "", CorrectAnswersCounter: CorrectAnswersCounter ?? 0, category: category , image: photo ?? "", background: background ?? ""))
                        print(self.players.count)
                    }
                    self.players.sort(by: { $0.counter > $1.counter })
                }
            }
        }
    }
    
}

