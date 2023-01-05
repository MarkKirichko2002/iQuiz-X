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
    private var audioPlayer = SoundClass()
    private var firebaseManager = FirebaseManager()
    private var categoriesViewModel = CategoriesViewModel()
    
    var categories = [QuizCategoryModel]()
    
    init() {
        categories = categoriesViewModel.quizcategories
    }
    
    func GetPlayers() {
        firebaseManager.LoadPlayers { players in
            self.players = players
        }
    }
    
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
    
    func configure(_ category: QuizCategoryModel, CategoryImage: UIImageView, CategoryText: UILabel, isComplete: UILabel, CategoryScore: UILabel, background: UIView)  {
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
    
    func PlayCurrentCategoryMusic() {
        audioPlayer.PlaySound(resource: player?.categoryMusic ?? "")
    }
    
}
