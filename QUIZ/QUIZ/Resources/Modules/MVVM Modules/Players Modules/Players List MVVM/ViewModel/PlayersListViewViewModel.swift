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
    
    func GetPlayers() {
        FirebaseManager().LoadPlayers { players in
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
        delegate?.playerWasSelected(player: players[indexPath.row])
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlayerTableViewCell.identifier, for: indexPath) as? PlayerTableViewCell else {
            fatalError("Unsupported cell")
        }
        cell.configure(players: players[indexPath.row])
        return cell
    }
}
