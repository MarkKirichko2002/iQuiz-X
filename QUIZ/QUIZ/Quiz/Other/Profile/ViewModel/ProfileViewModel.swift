//
//  ProfileViewModel.swift
//  QUIZ
//
//  Created by Марк Киричко on 09.10.2022.
//

import Foundation
import RxSwift
import RxCocoa
import Firebase

class ProfileViewModel {
    
    let db = Firestore.firestore()
    var user = PublishSubject<Profile>()
    let voicepassword = UserDefaults.standard.object(forKey: "voicepassword") as? String
    
    func LoadUserInfo() {
        let docRef = db.collection("users").document((Auth.auth().currentUser?.email) ?? "")
        docRef.getDocument { document, error in
            if let error = error as NSError? {
                print("Error getting document: \(error.localizedDescription)")
            } else {
                if let document = document {
                    let data = document.data()
                    let name = data?["name"] as? String ?? ""
                    let email = data?["email"] as? String
                    let image = data?["image"] as? String
                    let password = data?["password"] as? String
                    
                    if let category = document["lastquiz"] as? [String: Any] {
                        let background = category["background"] as? String
                        let bestscore = category["bestscore"] as? Int ?? 0
                        let category = category["category"] as? String ?? ""
                        
                        let user = Profile(name: name, email: email ?? "", score: bestscore, category: category, image: image ?? "", background: background ?? "", password: password ?? "", voicepassword: self.voicepassword ?? "")
                        self.user.onNext(user)
                    }
                }
            }
        }
    }
}
