//
//  PlayerDetailViewViewModel.swift
//  QUIZ
//
//  Created by Марк Киричко on 15.05.2023.
//

import UIKit

protocol PlayerDetailViewViewModelDelegate: AnyObject {
    func PlayerInfoWasLoaded()
}

class PlayerDetailViewViewModel: NSObject {
    
    public weak var delegate: PlayerDetailViewViewModelDelegate?
    var player: Player
    var categories = QuizCategories.categories
    var tasks = QuizTasks.tasks
    
    // MARK: - сервисы
    private let fireBaseManager: FirebaseManagerProtocol?
    
    // MARK: - Init
    init(fireBaseManager: FirebaseManagerProtocol?, player: Player) {
        self.fireBaseManager = fireBaseManager
        self.player = player
    }
    
    func GetPlayerInfo() {
        let fireBaseManager = FirebaseManager()
        fireBaseManager.email = player.email
        // категории
        for category in categories {
            fireBaseManager.LoadQuizCategoriesData(quizpath: category.quizpath) { result in
                self.categories[category.id - 1].score = result.score
                self.categories[category.id - 1].complete = result.complete
            }
        }
        // задания
        for task in tasks {
            fireBaseManager.LoadQuizTasksData(quizpath: task.quizpath) { result in
                self.tasks[task.id - 1].complete = result.complete
                self.delegate?.PlayerInfoWasLoaded()
            }
        }
    }
}
