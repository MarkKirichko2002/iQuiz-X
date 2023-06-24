//
//  QuizCategoriesTableViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 26.02.2022.
//

import UIKit
import Combine

final class QuizCategoriesTableViewController: UIViewController {
    
    let quizCategoriesViewModel = QuizCategoriesViewModel()
    let player = SoundClass()
    let tableView = UITableView()
    private var delegate: CustomViewCellDelegate?
    private var cancellation: Set<AnyCancellable> = []
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        SetUpTable()
        quizCategoriesViewModel.view = self.view
        quizCategoriesViewModel.$quizcategories.sink { [weak self] category in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }.store(in: &cancellation)
        self.quizCategoriesViewModel.ShowLoading()
    }
    
    @objc func refresh() {
        DispatchQueue.main.async {
            self.quizCategoriesViewModel.quizcategories = []
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
}
