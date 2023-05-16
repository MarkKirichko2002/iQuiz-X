//
//  PlayerDetailViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 16.05.2023.
//

import UIKit

class PlayerDetailViewController: UIViewController {

    private var playerDetailView: PlayerDetailView
    private var viewModel: PlayerDetailViewViewModel
    
    init(viewModel: PlayerDetailViewViewModel) {
        self.viewModel = viewModel
        self.playerDetailView = PlayerDetailView(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        makeConstraints()
    }
    
    private func makeConstraints() {
        view.addSubview(playerDetailView)
        NSLayoutConstraint.activate([
            playerDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            playerDetailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            playerDetailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            playerDetailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
