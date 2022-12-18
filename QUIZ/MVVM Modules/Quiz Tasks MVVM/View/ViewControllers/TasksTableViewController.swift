//
//  TasksTableViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 20.02.2022.
//

import UIKit
import SCLAlertView

final class TasksTableViewController: UITableViewController {
    
    @IBOutlet weak var InfoTasksButton: UIBarButtonItem!
    
    var categoriesViewModel = CategoriesViewModel()
    var tasks = TasksViewModel()
    var cellmodel = TasksTableViewCellModel()
    var player = SoundClass()
    
    @IBAction func ShowTasksInfo() {
        player.Sound(resource: "future click sound.wav")
        SCLAlertView().showInfo("О Заданиях", subTitle: "Выполняйте задания для каждой категории. После того как вы ответите правильно или даже не правильно хотя бы на один вопрос из викторины статус викторины станет \"Пройдено\". На данный момент количество заданий равно \(tasks.tasks.count).")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoriesViewModel.view = self.view
        categoriesViewModel.storyboard = self.storyboard
        print(tasks.tasks.count)
        navigationItem.title = "Задания (\(tasks.tasks.count))"
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.tasks.count
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
        
        cellmodel.configure(tasks.tasks[indexPath.row], TaskImage: cell.TaskImage, TaskText: cell.TaskText, TaskStatus: cell.TaskStatus, background: cell)
        cell.TaskImage.sound = tasks.tasks[indexPath.row].sound
        cell.TaskImage.color = .white
        
        return cell
    }
    
}

