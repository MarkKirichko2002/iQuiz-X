//
//  PlayerDetailView.swift
//  QUIZ
//
//  Created by Марк Киричко on 15.05.2023.
//

import UIKit

class PlayerDetailView: UIView {
    
    private var viewModel: PlayerDetailViewViewModel?
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UINib(nibName: PlayerInfoTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: PlayerInfoTableViewCell.identifier)
        tableView.register(UINib(nibName: QuizCategoriesTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: QuizCategoriesTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    init(frame: CGRect, viewModel: PlayerDetailViewViewModel?) {
        super.init(frame: frame)
        self.viewModel = viewModel
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableView)
        SetUpConstraints()
        SetUpTable()
        viewModel?.GetPlayerInfo()
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

extension PlayerDetailView: PlayerDetailViewViewModelDelegate {
    
    func PlayerInfoWasLoaded() {
        tableView.reloadData()
    }
}
