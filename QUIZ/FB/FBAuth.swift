//
//  FBAuth.swift
//  QUIZ
//
//  Created by Марк Киричко on 03.04.2022.
//

import Foundation
import UIKit
import Firebase
import SDWebImage
import SCLAlertView

class FBAuth {
    
    let defaults = UserDefaults.standard
    let db = Firestore.firestore()
    var view = UIView()
    let storage = Storage.storage().reference()
    var player = SoundClass()
    
    var image = ""
    
    func LoadProfileImage()-> String {
        let docRef = db.collection("users").document((Auth.auth().currentUser?.email) ?? "")
        docRef.getDocument { document, error in
            if let error = error as NSError? {
                print("Error getting document: \(error.localizedDescription)")
            } else {
                if let document = document {
                    let data = document.data()
                    let image = data?["image"] as? String
                    self.image = image ?? ""
                }
            }
        }
        return image
    }
    
    func PlayLastQuizSound() {
        let docRef = db.collection("users").document((Auth.auth().currentUser?.email) ?? "")
        docRef.getDocument { document, error in
            if let error = error as NSError? {
                print("Error getting document: \(error.localizedDescription)")
            } else {
                if let document = document {
                    
                    if let category = document["lastquiz"] as? [String: Any] {
                        let sound = category["sound"] as? String ?? ""
                        
                        self.player.Sound(resource: sound)
                    }
                }
            }
        }
    }
    
    func load(profileimage: UIImageView) {
        guard let urlString = UserDefaults.standard.value(forKey: "url") as? String,
              let url = URL(string: urlString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: {data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                profileimage.image = image
            }
        })
        
        task.resume()
    }
    
    
    func write(string: String) {
        db.collection("users").document(Auth.auth().currentUser?.email ?? "").updateData([
            "image": string
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("photo saved")
                print(string)
            }
        }
    }
    
    func delete() {
        //DispatchQueue.main.async {
        if Auth.auth().currentUser?.email != nil {
            //Auth.auth().currentUser?.delete()
            
            let user = Auth.auth().currentUser
            
            let email = defaults.object(forKey: "email") as? String
            print(email ?? "")
            
            user?.delete { error in
                if let error = error {
                    SCLAlertView().showError("Ошибка!", subTitle: "что-то пошло не так")
                } else {
                    print("удален \(user)")
                    self.db.collection("users").document(email ?? "").delete()
                    self.storage.child("images/\(email ?? "")").delete()
                    self.defaults.set("", forKey: "email")
                    self.defaults.set("", forKey: "password")
                    self.defaults.set(false, forKey: "off")
                    self.defaults.set(false, forKey: "offaudio")
                    self.defaults.set(false, forKey: "offhints")
                    self.defaults.set(false, forKey: "offspeach")
                    self.defaults.set(false, forKey: "offmusic")
                    self.defaults.set(false, forKey: "offtimer")
                    self.defaults.set(false, forKey: "offattempts")
                    
                    self.defaults.set(false, forKey: "onstatus")
                    self.defaults.set(false, forKey: "onstatusaudio")
                    self.defaults.set(false, forKey: "onstatushints")
                    self.defaults.set(false, forKey: "onstatusspeach")
                    self.defaults.set(false, forKey: "onstatusmusic")
                    
                    SCLAlertView().showSuccess("Успех!", subTitle: "пользователь успешно удален")
                }
            }
            
        } else {
            print("no user")
        }
        // }
    }
    
    func loadVoiceInfo(passwordLabel: UILabel) {
        var voicepassword = defaults.object(forKey: "voicepassword") as? String
        passwordLabel.text = voicepassword
    }
    
    func loadSecretInfo(namelabel: UILabel, emailLabel: UILabel, passwordLabel: UILabel) {
        
        var name = defaults.object(forKey:"name") as? String
        var email = defaults.object(forKey:"email") as? String
        var password = defaults.object(forKey:"password") as? String
        
        namelabel.text = name
        emailLabel.text = email
        passwordLabel.text = password
        
        if name == "" || name == nil {
            emailLabel.text = "нет имени"
        }
        
        if email == "" || email == nil {
            emailLabel.text = "нет email"
        }
        
        if password == "" || password == nil {
            passwordLabel.text = "нет пароля"
        }
    }
    
    
    func SignOutAction() {
        try? Auth.auth().signOut()
    }
    
}

