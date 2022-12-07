//
//  PlayerViewModel.swift
//  QUIZ
//
//  Created by Марк Киричко on 02.07.2022.
//

import Firebase
import Combine

class PlayersViewModel {
    
    @Published var players = [Player]()
    
    let db = Firestore.firestore()
    
    var player: Player?
    
    var categories = [QuizModel(name: "планеты", image: "planets.jpeg", base: QuizPlanets(), background: "earth.background.jpeg", complete: false, id: 1, score: 0, sound: "space.wav", music: "space music.mp3"), QuizModel(name: "история", image: "history.jpeg", base: QuizHistory(), background: "history.background.jpeg", complete: false, id: 2, score: 0, sound: "history.wav", music: "history music.mp3"), QuizModel(name: "анатомия", image: "anatomy.jpeg", base: QuizAnatomy(), background: "anatomy.background.jpeg", complete: false, id: 3, score: 0, sound: "anatomy.mp3", music: "anatomy music.mp3"), QuizModel(name: "спорт", image: "sport.jpeg", base: QuizSport(), background: "sport.background.jpeg", complete: false, id: 4, score: 0, sound: "sport.wav", music: "sport music.mp3"), QuizModel(name: "игры", image: "games.jpeg", base: QuizGames(), background: "games.background.jpeg", complete: false, id: 5, score: 0, sound: "games.mp3", music: "games music.mp3"), QuizModel(name: "IQ", image: "IQ.jpeg", base: QuizIQ(), background: "IQ.background.jpeg", complete: false, id: 6, score: 0, sound: "IQ.mp3", music: "IQ music.mp3"), QuizModel(name: "экономика", image: "economy.jpeg", base: QuizEconomy(), background: "economy.background.jpeg", complete: false, id: 7, score: 0, sound: "economics.mp3", music: "economy music.mp3"), QuizModel(name: "география", image: "geography.jpeg", base: QuizGeography(), background: "geography.background.jpeg", complete: false, id: 8, score: 0, sound: "geography.mp3", music: "geography music.mp3"), QuizModel(name: "экология", image: "ecology.jpeg", base: QuizEcology(), background: "ecology.background.jpeg", complete: false, id: 9, score: 0, sound: "ecology.wav", music: "ecology music.mp3"), QuizModel(name: "физика", image: "physics.jpeg", base: QuizPhysics(), background: "physics.background.jpeg", complete: false, id: 10, score: 0, sound: "physics.mp3", music: "physics music.mp3"), QuizModel(name: "химия", image: "chemistry.jpeg", base: QuizChemistry(), background: "chemistry.background.jpeg", complete: false, id: 11, score: 0, sound: "chemistry.mp3", music: "chemistry music.mp3"), QuizModel(name: "информатика", image: "informatics.jpeg", base: QuizInformatics(), background: "informatics.background.jpeg", complete: false, id: 12, score: 0, sound: "informatics.mp3", music: "informatics music.mp3"), QuizModel(name: "литература", image: "literature.jpeg", base: QuizLiterature(), background: "literature.background.jpeg", complete: false, id: 13, score: 0, sound: "literature.mp3", music: "literature music.mp3"), QuizModel(name: "ПДД", image: "drive.jpeg", base: QuizRoadTraffic(), background: "drive.background.jpeg", complete: false, id: 14, score: 0, sound: "roadtraffic.mp3", music: "drive music.mp3"), QuizModel(name: "Swift", image: "swift.jpeg", base: QuizSwift(), background:"swift.background.jpeg", complete: false, id: 15, score: 0, sound: "swift.mp3", music: "Swift music.mp3"), QuizModel(name: "подводный мир", image: "underwater.png", base: QuizUnderwater(), background: "underwater.background.jpeg", complete: false, id: 16, score: 0, sound: "underwater.wav", music: "underwater music.mp3"), QuizModel(name: "шахматы", image: "chess.png", base: QuizChess(), background: "chess.background.jpeg", complete: false, id: 17, score: 0, sound: "chess.mp3", music: "chess music.mp3"), QuizModel(name: "хэллоуин", image: "halloween.png", base: QuizHalloween(), background: "halloween.background.jpeg", complete: false, id: 18, score: 0, sound: "halloween.wav", music: "halloween music.mp3"), QuizModel(name: "новый год", image: "newyear.png", base: QuizNewYear(), background: "newyear.background.jpeg", complete: false, id: 19, score: 0, sound: "newyear.mp3", music: "newyear music.mp3")]
    
