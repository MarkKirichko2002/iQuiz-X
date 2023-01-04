//
//  TasksTableViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 20.02.2022.
//

import UIKit
import Combine

final class TasksTableViewController: UITableViewController, CustomViewCellDelegate {
   
    private let categoriesViewModel = CategoriesViewModel()
    private let tasksViewModel = TasksViewModel()
    private let player = SoundClass()
    private var cancellation: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: TasksTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: TasksTableViewCell.identifier)
        categoriesViewModel.view = self.view
        categoriesViewModel.storyboard = self.storyboard
        tasksViewModel.$tasks.sink { [weak self] category in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }.store(in: &cancellation)
        self.tasksViewModel.LoadTasksResults()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasksViewModel.tasks.count
    }
    
    func didElementClick() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.performSegue(withIdentifier: "showTaskDetail", sender: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        player.PlaySound(resource: tasksViewModel.tasks[indexPath.row].sound)
        
        if let cell = tableView.cellForRow(at: indexPath) as? TasksTableViewCell {
               cell.didSelect(indexPath: indexPath)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTaskDetail",
           let destinationController = segue.destination as? QuizTaskDetailViewController,
           let indexSelectedCell = tableView.indexPathForSelectedRow {
           let task = tasksViewModel.tasks[indexSelectedCell.row]
           let category = categoriesViewModel.quizcategories[indexSelectedCell.row]
           destinationController.task = task
           destinationController.category = category
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TasksTableViewCell.identifier, for: indexPath) as! TasksTableViewCell
        cell.delegate = self
        cell.ConfigureCell(task: tasksViewModel.tasks[indexPath.row])
        return cell
    }
}
