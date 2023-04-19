//
//  QuizTasksViewModel.swift
//  QUIZ
//
//  Created by Марк Киричко on 02.07.2022.
//

import Combine

class QuizTasksViewModel {
    
    @Published var tasks = [QuizTaskModel(id: 1, name: "пройти викторину в категории \"астрономия\"", image: "astronomy.png", background: "earth.background.jpeg", complete: false, quizpath: "quizastronomy", sound: "space.wav"), QuizTaskModel(id: 2, name: "пройти викторину в категории \"история\"", image: "history.jpeg", background: "history.background.jpeg", complete: false, quizpath: "quizhistory", sound: "history.wav"), QuizTaskModel(id: 3, name: "пройти викторину в категории \"анатомия\"", image: "anatomy.jpeg", background: "anatomy.background.jpeg", complete: false, quizpath: "quizanatomy", sound: "anatomy.mp3"), QuizTaskModel(id: 4, name: "пройти викторину в категории \"спорт\"", image: "sport.jpeg", background: "sport.background.jpeg", complete: false, quizpath: "quizsport", sound: "sport.wav"), QuizTaskModel(id: 5, name: "пройти викторину в категории \"игры\"", image: "games.jpeg", background: "games.background.jpeg", complete: false, quizpath: "quizgames", sound: "games.mp3"), QuizTaskModel(id: 6, name: "пройти викторину в категории \"IQ\"", image: "IQ.jpeg", background: "IQ.background.jpeg", complete: false, quizpath: "quiziq", sound: "IQ.mp3"), QuizTaskModel(id: 7, name: "пройти викторину в категории \"экономика\"", image: "economy.jpeg", background: "economy.background.jpeg", complete: false, quizpath: "quizeconomy", sound: "economics.mp3"), QuizTaskModel(id: 8, name: "пройти викторину в категории \"география\"", image: "geography.jpeg", background: "geography.background.jpeg", complete: false, quizpath: "quizgeography", sound: "geography.mp3"), QuizTaskModel(id: 9, name: "пройти викторину в категории \"экология\"", image: "ecology.jpeg", background: "ecology.background.jpeg", complete: false, quizpath: "quizecology", sound: "ecology.wav"), QuizTaskModel(id: 10, name: "пройти викторину в категории \"физика\"", image: "physics.jpeg", background: "physics.background.jpeg", complete: false, quizpath: "quizphysics", sound: "physics.mp3"), QuizTaskModel(id: 11, name: "пройти викторину в категории \"химия\"", image: "chemistry.jpeg", background: "chemistry.background.jpeg", complete: false, quizpath: "quizchemistry", sound: "chemistry.mp3"), QuizTaskModel(id: 12, name: "пройти викторину в категории \"информатика\"", image: "informatics.jpeg", background: "informatics.background.jpeg", complete: false, quizpath: "quizinformatics", sound: "informatics.mp3"),QuizTaskModel(id: 13, name: "пройти викторину в категории \"литература\"", image: "literature.jpeg", background: "literature.background.jpeg", complete: false, quizpath: "quizliterature", sound: "literature.mp3"), QuizTaskModel(id: 14, name: "пройти викторину в категории \"ПДД\"", image: "drive.jpeg", background: "drive.background.jpeg", complete: false, quizpath: "quizroadtraffic", sound: "roadtraffic.mp3"), QuizTaskModel(id: 15, name: "пройти викторину в категории \"Swift\"", image: "swift.jpeg", background: "swift.background.jpeg", complete: false, quizpath: "quizswift", sound: "swift.mp3"), QuizTaskModel(id: 16, name: "пройти викторину в категории \"подводный мир\"", image: "underwater.png", background: "underwater.background.jpeg", complete: false, quizpath: "quizunderwater", sound: "underwater.wav"), QuizTaskModel(id: 17, name: "пройти викторину в категории \"шахматы\"", image: "chess.png", background: "chess.background.jpeg", complete: false, quizpath: "quizchess", sound: "chess.mp3"), QuizTaskModel(id: 18, name: "пройти викторину в категории \"хэллоуин\"", image: "halloween.png", background: "halloween.background.jpeg", complete: false, quizpath: "quizhalloween", sound: "halloween.wav"), QuizTaskModel(id: 19, name: "пройти викторину в категории \"новый год\"", image: "newyear.png", background: "newyear.background.jpeg", complete: false, quizpath: "quiznewyear", sound: "newyear.mp3")]
    private let firebaseManager = FirebaseManager()
    
    func LoadTasksResults() {
        configure(tasks)
    }
    
    func configure(_ tasks: [QuizTaskModel])  {
        for i in tasks {
            firebaseManager.LoadQuizTasksData(quizpath: i.quizpath) { task in
                self.tasks[i.id - 1].complete = task.complete
            }
        }
    }
}