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
    private var players = [Player]()
    
    // MARK: - сервисы
    private let firebaseManager: FirebaseManagerProtocol?
    private let audioPlayer: SoundClassProtocol?
    
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

extension PlayersListViewViewModel: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        audioPlayer?.PlaySound(resource: players[indexPath.row].sound)
        
        if let cell = tableView.cellForRow(at: indexPath) as? PlayerTableViewCell {
            cell.didSelect(indexPath: indexPath)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.delegate?.playerWasSelected(player: self.players[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlayerTableViewCell.identifier, for: indexPath) as? PlayerTableViewCell else {
            fatalError("Unsupported cell")
        }
        cell.configure(players: players[indexPath.row])
        return cell
    }
}
