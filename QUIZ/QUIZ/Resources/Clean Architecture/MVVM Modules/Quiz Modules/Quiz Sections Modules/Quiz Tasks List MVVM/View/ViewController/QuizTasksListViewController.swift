//
//  QuizTasksListViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 17.05.2023.
//

import UIKit
import Swinject

class QuizTasksListViewController: UIViewController {
    
    var task: QuizTaskModel?
    
    private let container: Container = {
        let container = Container()
        // Firebase
        container.register(FirebaseManagerProtocol.self) { _ in
            return FirebaseManager()
        }
        // Audio
        container.register(SoundClassProtocol.self) { _ in
            return SoundClass()
        }
        // ViewModel
        container.register(QuizTasksListViewViewModel.self) { resolver in
            let viewModel = QuizTasksListViewViewModel(
                firebaseManager: container.resolve(FirebaseManagerProtocol.self),
                audioPlayer: container.resolve(SoundClassProtocol.self)
            )
            return viewModel
        }
        return container
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        makeConstraints()
    }
    
    private func makeConstraints() {
        let quizTasksListView = QuizTasksListView(frame: .zero, viewModel: container.resolve(QuizTasksListViewViewModel.self))
        quizTasksListView.delegate = self
        view.addSubview(quizTasksListView)
        NSLayoutConstraint.activate([
            quizTasksListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            quizTasksListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            quizTasksListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            quizTasksListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTaskDetail" {
            let destinationController = segue.destination as? QuizTaskDetailViewController
            destinationController!.task = task
        }
    }
}
