//
//  QuizTasksListViewController + Extensions.swift
//  QUIZ
//
//  Created by Марк Киричко on 25.06.2023.
//

import Foundation

// MARK: - QuizTasksListViewDelegate
extension QuizTasksListViewController: QuizTasksListViewDelegate {
    
    func ShowCurrentQuizTask(task: QuizTaskModel) {
        self.task = task
        performSegue(withIdentifier: "showTaskDetail", sender: self)
    }
}
