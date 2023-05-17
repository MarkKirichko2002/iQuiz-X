//
//  QuizTasksListViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 17.05.2023.
//

import UIKit

class QuizTasksListViewController: UIViewController {
    
    private var task: QuizTaskModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        makeConstraints()
    }
    
    private func makeConstraints() {
        let viewModel = QuizTasksListViewViewModel()
        let quizTasksListView = QuizTasksListView(frame: .zero, viewModel: viewModel)
        quizTasksListView.delegate = self
        view.addSubview(quizTasksListView)
        NSLayoutConstraint.activate([
            quizTasksListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            quizTasksListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            quizTasksListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            quizTasksListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showTaskDetail",
//           let destinationController = segue.destination as? QuizTaskDetailViewController,
//           let indexSelectedCell = tableView.indexPathForSelectedRow {
//           let task = quizTasksViewModel.tasks[indexSelectedCell.row]
//           let category = quizCategoriesViewModel.quizcategories[indexSelectedCell.row]
//           destinationController.task = task
//           destinationController.category = category
//        }
//    }
}

// MARK: - QuizTasksListViewDelegate
extension QuizTasksListViewController: QuizTasksListViewDelegate {
    
    func ShowCurrentQuizTask(task: QuizTaskModel) {
        self.task = task
        performSegue(withIdentifier: "showTaskDetail", sender: self)
    }
    
}
