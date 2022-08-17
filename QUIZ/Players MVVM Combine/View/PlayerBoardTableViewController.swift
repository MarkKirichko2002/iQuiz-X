//
//  PlayerBoardTableViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 25.02.2022.
//

import UIKit
import SDWebImage
import Combine

class PlayerBoardTableViewController: UITableViewController {
    
    @IBOutlet var SortButton: UIBarButtonItem!
    
    var playersViewModel = PlayersViewModel()
    var cancellation: Set<AnyCancellable> = []
    var player = SoundClass()
    var sorted = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playersViewModel.$players.sink { [weak self] players in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }.store(in: &cancellation)
        self.playersViewModel.GetPlayers()
    }
    

    @IBAction func sort() {
        player.Sound(resource: "future click sound.wav")
        SortTable()
    }
    
    
    func SortTable() {
        player.Sound(resource: "future click sound.wav")
        if sorted == true {
            self.playersViewModel.players.sort(by: { $0.counter > $1.counter })
            sorted = false
            tableView.reloadData()
            print(sorted)
        } else if sorted == false {
            self.playersViewModel.players.sort(by: { $0.counter < $1.counter })
            sorted = true
            tableView.reloadData()
            print(sorted)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playersViewModel.players.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlayerTableViewCell.identifier, for: indexPath) as! PlayerTableViewCell
        
        cell.configure(players: playersViewModel.players[indexPath.row])
        
        return cell
    }
}

