//
//  QuizModel.swift
//  QUIZ
//
//  Created by Марк Киричко on 26.02.2022.
//

import Foundation

struct QuizModel {
    var name: String
    var image: String
    var complete: Bool
    var id: Int
    var score: Int
}

struct QuizStorage {
    static let shared = QuizStorage()
    
    var categories: [QuizModel]

     init() {
        categories = [QuizModel(name: "планеты", image: "planets.jpeg", complete: false, id: 1, score: 0),
                 QuizModel(name: "история", image: "history.jpeg", complete: false, id: 2, score: 0),
                 QuizModel(name: "анатомия", image: "anatomy.jpeg", complete: false, id: 3, score: 0),
                 QuizModel(name: "спорт", image: "sport.jpeg", complete: false, id: 4, score: 0),
                 QuizModel(name: "игры", image: "games.jpeg", complete: false, id: 5, score: 0),
                 QuizModel(name: "IQ", image: "IQ.jpeg", complete: false, id: 6, score: 0),
                      QuizModel(name: "экономика", image: "economy.jpeg", complete: false, id: 7, score: 0),
                      QuizModel(name: "география", image: "geography.jpeg", complete: false, id: 8, score: 0),
                      QuizModel(name: "экология", image: "ecology.jpeg", complete: false, id: 9, score: 0),
                      QuizModel(name: "физика", image: "physics.jpeg", complete: false, id: 10, score: 0),
                      //QuizModel(name: "скоро!", image: "coming soon.jpeg", complete: false, id: 0, score: 0),
                      QuizModel(name: "химия", image: "chemistry.jpeg", complete: false, id: 11, score: 0),
                      QuizModel(name: "информатика", image: "informatics.jpeg", complete: false, id: 12, score: 0),
                      QuizModel(name: "литература", image: "literature.jpeg", complete: false, id: 13, score: 0),
                      QuizModel(name: "ПДД", image: "drive.jpeg", complete: false, id: 14, score: 0),
                      QuizModel(name: "Swift", image: "swift.jpeg", complete: false, id: 15, score: 0),
                      QuizModel(name: "подводный мир", image: "underwater", complete: false, id: 16, score: 0),
                      QuizModel(name: "рандом", image: "random.jpeg", complete: false, id: 17, score: 0)
        ]
    }
}

