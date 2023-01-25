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
    @Published var categories = [QuizCategoryModel]()
    private let audioPlayer = SoundClass()
    private let firebaseManager = FirebaseManager()
    private let quizCategoriesViewModel = QuizCategoriesViewModel()
    private let db = Firestore.firestore()
    var player: Player?
    
    init() {
        categories = quizCategoriesViewModel.quizcategories
    }
    
    func GetPlayers() {
        firebaseManager.LoadPlayers { players in
            self.players = players
        }
    }
    
    func LoadResults() {
        for i in categories {
            configure(category: i)
        }
    }
    
    private func configure(category: QuizCategoryModel) {
        firebaseManager.email = player?.email ?? ""
        firebaseManager.LoadQuizCategoriesData(quizpath: category.quizpath) { result in
            self.categories[category.id - 1].score = result.score
            self.categories[category.id - 1].complete = result.complete
        }
    }
    
    func PlayCurrentCategoryMusic() {
        audioPlayer.PlaySound(resource: player?.categoryMusic ?? "")
    }
}
