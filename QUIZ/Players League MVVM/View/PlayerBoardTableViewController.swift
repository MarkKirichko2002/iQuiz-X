//
//  PlayerBoardTableViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 25.02.2022.
//

import UIKit
import FirebaseFirestore
import SDWebImage

class PlayerBoardTableViewController: UITableViewController {
    
    var db = Firestore.firestore()
    
    @IBOutlet var SortButton: UIBarButtonItem!
    
    var playersViewModel = PlayersListViewModel()
    
    var playersArray = [Player]()
    
    var player = SoundClass()
    var sorted = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playersViewModel.players.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        loadData()
    }
    

    @IBAction func sort() {
        player.Sound(resource: "future click sound.wav")
        SortTable()
    }
    
    
    func SortTable() {
        player.Sound(resource: "future click sound.wav")
        if sorted == true {
            self.playersViewModel.players.value?.sort(by: { $0.counter > $1.counter })
            sorted = false
            tableView.reloadData()
            print(sorted)
        } else if sorted == false {
            self.playersViewModel.players.value?.sort(by: { $0.counter < $1.counter })
            sorted = true
            tableView.reloadData()
            print(sorted)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playersViewModel.players.value?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlayerTableViewCell.identifier, for: indexPath) as! PlayerTableViewCell
        
        cell.PlayerImage.sd_setImage(with: URL(string: playersViewModel.players.value?[indexPath.row].image ?? ""))
        cell.UserName.text = playersViewModel.players.value?[indexPath.row].name ?? ""
        cell.UserName.textColor = UIColor.white
        cell.UserEmail.text = playersViewModel.players.value?[indexPath.row].email ?? ""
        cell.UserEmail.textColor = UIColor.white
        cell.PlayerBestScore.text = "\(playersViewModel.players.value?[indexPath.row].counter ?? 0)/100 (\(playersViewModel.players.value?[indexPath.row].category ?? ""))"
        cell.PlayerBestScore.textColor = UIColor.white
        cell.backgroundColor = UIColor(patternImage: UIImage(named: playersViewModel.players.value?[indexPath.row].background ?? "")!)
        
        return cell
    }
    
    
    func loadData() {
        db.collection("users").getDocuments() { (QuerySnapshot, err) in
            if let err = err {
                print("Error getting documents : \(err)")
            } else {
                for document in QuerySnapshot!.documents {
                    let name = document.get("name") as? String
                    let email = document.get("email") as? String
                    let photo = document.get("image") as? String
                    
                    if let category = document["lastquiz"] as? [String: Any] {
                        let CorrectAnswersCounter = category["CorrectAnswersCounter"] as? Int
                        let background = category["background"] as? String
                        let bestscore = category["bestscore"] as? Int ?? 0
                        let category = category["category"] as? String ?? ""
                        
                        self.playersArray.append(Player(name: name ?? "", counter: bestscore , email: email ?? "", CorrectAnswersCounter: CorrectAnswersCounter ?? 0, category: category , image: photo ?? "", background: background ?? ""))
                        
                        self.playersViewModel.players.value = self.playersArray.compactMap({
                            PlayersTableViewCellViewModel(name: $0.name , counter: $0.counter , email: $0.email, CorrectAnswersCounter: $0.CorrectAnswersCounter, category: $0.category , image: $0.image, background: $0.background)
                        })
                    }
                    self.playersViewModel.players.value?.sort(by: { $0.counter > $1.counter })
                    
                }
                self.tableView.reloadData()
            }
        }
    }
}

