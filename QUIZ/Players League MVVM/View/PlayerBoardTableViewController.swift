//
//  PlayerBoardTableViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 25.02.2022.
//

import UIKit
import FirebaseFirestore
import SCLAlertView

class PlayerBoardTableViewController: UITableViewController {
    
    @IBOutlet var SortButton: UIBarButtonItem!
    
    var players = PlayerViewModel()
    var player = SoundClass()
    var cellmodel = PlayerTableViewCellModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        players.loadData(tableView: tableView)
        navigationItem.title = "Лига Игроков 🏆"
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.reloadData()
    }
    
    @IBAction func sort() {
        player.Sound(resource: "future click sound.wav")
        players.SortTable(tableView: tableView)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Количество игроков: \(players.playersArray.count)")
        return players.playersArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlayerTableViewCell.identifier, for: indexPath) as! PlayerTableViewCell
        
        let player = players.playersArray[indexPath.row]
    
        print(player.name)
        
        cellmodel.loadData(player: player, PlayerImage: cell.PlayerImage, UserName: cell.UserName, UserEmail: cell.UserEmail, PlayerBestScore: cell.PlayerBestScore, view: cell)
        
        return cell
    }
    
}

