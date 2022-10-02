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
        switch(indexPath.row) {
        case 0:  player.Sound(resource: "space.wav")
            categories.GoToStart(quiz: QuizPlanets(), storyboard: storyboard, view: view)
        case 1:  player.Sound(resource: "history.wav")
            categories.GoToStart(quiz: QuizHistory(), storyboard: storyboard, view: view)
        case 2: player.Sound(resource: "anatomy.mp3")
            categories.GoToStart(quiz: QuizAnatomy(), storyboard: storyboard, view: view)
        case 3: player.Sound(resource: "sport.wav")
            categories.GoToStart(quiz: QuizSport(), storyboard: storyboard, view: view)
        case 4: player.Sound(resource: "games.mp3")
            categories.GoToStart(quiz: QuizGames(), storyboard: storyboard, view: view)
        case 5: player.Sound(resource: "IQ.mp3")
            categories.GoToStart(quiz: QuizIQ(), storyboard: storyboard, view: view)
        case 6: player.Sound(resource: "economics.mp3")
            categories.GoToStart(quiz: QuizEconomy(), storyboard: storyboard, view: view)
        case 7: player.Sound(resource: "geography.mp3")
            categories.GoToStart(quiz: QuizGeography(), storyboard: storyboard, view: view)
        case 8: player.Sound(resource: "ecology.wav")
            categories.GoToStart(quiz: QuizEcology(), storyboard: storyboard, view: view)
        case 9: player.Sound(resource: "physics.mp3")
            categories.GoToStart(quiz: QuizPhysics(), storyboard: storyboard, view: view)
        case 10: player.Sound(resource: "chemistry.mp3")
            categories.GoToStart(quiz: QuizChemistry(), storyboard: storyboard, view: view)
        case 11: player.Sound(resource: "informatics.mp3")
            categories.GoToStart(quiz: QuizInformatics(), storyboard: storyboard, view: view)
        case 12: player.Sound(resource: "literature.mp3")
            categories.GoToStart(quiz: QuizLiterature(), storyboard: storyboard, view: view)
        case 13: player.Sound(resource: "roadtraffic.mp3")
            categories.GoToStart(quiz: QuizRoadTraffic(), storyboard: storyboard, view: view)
        case 14: player.Sound(resource: "swift.mp3")
            categories.GoToStart(quiz: QuizSwift(), storyboard: storyboard, view: view)
        case 15: player.Sound(resource: "underwater.wav")
            categories.GoToStart(quiz: QuizUnderwater(), storyboard: storyboard, view: view)
        case 16: player.Sound(resource: "chess.mp3")
            categories.GoToStart(quiz: QuizChess(), storyboard: storyboard, view: view)
        case 17: player.Sound(resource: "halloween.wav")
            categories.GoToStart(quiz: QuizHalloween(), storyboard: storyboard, view: view)
        case 18: player.Sound(resource: "dice.wav")
            categories.PresentRandomQuiz(storyboard: storyboard, view: view)
            
        default: break
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier, for: indexPath) as! CategoryTableViewCell
        
        cellmodel.configure(categories.categories[indexPath.row], CategoryImage: cell.CategoryImage, CategoryText: cell.CategoryText, isComplete: cell.isComplete, CategoryScore: cell.CategoryScore, background: cell)
        
        return cell
    }
    
}

