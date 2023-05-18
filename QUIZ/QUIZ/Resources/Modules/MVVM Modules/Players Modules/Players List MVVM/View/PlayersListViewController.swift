//
//  PlayersListViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 15.05.2023.
//

import UIKit
import Swinject

class PlayersListViewController: UIViewController {
    
    private let container: Container = {
        let container = Container()
        // Firebase
        container.register(FirebaseManagerProtocol.self) { _ in
            return FirebaseManager()
        }
        // Audio
        container.register(SoundClassProtocol.self) { _ in
            return SoundClass()
        }
        // ViewModel
        container.register(PlayersListViewViewModel.self) { resolver in
            let viewModel = PlayersListViewViewModel(
                firebaseManager: resolver.resolve(FirebaseManagerProtocol.self),
                audioPlayer: resolver.resolve(SoundClassProtocol.self)
            )
            return viewModel
        }
        return container
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        makeConstraints()
    }
    
    private func makeConstraints() {
        let playersListView = PlayersListView(frame: .zero, viewModel: container.resolve(PlayersListViewViewModel.self))
        playersListView.delegate = self
        view.addSubview(playersListView)
        NSLayoutConstraint.activate([
            playersListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            playersListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            playersListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            playersListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension PlayersListViewController: PlayersListViewDelegate {
    
    func showCurrentPlayer(player: Player) {
        let vc = PlayerDetailViewController(player: player)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
