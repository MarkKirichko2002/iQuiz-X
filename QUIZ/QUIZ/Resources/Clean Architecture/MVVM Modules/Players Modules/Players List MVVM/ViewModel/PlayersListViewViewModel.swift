//
//  PlayersListViewViewModel.swift
//  QUIZ
//
//  Created by Марк Киричко on 15.05.2023.
//

import UIKit

protocol PlayersListViewViewModelDelegate: AnyObject {
    func playersLoaded()
    func playerWasSelected(player: Player)
}

class PlayersListViewViewModel: NSObject {
    
    public weak var delegate: PlayersListViewViewModelDelegate?
    var players = [Player]()
    
    // MARK: - сервисы
    private let firebaseManager: FirebaseManagerProtocol?
    let audioPlayer: SoundClassProtocol?
    
    // MARK: - Init
    init(firebaseManager: FirebaseManagerProtocol?, audioPlayer: SoundClassProtocol?) {
        self.firebaseManager = firebaseManager
        self.audioPlayer = audioPlayer
    }
    
    func GetPlayers() {
        firebaseManager?.LoadPlayers { players in
            DispatchQueue.main.async {
                self.players = players
                self.delegate?.playersLoaded()
            }
        }
    }
    
    func ObservePlayers() {
        firebaseManager?.ObservePlayers(block: {
            DispatchQueue.main.async {
                self.GetPlayers()
            }
        })
    }
}
