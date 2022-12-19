//
//  TasksTableViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 20.02.2022.
//

import UIKit
import Combine

final class TasksTableViewController: UITableViewController {
    
    private var categoriesViewModel = CategoriesViewModel()
    private var tasksViewModel = TasksViewModel()
    private var player = SoundClass()
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        player.Sound(resource: categoriesViewModel.quizcategories[indexPath.row].sound)
        
        if let cell = tableView.cellForRow(at: indexPath) as? TasksTableViewCell {
               cell.didSelect(indexPath: indexPath)
        }
        
        switch(indexPath.row) {
        
          case  0...18:
            categoriesViewModel.GoToStart(quiz: categoriesViewModel.quizcategories[indexPath.row].base, category: categoriesViewModel.quizcategories[indexPath.row])
            
        case 19: categoriesViewModel.PresentRandomQuiz()
            
        default: break
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TasksTableViewCell.identifier, for: indexPath) as! TasksTableViewCell
        cell.ConfigureCell(task: tasksViewModel.tasks[indexPath.row])
        return cell
    }
    
}

