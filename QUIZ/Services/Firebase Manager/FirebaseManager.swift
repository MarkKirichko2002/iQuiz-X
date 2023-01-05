//
//  FirebaseManager.swift
//  QUIZ
//
//  Created by Марк Киричко on 03.04.2022.
//

import Foundation
import UIKit
import Firebase
import SDWebImage
import SCLAlertView

class FirebaseManager {
    
    private let defaults = UserDefaults.standard
    private let db = Firestore.firestore()
    private var view = UIView()
    private let storage = Storage.storage().reference()
    private var player = SoundClass()
    private var image = ""
    private var quizCategoryViewModel: QuizCategoryViewModel?
    private var quizTaskViewModel: QuizTaskViewModel?
    private var players = [Player]()
    let voicepassword = UserDefaults.standard.object(forKey: "voicepassword") as? String
    var email = Auth.auth().currentUser?.email ?? ""
    
    // загрузить данные о категориях викторины
    func LoadQuizCategoriesData(quizpath: String, completion: @escaping(QuizCategoryViewModel)->()) {
        let docRef = db.collection("users").document(email)
        
        docRef.getDocument { document, error in
            if let error = error as NSError? {
                print("Error getting document: \(error.localizedDescription)")
            } else {
                if let document = document {
                    if let category = document[quizpath] as? [String: Any] {
                        let complete = category["complete"] as? Bool ?? false
                        let bestscore = category["bestscore"] as? Int ?? 0
                        let CorrectAnswersCounter = category["CorrectAnswersCounter"] as? Int ?? 0
                        
                        self.quizCategoryViewModel = QuizCategoryViewModel(score: bestscore, CorrectAnswersCounter: CorrectAnswersCounter, complete: complete)
                        guard let model = self.quizCategoryViewModel else {return}
                        completion(model)
                    }
                }
            }
        }
    }
    
    // загрузить данные о заданиях викторины
    func LoadQuizTasksData(quizpath: String, completion: @escaping(QuizTaskViewModel)->()) {
        let docRef = db.collection("users").document((Auth.auth().currentUser?.email)!)
        
        docRef.getDocument { document, error in
            if let error = error as NSError? {
                print("Error getting document: \(error.localizedDescription)")
            } else {
                if let document = document {
                    
                    if let category = document[quizpath] as? [String: Any] {
                        let complete = category["complete"] as? Bool ?? false
                        
                        self.quizTaskViewModel = QuizTaskViewModel(complete: complete)
                        guard let model = self.quizTaskViewModel else {return}
                        completion(model)
                    }
                }
            }
        }
    }
    
    // загрузить данные о последней категории
    func LoadLastQuizCategoryData(completion: @escaping(QuizResult)->()) {
        let docRef = db.collection("users").document((Auth.auth().currentUser?.email)!)
        
        docRef.getDocument { document, error in
            if let error = error as NSError? {
                print("Error getting document: \(error.localizedDescription)")
            } else {
                if let document = document {
                    if let category = document["lastquiz"] as? [String: Any] {
                        let CorrectAnswersCounter = category["CorrectAnswersCounter"] as? Int
                        let icon = category["icon"] as? String
                        let sound = category["sound"] as? String
                        let background = category["background"] as? String
                        let bestscore = category["bestscore"] as? Int ?? 0
                        let category = category["category"] as? String ?? ""
                        
                        let result = QuizResult(categoryName: category, icon: icon ?? "", bestscore: bestscore, CorrectAnswersCounter: CorrectAnswersCounter ?? 0, background: background ?? "", sound: sound ?? "")
                        completion(result)
                    }
                }
            }
        }
    }
    
