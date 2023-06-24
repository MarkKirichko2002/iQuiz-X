//
//  QuizTasksListViewViewModel.swift
//  QUIZ
//
//  Created by Марк Киричко on 17.05.2023.
//

import UIKit

protocol QuizTasksListViewViewModelDelegate: AnyObject {
    func QuizTasksResultsLoaded()
    func QuizTaskSelected(task: QuizTaskModel)
}

class QuizTasksListViewViewModel: NSObject {
    
    weak var delegate: QuizTasksListViewViewModelDelegate?
    var tasks = QuizTasks.tasks
    
    // MARK: - сервисы
    private let firebaseManager: FirebaseManagerProtocol?
    let audioPlayer: SoundClassProtocol?
    
    // MARK: - Init
    init(firebaseManager: FirebaseManagerProtocol?, audioPlayer: SoundClassProtocol?) {
        self.firebaseManager = firebaseManager
        self.audioPlayer = audioPlayer
    }
    
    func LoadTasksResults() {
        for task in tasks {
            firebaseManager?.LoadQuizTasksData(quizpath: task.quizpath) { result in
                DispatchQueue.main.async {
                    self.tasks[task.id - 1].complete = result.complete
                    self.delegate?.QuizTasksResultsLoaded()
                }
            }
        }
    }
}
