//
//  QuizTasksListViewViewModel + Extensions.swift
//  QUIZ
//
//  Created by Марк Киричко on 24.06.2023.
//

import UIKit

// MARK: - UITableViewDataSource
extension QuizTasksListViewViewModel: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: QuizTasksTableViewCell.identifier, for: indexPath) as? QuizTasksTableViewCell else {fatalError()}
        cell.ConfigureCell(task: tasks[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension QuizTasksListViewViewModel: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        audioPlayer?.PlaySound(resource: tasks[indexPath.row].sound)
        
        if let cell = tableView.cellForRow(at: indexPath) as? QuizTasksTableViewCell {
            cell.didSelect(indexPath: indexPath)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.delegate?.QuizTaskSelected(task: self.tasks[indexPath.row])
        }
    }
}
