//
//  PlayersListViewViewModel + Extensions.swift
//  QUIZ
//
//  Created by Марк Киричко on 24.06.2023.
//

import UIKit

// MARK: - UITableViewDataSource
extension PlayersListViewViewModel: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlayerTableViewCell.identifier, for: indexPath) as? PlayerTableViewCell else {
            fatalError("Unsupported cell")
        }
        cell.configure(players: players[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension PlayersListViewViewModel: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        audioPlayer?.PlaySound(resource: players[indexPath.row].sound)
        
        if let cell = tableView.cellForRow(at: indexPath) as? PlayerTableViewCell {
            cell.didSelect(indexPath: indexPath)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.delegate?.playerWasSelected(player: self.players[indexPath.row])
        }
    }
}
