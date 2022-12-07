//
//  CategoryTableViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 26.02.2022.
//

import UIKit
import SCLAlertView

final class CategoryTableViewController: UITableViewController, CustomViewCellDelegate {
    
    @IBOutlet weak var InfoCategoriesButton: UIBarButtonItem!
    
    var categories = CategoriesViewModel()
    var cellmodel = CategoriesTableViewCellModel()
    var player = SoundClass()
    var delegate: CustomViewCellDelegate?
    
    @IBAction func ShowCategoriesInfo() {
        player.Sound(resource: "future click sound.wav")
        SCLAlertView().showInfo("О Категориях", subTitle: "В каждой категории викторины по 20 вопросов максимальный результат равен 100 баллам. После того как вы пройдете одну из различных категорий ваш результат появиться в таблице \"Список Игроков\". На данный момент количество категорий равно \(categories.categories.count).")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: CategoryTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CategoryTableViewCell.identifier)
        navigationItem.title = "Категории (\(categories.categories.count))"
    }
    
    func didElementClick() {
        performSegue(withIdentifier: "showDetail", sender: nil)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return categories.categories.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.categories[section].categories.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        player.Sound(resource: categories.categories[indexPath.section].categories[indexPath.row].sound)
        
        if let cell = tableView.cellForRow(at: indexPath) as? CategoryTableViewCell {
               cell.didSelect(indexPath: indexPath)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail",
           let destinationController = segue.destination as? QuizCategoryDetailViewController,
           let indexSelectedCell = tableView.indexPathForSelectedRow {
            let category = categories.categories[indexSelectedCell.section].categories[indexSelectedCell.row]
           destinationController.category = category
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.contentView.backgroundColor = .black
            headerView.textLabel?.textColor = .white
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories.categories[section].releaseDate
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        let lbl = UILabel(frame: CGRect(x: 15, y: 0, width: view.frame.width - 15, height: 40))
        lbl.font = UIFont.systemFont(ofSize: 25)
        lbl.text = categories.categories[section].releaseDate
        view.addSubview(lbl)
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier, for: indexPath) as! CategoryTableViewCell
        cell.delegate = self
        cellmodel.configure(categories.categories[indexPath.section].categories[indexPath.row], CategoryImage: cell.CategoryImage, CategoryText: cell.CategoryText, isComplete: cell.isComplete, CategoryScore: cell.CategoryScore, background: cell)
        cell.CategoryImage.sound = categories.categories[indexPath.section].categories[indexPath.row].sound
        cell.CategoryImage.color = .white
        
        return cell
    }
    
}

