//
//  CategoryTableViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 26.02.2022.
//

import UIKit
import SCLAlertView
import Combine

final class CategoryTableViewController: UITableViewController, CustomViewCellDelegate {
    
    @IBOutlet weak var InfoCategoriesButton: UIBarButtonItem!
    
    var categoriesViewModel = CategoriesViewModel()
    var player = SoundClass()
    var delegate: CustomViewCellDelegate?
    var cancellation: Set<AnyCancellable> = []
    
    @IBAction func ShowCategoriesInfo() {
        player.Sound(resource: "future click sound.wav")
        SCLAlertView().showInfo("О Категориях", subTitle: "В каждой категории викторины по 20 вопросов максимальный результат равен 100 баллам. После того как вы пройдете одну из различных категорий ваш результат появиться в таблице \"Список Игроков\". На данный момент количество категорий равно \(categoriesViewModel.categories.count).")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoriesViewModel.$categories.sink { [weak self] category in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }.store(in: &cancellation)
        self.categoriesViewModel.LoadResults()
        self.tableView.register(UINib(nibName: CategoryTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CategoryTableViewCell.identifier)
        navigationItem.title = "Категории (\(categoriesViewModel.categories.count))"
    }
    
    func didElementClick() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.performSegue(withIdentifier: "showDetail", sender: nil)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return categoriesViewModel.categories.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesViewModel.categories[section].categories.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        player.Sound(resource: categoriesViewModel.categories[indexPath.section].categories[indexPath.row].sound)
        
        if let cell = tableView.cellForRow(at: indexPath) as? CategoryTableViewCell {
               cell.didSelect(indexPath: indexPath)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail",
           let destinationController = segue.destination as? QuizCategoryDetailViewController,
           let indexSelectedCell = tableView.indexPathForSelectedRow {
            let category = categoriesViewModel.categories[indexSelectedCell.section].categories[indexSelectedCell.row]
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
        return categoriesViewModel.categories[section].releaseDate
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        let lbl = UILabel(frame: CGRect(x: 15, y: 0, width: view.frame.width - 15, height: 40))
        lbl.font = UIFont.systemFont(ofSize: 25)
        lbl.text = categoriesViewModel.categories[section].releaseDate
        view.addSubview(lbl)
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier, for: indexPath) as! CategoryTableViewCell
        cell.delegate = self
        cell.ConfigureCell(category: categoriesViewModel.categories[indexPath.section].categories[indexPath.row])
        return cell
    }
    
}

