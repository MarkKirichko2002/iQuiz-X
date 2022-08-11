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
        player.Sound(resource: "selected sound.wav")
        switch(indexPath.row) {
        case 0:  categories.GoToStart(quiz: QuizPlanets(), storyboard: storyboard, view: view)
        case 1:  categories.GoToStart(quiz: QuizHistory(), storyboard: storyboard, view: view)
        case 2:  categories.GoToStart(quiz: QuizAnatomy(), storyboard: storyboard, view: view)
        case 3:  categories.GoToStart(quiz: QuizSport(), storyboard: storyboard, view: view)
        case 4:  categories.GoToStart(quiz: QuizGames(), storyboard: storyboard, view: view)
        case 5:  categories.GoToStart(quiz: QuizIQ(), storyboard: storyboard, view: view)
        case 6:  categories.GoToStart(quiz: QuizEconomy(), storyboard: storyboard, view: view)
        case 7:  categories.GoToStart(quiz: QuizGeography(), storyboard: storyboard, view: view)
        case 8:  categories.GoToStart(quiz: QuizEcology(), storyboard: storyboard, view: view)
        case 9:  categories.GoToStart(quiz: QuizPhysics(), storyboard: storyboard, view: view)
        case 10: categories.GoToStart(quiz: QuizChemistry(), storyboard: storyboard, view: view)
        case 11: categories.GoToStart(quiz: QuizInformatics(), storyboard: storyboard, view: view)
        case 12: categories.GoToStart(quiz: QuizLiterature(), storyboard: storyboard, view: view)
        case 13: categories.GoToStart(quiz: QuizRoadTraffic(), storyboard: storyboard, view: view)
        case 14: categories.GoToStart(quiz: QuizSwift(), storyboard: storyboard, view: view)
        case 15: categories.GoToStart(quiz: QuizUnderwater(), storyboard: storyboard, view: view)
        case 16: categories.GoToStart(quiz: QuizChess(), storyboard: storyboard, view: view)
        case 17: categories.PresentRandomQuiz(storyboard: storyboard, view: view)
            
            default: break
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TasksTableViewCell.identifier, for: indexPath) as! TasksTableViewCell
        
        cellmodel.configure(tasks.tasks[indexPath.row], TaskImage: cell.TaskImage, TaskText: cell.TaskText, TaskStatus: cell.TaskStatus, background: cell)
        
        return cell
    }
    
}

