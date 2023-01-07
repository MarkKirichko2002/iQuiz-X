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

class FirebaseManager: FirebaseManagerProtocol {
    
    private let db = Firestore.firestore()
    private let storage = Storage.storage().reference()
    private let player = SoundClass()
    private var quizCategoryViewModel: QuizCategoryViewModel?
    private var quizTaskViewModel: QuizTaskViewModel?
    private var players = [Player]()
    private let settingsManager = SettingsManager()
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
                        let date = category["date"] as? String ?? "дата отсутствует"
                        
                        self.quizCategoryViewModel = QuizCategoryViewModel(score: bestscore, CorrectAnswersCounter: CorrectAnswersCounter, complete: complete, date: date)
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
    
    // загрузить данные о последней категории викторины
    func LoadLastQuizCategoryData(completion: @escaping(QuizResult)->()) {
        let docRef = db.collection("users").document((Auth.auth().currentUser?.email)!)
        
        docRef.getDocument { document, error in
            if let error = error as NSError? {
                print("Error getting document: \(error.localizedDescription)")
            } else {
                if let document = document {
                    if let category = document["lastquiz"] as? [String: Any] {
                        let CorrectAnswersCounter = category["CorrectAnswersCounter"] as? Int ?? 0
                        let icon = category["icon"] as? String ?? ""
                        let sound = category["sound"] as? String ?? ""
                        let background = category["background"] as? String ?? ""
                        let bestscore = category["bestscore"] as? Int ?? 0
                        let category = category["category"] as? String ?? ""
                        
                        let result = QuizResult(categoryName: category, icon: icon, bestscore: bestscore, CorrectAnswersCounter: CorrectAnswersCounter, background: background, sound: sound)
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
                    let name = document.get("name") as? String ?? "нет имени"
                    let email = document.get("email") as? String ?? "нет email"
                    let photo = document.get("image") as? String ?? ""
                    
                    if let category = document["lastquiz"] as? [String: Any] {
                        let sound = category["sound"] as? String ?? ""
                        let music = category["music"] as? String ?? ""
                        let CorrectAnswersCounter = category["CorrectAnswersCounter"] as? Int ?? 0
                        let background = category["background"] as? String ?? ""
                        let bestscore = category["bestscore"] as? Int ?? 0
                        let category = category["category"] as? String ?? ""
                        
                        self.players.append(Player(name: name, counter: bestscore , email: email, CorrectAnswersCounter: CorrectAnswersCounter, category: category, categoryMusic: music , image: photo, background: background, sound: sound))
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
                    let name = data?["name"] as? String ?? "нет имени"
                    let email = data?["email"] as? String ?? "нет email"
                    let image = data?["image"] as? String ?? "https://cdn-icons-png.flaticon.com/512/3637/3637624.png"
                    let password = data?["password"] as? String ?? ""
                    
                    if let category = document["lastquiz"] as? [String: Any] {
                        let CorrectAnswersCounter = category["CorrectAnswersCounter"] as? Int ?? 0
                        let icon = category["icon"] as? String ?? ""
                        let date = category["date"] as? String ?? ""
                        let sound = category["sound"] as? String ?? ""
                        let background = category["background"] as? String ?? ""
                        let bestscore = category["bestscore"] as? Int ?? 0
                        let category = category["category"] as? String ?? ""
                        
                        let user = Profile(name: name, email: email, score: bestscore, correctAnswers: CorrectAnswersCounter, category: category, image: image, icon: icon, background: background, password: password, voicepassword: self.settingsManager.voicepassword, categorysound: sound, categoryDate: date)
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
    
    // воспроизвести звук последней категории викторины
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
    
    // обновить фото профиля
    func UpdateProfilePhoto(string: String) {
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
    
    func DeleteAccount() {
        
        if Auth.auth().currentUser?.email != nil {
           
            let user = Auth.auth().currentUser
            
            user?.delete { error in
                if let error = error {
                    SCLAlertView().showError("Ошибка!", subTitle: "что-то пошло не так")
                } else {
                    print("удален \(user)")
                    self.db.collection("users").document(self.email).delete()
                    self.storage.child("images/\(self.email)").delete()
                    self.settingsManager.ResetSettings()
                    SCLAlertView().showSuccess("Успех!", subTitle: "пользователь успешно удален")
                }
            }
        } else {
            print("no user")
        }
    }
    
    func SignOutAction() {
        try? Auth.auth().signOut()
    }
}
