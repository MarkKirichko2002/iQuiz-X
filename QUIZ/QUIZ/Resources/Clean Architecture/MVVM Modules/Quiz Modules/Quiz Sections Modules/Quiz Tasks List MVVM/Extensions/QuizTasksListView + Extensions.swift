//
//  QuizTasksListView + Extensions.swift
//  QUIZ
//
//  Created by Марк Киричко on 25.06.2023.
//

import Foundation

// MARK: - QuizTasksListViewViewModelDelegate
extension QuizTasksListView: QuizTasksListViewViewModelDelegate {
    
    func QuizTasksResultsLoaded() {
        tableView.reloadData()
    }
    
    func QuizTaskSelected(task: QuizTaskModel) {
        delegate?.ShowCurrentQuizTask(task: task)
    }
}
