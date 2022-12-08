//
//  PlayerDetailViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 06.12.2022.
//

import Foundation
import UIKit
import SnapKit
import SDWebImage

class PlayerDetailViewController: UIViewController {
    
    var PlayerImage = RoundedImageView()
    var PlayerName = UILabel()
    var PlayerEmail = UILabel()
    var PlayerScore = UILabel()
    var table = UITableView()
    var playersViewModel = PlayersViewModel()
    var player: Player?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playersViewModel.player = player
        table.delegate = self
        table.dataSource = self
        table.register(UINib(nibName: CategoryTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CategoryTableViewCell.identifier)
        SetUpView()
        SetUpConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        playersViewModel.PlayCurrentCategoryMusic()
    }
    
    func SetUpView() {
        view.backgroundColor = UIColor(patternImage: UIImage(named: player?.background ?? "")!)
        PlayerImage.sd_setImage(with: URL(string: player?.image ?? ""))
        PlayerImage.color = .white
        PlayerImage.clipsToBounds = true
        PlayerImage.sound = player?.sound ?? ""
        view.addSubview(PlayerImage)
        PlayerName.text = player?.name ?? ""
        PlayerName.textColor = .white
        PlayerName.font = UIFont.boldSystemFont(ofSize: 18.0)
        view.addSubview(PlayerName)
        PlayerEmail.text = player?.email ?? ""
        PlayerEmail.textColor = .white
        PlayerEmail.font = UIFont.boldSystemFont(ofSize: 18.0)
        view.addSubview(PlayerEmail)
        PlayerScore.text = "\(player?.counter ?? 0)/100 (\(player?.category ?? ""))"
        PlayerScore.textColor = .white
        PlayerScore.font = UIFont.boldSystemFont(ofSize: 18.0)
        view.addSubview(PlayerScore)
        view.addSubview(table)
    }
    
    func SetUpConstraints() {
        PlayerImage.snp.makeConstraints { maker in
            maker.left.equalToSuperview().inset(50)
            maker.top.equalToSuperview().inset(100)
            maker.height.equalTo(100)
            maker.width.equalTo(100)
            
            PlayerName.snp.makeConstraints { maker in
                maker.left.equalTo(PlayerImage).inset(120)
                maker.top.equalToSuperview().inset(60)
                maker.height.equalTo(100)
                maker.width.equalTo(200)
            }
            
            PlayerEmail.snp.makeConstraints { maker in
                maker.left.equalTo(PlayerImage).inset(120)
                maker.top.equalTo(PlayerName).inset(40)
                maker.height.equalTo(100)
                maker.width.equalTo(200)
            }
            
            PlayerScore.snp.makeConstraints { maker in
                maker.left.equalTo(PlayerImage).inset(120)
                maker.top.equalTo(PlayerEmail).inset(40)
                maker.height.equalTo(100)
                maker.width.equalTo(200)
            }
            
            table.snp.makeConstraints { maker in
                maker.top.equalTo(PlayerScore).inset(80)
                maker.height.equalToSuperview().inset(110)
                maker.width.equalToSuperview()
            }
        }
    }
}

extension PlayerDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playersViewModel.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier, for: indexPath) as! CategoryTableViewCell
        playersViewModel.configure(playersViewModel.categories[indexPath.row], CategoryImage: cell.CategoryImage, CategoryText: cell.CategoryText, isComplete: cell.isComplete, CategoryScore: cell.CategoryScore, background: cell)
        cell.CategoryImage.sound = playersViewModel.categories[indexPath.row].sound
        cell.CategoryImage.color = .white
        return cell
    }

}
