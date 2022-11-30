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
    
    var categories = CategoriesViewModel()
    var tasks = TasksViewModel()
    var cellmodel = TasksTableViewCellModel()
    var player = SoundClass()
    
    @IBAction func ShowTasksInfo() {
        player.Sound(resource: "future click sound.wav")
        SCLAlertView().showInfo("О Заданиях", subTitle: "Выполняйте задания для каждой категории. После того как вы ответите правильно или даже не правильно хотя бы на один вопрос из викторины статус викторины станет \"Пройдено\". На данный момент количество заданий равно \(tasks.tasks.count).")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(tasks.tasks.count)
        navigationItem.title = "Задания (\(tasks.tasks.count))"
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.tasks.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        player.Sound(resource: categories.categories[indexPath.row].sound)
        
        if let cell = tableView.cellForRow(at: indexPath) as? TasksTableViewCell {
               cell.didSelect(indexPath: indexPath)
        }
        
        switch(indexPath.row) {
        
          case  0...17:
            categories.GoToStart(quiz: categories.categories[indexPath.row].base, category: categories.categories[indexPath.row], storyboard: self.storyboard, view: self.view)
            
        case 18: categories.PresentRandomQuiz(storyboard: storyboard, view: view)
            
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

