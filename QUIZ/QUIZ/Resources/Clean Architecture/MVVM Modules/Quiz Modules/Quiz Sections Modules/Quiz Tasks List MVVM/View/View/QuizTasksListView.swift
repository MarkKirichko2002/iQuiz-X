//
//  QuizTasksListView.swift
//  QUIZ
//
//  Created by Марк Киричко on 16.05.2023.
//

import UIKit

protocol QuizTasksListViewDelegate: AnyObject {
    func ShowCurrentQuizTask(task: QuizTaskModel)
}

class QuizTasksListView: UIView {
    
    public weak var delegate: QuizTasksListViewDelegate?
    private var viewModel: QuizTasksListViewViewModel?
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UINib(nibName: QuizTasksTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: QuizTasksTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Init
    init(frame: CGRect, viewModel: QuizTasksListViewViewModel?) {
        super.init(frame: frame)
        self.viewModel = viewModel
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableView)
        SetUpConstraints()
        SetUpTable()
        self.viewModel?.LoadTasksResults()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func SetUpConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func SetUpTable() {
        tableView.dataSource = viewModel
        tableView.delegate = viewModel
        viewModel?.delegate = self
    }
}
