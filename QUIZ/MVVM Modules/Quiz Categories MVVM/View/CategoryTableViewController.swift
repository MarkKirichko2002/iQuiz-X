//
//  CategoryTableViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 26.02.2022.
//

import UIKit
import SCLAlertView

final class CategoryTableViewController: UITableViewController {
    
    @IBOutlet weak var InfoCategoriesButton: UIBarButtonItem!
    
    var categories = CategoriesViewModel()
    var cellmodel = CategoriesTableViewCellModel()
    var player = SoundClass()
    
    @IBAction func ShowCategoriesInfo() {
        player.Sound(resource: "future click sound.wav")
        SCLAlertView().showInfo("О Категориях", subTitle: "В каждой категории викторины по 20 вопросов максимальный результат равен 100 баллам. После того как вы пройдете одну из различных категорий ваш результат появиться в таблице \"Список Игроков\". На данный момент количество категорий равно \(categories.categories.count).")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Категории (\(categories.categories.count))"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.categories.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        player.Sound(resource: categories.categories[indexPath.row].sound)
        
        if let cell = tableView.cellForRow(at: indexPath) as? CategoryTableViewCell {
               cell.didSelect(indexPath: indexPath)
        }
        
        switch(indexPath.row) {
        case 0: categories.GoToStart(quiz: QuizPlanets(), category: categories.categories[indexPath.row], storyboard: storyboard, view: view)
        case 1: categories.GoToStart(quiz: QuizHistory(), category: categories.categories[indexPath.row], storyboard: storyboard, view: view)
        case 2: categories.GoToStart(quiz: QuizAnatomy(), category: categories.categories[indexPath.row], storyboard: storyboard, view: view)
        case 3: categories.GoToStart(quiz: QuizSport(), category: categories.categories[indexPath.row], storyboard: storyboard, view: view)
        case 4: categories.GoToStart(quiz: QuizGames(), category: categories.categories[indexPath.row], storyboard: storyboard, view: view)
        case 5: categories.GoToStart(quiz: QuizIQ(), category: categories.categories[indexPath.row], storyboard: storyboard, view: view)
        case 6: categories.GoToStart(quiz: QuizEconomy(), category: categories.categories[indexPath.row], storyboard: storyboard, view: view)
        case 7: categories.GoToStart(quiz: QuizGeography(), category: categories.categories[indexPath.row], storyboard: storyboard, view: view)
        case 8: categories.GoToStart(quiz: QuizEcology(), category: categories.categories[indexPath.row], storyboard: storyboard, view: view)
        case 9: categories.GoToStart(quiz: QuizPhysics(), category: categories.categories[indexPath.row], storyboard: storyboard, view: view)
        case 10: categories.GoToStart(quiz: QuizChemistry(), category: categories.categories[indexPath.row], storyboard: storyboard, view: view)
        case 11: categories.GoToStart(quiz: QuizInformatics(), category: categories.categories[indexPath.row], storyboard: storyboard, view: view)
        case 12: categories.GoToStart(quiz: QuizLiterature(), category: categories.categories[indexPath.row], storyboard: storyboard, view: view)
        case 13: categories.GoToStart(quiz: QuizRoadTraffic(), category: categories.categories[indexPath.row], storyboard: storyboard, view: view)
        case 14: categories.GoToStart(quiz: QuizSwift(), category: categories.categories[indexPath.row], storyboard: storyboard, view: view)
        case 15: categories.GoToStart(quiz: QuizUnderwater(), category: categories.categories[indexPath.row], storyboard: storyboard, view: view)
        case 16: categories.GoToStart(quiz: QuizChess(), category: categories.categories[indexPath.row], storyboard: storyboard, view: view)
        case 17: categories.GoToStart(quiz: QuizHalloween(), category: categories.categories[indexPath.row], storyboard: storyboard, view: view)
        case 18: categories.PresentRandomQuiz(storyboard: storyboard, view: view)
            
        default: break
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier, for: indexPath) as! CategoryTableViewCell
        
        cellmodel.configure(categories.categories[indexPath.row], CategoryImage: cell.CategoryImage, CategoryText: cell.CategoryText, isComplete: cell.isComplete, CategoryScore: cell.CategoryScore, background: cell)
        cell.CategoryImage.sound = categories.categories[indexPath.row].sound
        
        return cell
    }
    
}

