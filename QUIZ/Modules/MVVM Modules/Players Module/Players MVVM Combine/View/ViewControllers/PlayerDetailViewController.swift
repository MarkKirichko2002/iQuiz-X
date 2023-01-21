//
//  PlayerDetailViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 06.12.2022.
//

import UIKit
import SnapKit
import SDWebImage
import Combine

final class PlayerDetailViewController: UIViewController {
    
    private let PlayerImage = RoundedImageView()
    private let PlayerName = UILabel()
    private let PlayerEmail = UILabel()
    private let PlayerScore = UILabel()
    private let table = UITableView()
    private let playersViewModel = PlayersViewModel()
    private let animation = AnimationClass()
    private var cancellation: Set<AnyCancellable> = []
    var player: Player?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playersViewModel.player = player
        table.delegate = self
        table.dataSource = self
        table.register(UINib(nibName: QuizCategoriesTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: QuizCategoriesTableViewCell.identifier)
        playersViewModel.$categories.sink {[weak self] _ in
            DispatchQueue.main.async {
                self?.table.reloadData()
            }
        }.store(in: &cancellation)
        playersViewModel.LoadResults()
        SetUpView()
        SetUpConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        playersViewModel.PlayCurrentCategoryMusic()
    }
    
    private func SetUpView() {
        view.backgroundColor = UIColor(patternImage: UIImage(named: player?.background ?? "")!)
        PlayerImage.sd_setImage(with: URL(string: player?.image ?? ""))
        PlayerImage.color = .white
        PlayerImage.clipsToBounds = true
        PlayerImage.sound = player?.sound ?? ""
        PlayerName.text = player?.name ?? ""
        PlayerName.textColor = .white
        PlayerName.font = UIFont.boldSystemFont(ofSize: 18.0)
        PlayerEmail.text = player?.email ?? ""
        PlayerEmail.textColor = .white
        PlayerEmail.font = UIFont.boldSystemFont(ofSize: 18.0)
        PlayerScore.numberOfLines = 0
        PlayerScore.text = "\(player?.counter ?? 0)/100 (\(player?.category ?? ""))"
        PlayerScore.textColor = .white
        PlayerScore.font = UIFont.boldSystemFont(ofSize: 18.0)
        view.addSubviews(PlayerImage, PlayerName, PlayerEmail, PlayerScore, table)
    }
    
    private func SetUpConstraints() {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: QuizCategoriesTableViewCell.identifier, for: indexPath) as! QuizCategoriesTableViewCell
        if player!.category == playersViewModel.categories[indexPath.row].name {
            self.animation.StartRotateImage(image: cell.CategoryImage)
        }
        cell.CategoryImage.isUserInteractionEnabled = false
        cell.ConfigureCell(category: playersViewModel.categories[indexPath.row])
        return cell
    }

}