    func LoadCurrentPlayerData(quizpath: String, isComplete: UILabel, CategoryScore: UILabel) {
        let docRef = db.collection("users").document(player?.email ?? "")
        
        docRef.getDocument { document, error in
            if let error = error as NSError? {
                print("Error getting document: \(error.localizedDescription)")
            } else {
                if let document = document {
                    
                    if let category = document[quizpath] as? [String: Any] {
                        let complete = category["complete"] as? Bool ?? false
                        let bestscore = category["bestscore"] as? Int ?? 0
                        let CorrectAnswersCounter = category["CorrectAnswersCounter"] as? Int ?? 0
                        
                        CategoryScore.text = "\(bestscore)/100 баллов"
                        isComplete.text = "\(complete)"
                        
                        if complete == true && CorrectAnswersCounter != nil {
                            isComplete.text = "пройдено \(CorrectAnswersCounter)/20"
                            isComplete.textColor = UIColor.systemGreen
                        } else if complete == nil || complete == false {
                            isComplete.text = "еще не пройдено"
                            isComplete.textColor = UIColor.gray
                        }
                    }
                }
            }
        }
    }
    
    func configure(_ category: QuizModel, CategoryImage: UIImageView, CategoryText: UILabel, isComplete: UILabel, CategoryScore: UILabel, background: UIView)  {
        background.backgroundColor = UIColor(patternImage: UIImage(named: category.background)!)
        CategoryImage.image = UIImage(named: category.image)
        CategoryText.text = category.name
        CategoryScore.text = "\(category.score)/100"
        
        if category.complete == nil || category.complete == false {
            isComplete.text = "еще не пройдено 0/20"
            isComplete.textColor = UIColor.gray
        }
        
        switch category.id {
            
        case 1:
            LoadCurrentPlayerData(quizpath: "quizplanets", isComplete: isComplete, CategoryScore: CategoryScore)
            
        case 2:
            LoadCurrentPlayerData(quizpath: "quizhistory", isComplete: isComplete, CategoryScore: CategoryScore)
            
        case 3:
            LoadCurrentPlayerData(quizpath: "quizanatomy", isComplete: isComplete, CategoryScore: CategoryScore)
            
        case 4:
            LoadCurrentPlayerData(quizpath: "quizsport", isComplete: isComplete, CategoryScore: CategoryScore)
            
        case 5:
            LoadCurrentPlayerData(quizpath: "quizgames", isComplete: isComplete, CategoryScore: CategoryScore)
            
        case 6:
            LoadCurrentPlayerData(quizpath: "quiziq", isComplete: isComplete, CategoryScore: CategoryScore)
            
        case 7:
            LoadCurrentPlayerData(quizpath: "quizeconomy", isComplete: isComplete, CategoryScore: CategoryScore)
            
        case 8:
            LoadCurrentPlayerData(quizpath: "quizgeography", isComplete: isComplete, CategoryScore: CategoryScore)
            
        case 9:
            LoadCurrentPlayerData(quizpath: "quizecology", isComplete: isComplete, CategoryScore: CategoryScore)
            
        case 10:
            LoadCurrentPlayerData(quizpath: "quizphysics", isComplete: isComplete, CategoryScore: CategoryScore)
            
        case 11:
            LoadCurrentPlayerData(quizpath: "quizchemistry", isComplete: isComplete, CategoryScore: CategoryScore)
            
        case 12:
            LoadCurrentPlayerData(quizpath: "quizinformatics", isComplete: isComplete, CategoryScore: CategoryScore)
            
        case 13:
            LoadCurrentPlayerData(quizpath: "quizliterature", isComplete: isComplete, CategoryScore: CategoryScore)
            
        case 14:
            LoadCurrentPlayerData(quizpath: "quizroadtraffic", isComplete: isComplete, CategoryScore: CategoryScore)
            
        case 15:
            LoadCurrentPlayerData(quizpath: "quizswift", isComplete: isComplete, CategoryScore: CategoryScore)
            
        case 16:
            LoadCurrentPlayerData(quizpath: "quizunderwater", isComplete: isComplete, CategoryScore: CategoryScore)
           
        case 17:
            LoadCurrentPlayerData(quizpath: "quizchess", isComplete: isComplete, CategoryScore: CategoryScore)
            
        case 18:
            LoadCurrentPlayerData(quizpath: "quizhalloween", isComplete: isComplete, CategoryScore: CategoryScore)
            
        case 19:
            LoadCurrentPlayerData(quizpath: "quiznewyear", isComplete: isComplete, CategoryScore: CategoryScore)
            
        case 20:
            LoadCurrentPlayerData(quizpath: "lastquiz", isComplete: isComplete, CategoryScore: CategoryScore)
        
        default:
            break
        }
        
    }
    
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
                        let sound = category["sound"] as? String ?? ""
                        let CorrectAnswersCounter = category["CorrectAnswersCounter"] as? Int
                        let background = category["background"] as? String
                        let bestscore = category["bestscore"] as? Int ?? 0
                        let category = category["category"] as? String ?? ""
                        
                        self.players.append(Player(name: name ?? "", counter: bestscore , email: email ?? "", CorrectAnswersCounter: CorrectAnswersCounter ?? 0, category: category , image: photo ?? "", background: background ?? "", sound: sound))
                        print(self.players.count)
                    }
                    self.players.sort(by: { $0.counter > $1.counter })
                }
            }
        }
    }
}
