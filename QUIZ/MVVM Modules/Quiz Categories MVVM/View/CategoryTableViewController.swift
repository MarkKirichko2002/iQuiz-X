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
        
          case  0...18:
            categories.GoToStart(quiz: categories.categories[indexPath.row].base, category: categories.categories[indexPath.row], storyboard: self.storyboard, view: self.view)
            
        case 19: categories.PresentRandomQuiz(storyboard: storyboard, view: view)
            
        default: break
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier, for: indexPath) as! CategoryTableViewCell
        
        cellmodel.configure(categories.categories[indexPath.row], CategoryImage: cell.CategoryImage, CategoryText: cell.CategoryText, isComplete: cell.isComplete, CategoryScore: cell.CategoryScore, background: cell)
        cell.CategoryImage.sound = categories.categories[indexPath.row].sound
        cell.CategoryImage.color = .white
        
        return cell
    }
    
}

