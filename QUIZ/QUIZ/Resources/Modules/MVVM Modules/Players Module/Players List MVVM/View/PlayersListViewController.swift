//
//  PlayersListViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 15.05.2023.
//

import UIKit

class PlayersListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        makeConstraints()
    }
    
    private func makeConstraints() {
        let viewModel = PlayersListViewViewModel()
        let playersListView = PlayersListView(frame: .zero, viewModel: viewModel)
        view.addSubview(playersListView)
        NSLayoutConstraint.activate([
            playersListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            playersListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            playersListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            playersListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
