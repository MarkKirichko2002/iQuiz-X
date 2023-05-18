//
//  PlayerDetailViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 16.05.2023.
//

import UIKit
import Swinject

class PlayerDetailViewController: UIViewController {

    private var player: Player
    
    init(player: Player) {
        self.player = player
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
    
    private func setUpDependencies()->Container {
        let container = Container()
        // Firebase
        container.register(FirebaseManagerProtocol.self) { resolver in
            return FirebaseManager()
        }
        // ViewModel
        container.register(PlayerDetailViewViewModel.self) { resolver in
            let viewModel = PlayerDetailViewViewModel(fireBaseManager: resolver.resolve(FirebaseManagerProtocol.self), player: self.player)
            return viewModel
        }
        return container
    }
    
    private func makeConstraints() {
        let playerDetailView = PlayerDetailView(frame: .zero, viewModel: setUpDependencies().resolve(PlayerDetailViewViewModel.self))
        view.addSubview(playerDetailView)
        NSLayoutConstraint.activate([
            playerDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            playerDetailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            playerDetailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            playerDetailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
