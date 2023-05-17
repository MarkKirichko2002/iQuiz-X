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
    private var tasks = QuizTasks.tasks
    
    // MARK: - сервисы
    private let firebaseManager = FirebaseManager()
    private let player = SoundClass()
    
    func LoadTasksResults() {
        for task in tasks {
            firebaseManager.LoadQuizTasksData(quizpath: task.quizpath) { result in
                DispatchQueue.main.async {
                    self.tasks[task.id - 1].complete = result.complete
                    self.delegate?.QuizTasksResultsLoaded()
                }
            }
        }
    }
}

extension QuizTasksListViewViewModel: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        player.PlaySound(resource: tasks[indexPath.row].sound)
        
        if let cell = tableView.cellForRow(at: indexPath) as? QuizTasksTableViewCell {
            cell.didSelect(indexPath: indexPath)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.delegate?.QuizTaskSelected(task: self.tasks[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: QuizTasksTableViewCell.identifier, for: indexPath) as? QuizTasksTableViewCell else {fatalError()}
        cell.ConfigureCell(task: tasks[indexPath.row])
        return cell
    }
}
