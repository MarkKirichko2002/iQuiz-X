//
//  QuizTasksTableViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 20.02.2022.
//

import UIKit
import Combine

final class QuizTasksTableViewController: UITableViewController, CustomViewCellDelegate {
   
    private let quizCategoriesViewModel = QuizCategoriesViewModel()
    private let quizTasksViewModel = QuizTasksViewModel()
    private let player = SoundClass()
    private var cancellation: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: QuizTasksTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: QuizTasksTableViewCell.identifier)
        quizCategoriesViewModel.view = self.view
        quizCategoriesViewModel.storyboard = self.storyboard
        quizTasksViewModel.$tasks.sink { [weak self] category in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }.store(in: &cancellation)
        self.quizTasksViewModel.LoadTasksResults()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        quizTasksViewModel.tasks.count
    }
    
    func didElementClick() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.performSegue(withIdentifier: "showTaskDetail", sender: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        player.PlaySound(resource: quizTasksViewModel.tasks[indexPath.row].sound)
        
        if let cell = tableView.cellForRow(at: indexPath) as? QuizTasksTableViewCell {
               cell.didSelect(indexPath: indexPath)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTaskDetail",
           let destinationController = segue.destination as? QuizTaskDetailViewController,
           let indexSelectedCell = tableView.indexPathForSelectedRow {
           let task = quizTasksViewModel.tasks[indexSelectedCell.row]
           let category = quizCategoriesViewModel.quizcategories[indexSelectedCell.row]
           destinationController.task = task
           destinationController.category = category
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QuizTasksTableViewCell.identifier, for: indexPath) as! QuizTasksTableViewCell
        cell.delegate = self
        cell.ConfigureCell(task: quizTasksViewModel.tasks[indexPath.row])
        return cell
    }
}
