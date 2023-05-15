//
//  PlayersListView.swift
//  QUIZ
//
//  Created by Марк Киричко on 15.05.2023.
//

import UIKit

class PlayersListView: UIView {
    
    private var viewModel: PlayersListViewViewModel?
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UINib(nibName: PlayerTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: PlayerTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    init(frame: CGRect, viewModel: PlayersListViewViewModel?) {
        super.init(frame: frame)
        self.viewModel = viewModel
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableView)
        SetUpConstraints()
        SetUpTable()
        self.viewModel?.GetPlayers()
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

extension PlayersListView: PlayersListViewViewModelDelegate {
    
    func playersLoaded() {
        self.tableView.reloadData()
    }
}
