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
        print(categories.categories.count)
        navigationItem.title = "Категории (\(categories.categories.count))"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.categories.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        player.Sound(resource: "selected sound.wav")
        switch(indexPath.row) {
        case 0:  categories.goToQuize(quiz: QuizPlanets(), storyboard: storyboard, view: view)
        case 1:  categories.goToQuize(quiz: QuizHistory(), storyboard: storyboard, view: view)
        case 2: categories.goToQuize(quiz: QuizAnatomy(), storyboard: storyboard, view: view)
        case 3:  categories.goToQuize(quiz: QuizSport(), storyboard: storyboard, view: view)
        case 4:  categories.goToQuize(quiz: QuizGames(), storyboard: storyboard, view: view)
        case 5:  categories.goToQuize(quiz: QuizIQ(), storyboard: storyboard, view: view)
        case 6:  categories.goToQuize(quiz: QuizEconomy(), storyboard: storyboard, view: view)
        case 7:  categories.goToQuize(quiz: QuizGeography(), storyboard: storyboard, view: view)
        case 8:  categories.goToQuize(quiz: QuizEcology(), storyboard: storyboard, view: view)
        case 9:  categories.goToQuize(quiz: QuizPhysics(), storyboard: storyboard, view: view)
        case 10: categories.goToQuize(quiz: QuizChemistry(), storyboard: storyboard, view: view)
        case 11: categories.goToQuize(quiz: QuizInformatics(), storyboard: storyboard, view: view)
        case 12: categories.goToQuize(quiz: QuizLiterature(), storyboard: storyboard, view: view)
        case 13: categories.goToQuize(quiz: QuizRoadTraffic(), storyboard: storyboard, view: view)
        case 14: categories.goToQuize(quiz: QuizSwift(), storyboard: storyboard, view: view)
        case 15: categories.goToQuize(quiz: QuizUnderwater(), storyboard: storyboard, view: view)
        case 16: categories.goToQuize(quiz: QuizChess(), storyboard: storyboard, view: view)
        case 17: categories.PresentRandomQuiz(storyboard: storyboard, view: view)
            
        default: break
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier, for: indexPath) as! CategoryTableViewCell
        
        cellmodel.configure(categories.categories[indexPath.row], CategoryImage: cell.CategoryImage, CategoryText: cell.CategoryText, isComplete: cell.isComplete, CategoryScore: cell.CategoryScore, background: cell)
        
        return cell
    }
    
}

