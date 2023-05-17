//
//  PlayersListViewViewModel.swift
//  QUIZ
//
//  Created by Марк Киричко on 15.05.2023.
//

import UIKit
import Combine

protocol PlayersListViewViewModelDelegate: AnyObject {
    func playersLoaded()
    func playerWasSelected(player: Player)
}

class PlayersListViewViewModel: NSObject {
    
    public weak var delegate: PlayersListViewViewModelDelegate?
    private var players = [Player]()
    
    // MARK: - сервисы
    private let firebaseManager = FirebaseManager()
    private let audioPlayer = SoundClass()
    
    func GetPlayers() {
        firebaseManager.LoadPlayers { players in
            DispatchQueue.main.async {
                self.players = players
                self.delegate?.playersLoaded()
            }
        }
    }
}

extension PlayersListViewViewModel: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        audioPlayer.PlaySound(resource: players[indexPath.row].sound)
        
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