    // загрузить список игроков
    func LoadPlayers(completion: @escaping([Player])->()) {
        db.collection("users").getDocuments() { (QuerySnapshot, err) in
            if let err = err {
                print("Error getting documents : \(err)")
            } else {
                for document in QuerySnapshot!.documents {
                    let name = document.get("name") as? String
                    let email = document.get("email") as? String
                    let photo = document.get("image") as? String
                    
                    if let category = document["lastquiz"] as? [String: Any] {
                        let sound = category["sound"] as? String ?? ""
                        let music = category["music"] as? String ?? ""
                        let CorrectAnswersCounter = category["CorrectAnswersCounter"] as? Int
                        let background = category["background"] as? String
                        let bestscore = category["bestscore"] as? Int ?? 0
                        let category = category["category"] as? String ?? ""
                        
                        self.players.append(Player(name: name ?? "", counter: bestscore , email: email ?? "", CorrectAnswersCounter: CorrectAnswersCounter ?? 0, category: category, categoryMusic: music , image: photo ?? "", background: background ?? "", sound: sound))
                    }
                    self.players.sort(by: { $0.counter > $1.counter })
                    completion(self.players)
                }
            }
        }
    }
    
    // загрузить информацию о профиле
    func LoadProfileInfo(completion: @escaping(Profile)->()) {
        let docRef = db.collection("users").document((Auth.auth().currentUser?.email) ?? "")
        docRef.getDocument { document, error in
            if let error = error as NSError? {
                print("Error getting document: \(error.localizedDescription)")
            } else {
                if let document = document {
                    let data = document.data()
                    let name = data?["name"] as? String ?? ""
                    let email = data?["email"] as? String
                    let image = data?["image"] as? String ?? "https://cdn-icons-png.flaticon.com/512/3637/3637624.png"
                    let password = data?["password"] as? String
                    
                    if let category = document["lastquiz"] as? [String: Any] {
                        let CorrectAnswersCounter = category["CorrectAnswersCounter"] as? Int ?? 0
                        let icon = category["icon"] as? String ?? ""
                        let date = category["date"] as? String ?? ""
                        let sound = category["sound"] as? String ?? ""
                        let background = category["background"] as? String
                        let bestscore = category["bestscore"] as? Int ?? 0
                        let category = category["category"] as? String ?? ""
                        
                        let user = Profile(name: name, email: email ?? "", score: bestscore, correctAnswers: CorrectAnswersCounter, category: category, image: image, icon: icon, background: background ?? "", password: password ?? "", voicepassword: self.voicepassword ?? "", categorysound: sound, categoryDate: date)
                        completion(user)
                    }
                }
            }
        }
    }
    
    // сохранить свою голосовую команду
    func SaveCustomVoiceCommand(id: Int, voicecommand: VoiceCommandModel, text: String) {
        let db = Firestore.firestore()
        
        if voicecommand.id == id {
            let ref = db.collection("users").document((Auth.auth().currentUser?.email)!)
            ref.updateData([
                voicecommand.name: [
                    "voicecommand": text,
                ]
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("success")
                    print(ref)
                }
            }
        }
    }
    
    // загрузить голосовые команды
    func LoadVoiceCommands(command: String, completion: @escaping(String)->()) {
        let docRef = db.collection("users").document(Auth.auth().currentUser?.email ?? "")
        
        docRef.getDocument { document, error in
            if let error = error as NSError? {
                print("Error getting document: \(error.localizedDescription)")
            } else {
                if let document = document {
                    if let category = document[command] as? [String: Any] {
                        let voicecommand = category["voicecommand"] as? String ?? ""
                        completion(voicecommand)
                    }
                }
            }
        }
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
                        self.player.PlaySound(resource: sound)
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
        
        if Auth.auth().currentUser?.email != nil {
           
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
    }
    
    func loadVoiceInfo(passwordLabel: UILabel) {
        var voicepassword = defaults.object(forKey: "voicepassword") as? String
        passwordLabel.text = voicepassword
    }
    
    func loadSecretInfo(namelabel: UILabel, emailLabel: UILabel, passwordLabel: UILabel) {
        
        let name = defaults.object(forKey:"name") as? String
        let email = defaults.object(forKey:"email") as? String
        let password = defaults.object(forKey:"password") as? String
        
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

