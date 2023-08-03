//
//  QuizSectionsTableViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 18.01.2023.
//

import UIKit
import Combine

class QuizSectionsTableViewController: UIViewController {
    
    private var tableView = UITableView()
    private var cancellation: Set<AnyCancellable> = []
    let player = SoundClass()
    var quizSectionsViewModel = QuizSectionsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpNavigation()
        SetUpTable()
        BindViewModel()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func SetUpNavigation() {
        navigationItem.title = "Викторина"
    }
    
    private func SetUpTable() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: QuizSectionsTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: QuizSectionsTableViewCell.identifier)
    }
    
    private func BindViewModel() {
        quizSectionsViewModel.$sections.sink { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }.store(in: &cancellation)
        quizSectionsViewModel.GetQuizSectionData()
    }
}
