//
//  TasksViewModel.swift
//  QUIZ
//
//  Created by Марк Киричко on 02.07.2022.
//

import Foundation
import Combine
import SnapKit

class TasksViewModel {
    
    @Published var tasks = [TaskModel]()
    
    public var firebaseManager = FirebaseManager()
    
    func CreateTasks() {
        tasks = [TaskModel(name: "пройти викторину в категории планеты", image: "planets.jpeg", background: "earth.background.jpeg", complete: false, id: 1, sound: "space.wav"), TaskModel(name: "пройти викторину в категории история", image: "history.jpeg", background: "history.background.jpeg", complete: false, id: 2, sound: "history.wav"), TaskModel(name: "пройти викторину в категории анатомия", image: "anatomy.jpeg", background: "anatomy.background.jpeg", complete: false, id: 3, sound: "anatomy.mp3"),TaskModel(name: "пройти викторину в категории спорт", image: "sport.jpeg", background: "sport.background.jpeg", complete: false, id: 4, sound: "sport.wav"),TaskModel(name: "пройти викторину в категории игры", image: "games.jpeg", background: "games.background.jpeg", complete: false, id: 5, sound: "games.mp3"),TaskModel(name: "пройти викторину в категории IQ", image: "IQ.jpeg", background: "IQ.background.jpeg", complete: false, id: 6, sound: "IQ.mp3"),TaskModel(name: "пройти викторину в категории экономика", image: "economy.jpeg", background: "economy.background.jpeg", complete: false, id: 7, sound: "economics.mp3"),TaskModel(name: "пройти векторину в категории география", image: "geography.jpeg", background: "geography.background.jpeg", complete: false, id: 8, sound: "geography.mp3"),TaskModel(name: "пройти викторину в категории экология", image: "ecology.jpeg", background: "ecology.background.jpeg", complete: false, id: 9, sound: "ecology.wav"),TaskModel(name: "пройти викторину в категории физика", image: "physics.jpeg", background: "physics.background.jpeg", complete: false, id: 10, sound: "physics.mp3"),TaskModel(name: "пройти викторину в категории химия", image: "chemistry.jpeg", background: "chemistry.background.jpeg", complete: false, id: 11, sound: "chemistry.mp3"),TaskModel(name: "пройти викторину в категории информатика", image: "informatics.jpeg", background: "informatics.background.jpeg", complete: false, id: 12, sound: "informatics.mp3"), TaskModel(name: "пройти викторину в категории литература", image: "literature.jpeg", background: "literature.background.jpeg", complete: false, id: 13, sound: "literature.mp3"),TaskModel(name: "пройти викторину в категории ПДД", image: "drive.jpeg", background: "drive.background.jpeg", complete: false, id: 14, sound: "roadtraffic.mp3"),TaskModel(name: "пройти викторину в категории Swift", image: "swift.jpeg", background: "swift.background.jpeg", complete: false, id: 15, sound: "swift.mp3"), TaskModel(name: "пройти викторину в категории подводный мир", image: "underwater", background: "underwater.background.jpeg", complete: false, id: 16, sound: "underwater.wav"),TaskModel(name: "пройти викторину в категории шахматы", image: "chess.png", background: "chess.background.jpeg", complete: false, id: 17, sound: "chess.mp3"), TaskModel(name: "пройти викторину в категории хэллоуин", image: "halloween.png", background: "halloween.background.jpeg", complete: false, id: 18, sound: "halloween.wav"), TaskModel(name: "пройти викторину в категории новый год", image: "newyear.png", background: "newyear.background.jpeg", complete: false, id: 19, sound: "newyear.mp3"), TaskModel(name: "пройти викторину в категории рандом", image: "random.jpeg", background: "random.background.jpeg", complete: false, id: 20, sound: "dice.wav")]
    }
    
    func LoadTasksResults() {
        CreateTasks()
        for i in tasks {
            configure(i)
        }
    }
    
    func configure(_ task: TaskModel)  {
       
        switch task.id {
            
        case 1:
            firebaseManager.LoadQuizTasksData(quizpath: "quizplanets") { task in
                self.tasks[0].complete = task.complete
            }
            
        case 2:
            firebaseManager.LoadQuizTasksData(quizpath: "quizhistory") { task in
                self.tasks[1].complete = task.complete
            }
            
        case 3:
            firebaseManager.LoadQuizTasksData(quizpath: "quizanatomy") { task in
                self.tasks[2].complete = task.complete
            }
            
        case 4:
            firebaseManager.LoadQuizTasksData(quizpath: "quizsport") { task in
                self.tasks[3].complete = task.complete
            }
            
        case 5:
            firebaseManager.LoadQuizTasksData(quizpath: "quizgames") { task in
                self.tasks[4].complete = task.complete
            }
            
        case 6:
            firebaseManager.LoadQuizTasksData(quizpath: "quiziq") { task in
                self.tasks[5].complete = task.complete
            }
            
        case 7:
            firebaseManager.LoadQuizTasksData(quizpath: "quizeconomy") { task in
                self.tasks[6].complete = task.complete
            }
            
        case 8:
            firebaseManager.LoadQuizTasksData(quizpath: "quizgeography") { task in
                self.tasks[7].complete = task.complete
            }
            
        case 9:
            firebaseManager.LoadQuizTasksData(quizpath: "quizecology") { task in
                self.tasks[8].complete = task.complete
            }
            
        case 10:
            firebaseManager.LoadQuizTasksData(quizpath: "quizphysics") { task in
                self.tasks[9].complete = task.complete
            }
            
        case 11:
            firebaseManager.LoadQuizTasksData(quizpath: "quizchemistry") { task in
                self.tasks[10].complete = task.complete
            }
            
        case 12:
            firebaseManager.LoadQuizTasksData(quizpath: "quizinformatics") { task in
                self.tasks[11].complete = task.complete
            }
            
        case 13:
            firebaseManager.LoadQuizTasksData(quizpath: "quizliterature") { task in
                self.tasks[12].complete = task.complete
            }
            
        case 14:
            firebaseManager.LoadQuizTasksData(quizpath: "quizroadtraffic") { task in
                self.tasks[13].complete = task.complete
            }
            
        case 15:
            firebaseManager.LoadQuizTasksData(quizpath: "quizswift") { task in
                self.tasks[14].complete = task.complete
            }
            
        case 16:
            firebaseManager.LoadQuizTasksData(quizpath: "quizunderwater") { task in
                self.tasks[15].complete = task.complete
            }
            
        case 17:
            firebaseManager.LoadQuizTasksData(quizpath: "quizchess") { task in
                self.tasks[16].complete = task.complete
            }
            
        case 18:
            firebaseManager.LoadQuizTasksData(quizpath: "quizhalloween") { task in
                self.tasks[17].complete = task.complete
            }
            
        case 19:
            firebaseManager.LoadQuizTasksData(quizpath: "quiznewyear") { task in
                self.tasks[18].complete = task.complete
            }
            
        case 20:
            firebaseManager.LoadQuizTasksData(quizpath: "lastquiz") { task in
                self.tasks[19].complete = task.complete
            }
            
        default:
           
            break
        }
    }
    
}
