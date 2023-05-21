//
//  QuizCategoriesTableViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 26.02.2022.
//

import UIKit
import Combine

final class QuizCategoriesTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CustomViewCellDelegate {
    
    private var quizCategoriesViewModel = QuizCategoriesViewModel()
    private var player = SoundClass()
    private var delegate: CustomViewCellDelegate?
    private var cancellation: Set<AnyCancellable> = []
    private var tableView = UITableView()
    private var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        SetUpTable()
        quizCategoriesViewModel.view = self.view
        quizCategoriesViewModel.$categories.sink { [weak self] category in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }.store(in: &cancellation)
        self.quizCategoriesViewModel.ShowLoading()
    }
    
    @objc func refresh() {
        DispatchQueue.main.async {
            self.quizCategoriesViewModel.categories = []
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
        quizCategoriesViewModel.ShowLoading()
    }
    
    func SetUpTable() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.register(UINib(nibName: QuizCategoriesTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: QuizCategoriesTableViewCell.identifier)
    }
    
    func didElementClick() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.performSegue(withIdentifier: "showCategoryDetail", sender: nil)
        }
    }
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return quizCategoriesViewModel.categories.count
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizCategoriesViewModel.categories[section].categories.count
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        player.PlaySound(resource: quizCategoriesViewModel.categories[indexPath.section].categories[indexPath.row].sound)
        
        if let cell = tableView.cellForRow(at: indexPath) as? QuizCategoriesTableViewCell {
            cell.didSelect(indexPath: indexPath)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCategoryDetail",
           let destinationController = segue.destination as? QuizCategoryDetailViewController,
           let indexSelectedCell = tableView.indexPathForSelectedRow {
            let category = quizCategoriesViewModel.categories[indexSelectedCell.section].categories[indexSelectedCell.row]
            destinationController.category = category
        }
    }
    
     func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.contentView.backgroundColor = .black
            headerView.textLabel?.textColor = .white
        }
    }
        
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        let lbl = UILabel(frame: CGRect(x: 15, y: 0, width: view.frame.width - 15, height: 40))
        lbl.font = UIFont.systemFont(ofSize: 25)
        lbl.text = quizCategoriesViewModel.categories[section].releaseDate
        view.addSubview(lbl)
        return view
    }
    
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QuizCategoriesTableViewCell.identifier, for: indexPath) as! QuizCategoriesTableViewCell
        cell.delegate = self
        cell.ConfigureCell(category: quizCategoriesViewModel.categories[indexPath.section].categories[indexPath.row])
        return cell
    }
}
