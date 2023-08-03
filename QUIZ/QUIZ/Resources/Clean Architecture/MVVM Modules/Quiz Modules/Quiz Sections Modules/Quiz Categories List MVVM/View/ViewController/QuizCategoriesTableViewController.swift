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
        SetUpRefreshControl()
        SetUpTable()
        BindViewModel()
    }
    
    private func SetUpRefreshControl() {
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    @objc private func refresh() {
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
    
    func BindViewModel() {
        quizCategoriesViewModel.view = self.view
        quizCategoriesViewModel.$quizcategories.sink { [weak self] category in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }.store(in: &cancellation)
        self.quizCategoriesViewModel.ShowLoading()
    }
}
