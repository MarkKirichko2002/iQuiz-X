//
//  CategoryTableViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 26.02.2022.
//

import UIKit
import SCLAlertView
import Combine

final class CategoryTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CustomViewCellDelegate {
    
    @IBOutlet weak var InfoCategoriesButton: UIBarButtonItem!
    var categoriesViewModel = CategoriesViewModel()
    var player = SoundClass()
    var delegate: CustomViewCellDelegate?
    var cancellation: Set<AnyCancellable> = []
    var tableView = UITableView()
    
    @IBAction func ShowCategoriesInfo() {
        player.Sound(resource: "future click sound.wav")
        SCLAlertView().showInfo("О Категориях", subTitle: "В каждой категории викторины по 20 вопросов максимальный результат равен 100 баллам. После того как вы пройдете одну из различных категорий ваш результат появиться в таблице \"Список Игроков\". На данный момент количество категорий равно \(categoriesViewModel.categories.count).")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpTable()
        categoriesViewModel.view = self.view
        categoriesViewModel.ShowLoading()
        categoriesViewModel.$categories.sink { [weak self] category in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }.store(in: &cancellation)
        self.tableView.register(UINib(nibName: CategoryTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CategoryTableViewCell.identifier)
        navigationItem.title = "Категории (\(categoriesViewModel.categories.count))"
    }
    
    func SetUpTable() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func didElementClick() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.performSegue(withIdentifier: "showDetail", sender: nil)
        }
    }
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return categoriesViewModel.categories.count
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesViewModel.categories[section].categories.count
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
    
     func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.contentView.backgroundColor = .black
            headerView.textLabel?.textColor = .white
        }
    }
    
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categoriesViewModel.categories[section].releaseDate
    }
    
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        let lbl = UILabel(frame: CGRect(x: 15, y: 0, width: view.frame.width - 15, height: 40))
        lbl.font = UIFont.systemFont(ofSize: 25)
        lbl.text = categoriesViewModel.categories[section].releaseDate
        view.addSubview(lbl)
        return view
    }
    
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier, for: indexPath) as! CategoryTableViewCell
        cell.delegate = self
        cell.ConfigureCell(category: categoriesViewModel.categories[indexPath.section].categories[indexPath.row])
        return cell
    }
    
}

