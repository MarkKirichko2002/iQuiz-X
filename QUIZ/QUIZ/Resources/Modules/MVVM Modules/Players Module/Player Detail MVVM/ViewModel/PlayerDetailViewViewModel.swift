//
//  PlayerDetailViewViewModel.swift
//  QUIZ
//
//  Created by Марк Киричко on 15.05.2023.
//

import UIKit

protocol PlayerDetailViewViewModelDelegate: AnyObject {
    func PlayerInfoWasLoaded()
}

class PlayerDetailViewViewModel: NSObject {
    
    public weak var delegate: PlayerDetailViewViewModelDelegate?
    private var player: Player
    private var categories = QuizCategories.categories
    
    // MARK: - сервисы
    private let fireBaseManager: FirebaseManagerProtocol?
    
    // MARK: - Init
    init(fireBaseManager: FirebaseManagerProtocol?, player: Player) {
        self.fireBaseManager = fireBaseManager
        self.player = player
    }
    
    func GetPlayerInfo() {
        let fireBaseManager = FirebaseManager()
        fireBaseManager.email = player.email
        for category in categories {
            fireBaseManager.LoadQuizCategoriesData(quizpath: category.quizpath) { result in
                self.categories[category.id - 1].score = result.score
                self.categories[category.id - 1].complete = result.complete
                self.delegate?.PlayerInfoWasLoaded()
            }
        }
    }
}

extension PlayerDetailViewViewModel: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return categories.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        let lbl = UILabel(frame: CGRect(x: 15, y: 0, width: view.frame.width - 15, height: 40))
        lbl.font = UIFont.systemFont(ofSize: 25)
        switch section {
        case 0:
            lbl.text = "Профиль"
        case 1:
            lbl.text = "Последняя Викторина"
        case 2:
            lbl.text = "Категории"
        default:
            lbl.text = ""
        }
        view.addSubview(lbl)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       return 40
   }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
            
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PlayerInfoTableViewCell.identifier, for: indexPath) as? PlayerInfoTableViewCell else {
                fatalError("Unsupported cell")
            }
            cell.configure(player: player)
            return cell
            
        case 1:
            let animation = AnimationClass()
            guard let cell = tableView.dequeueReusableCell(withIdentifier: QuizCategoriesTableViewCell.identifier, for: indexPath) as? QuizCategoriesTableViewCell else {
                fatalError("Unsupported cell")
            }
            // иконка
            cell.CategoryImage.image = UIImage(named: player.categoryIcon)
            cell.CategoryImage.sound = player.sound
            cell.CategoryImage.color = .white
            animation.StartRotateAnimation(view: cell.CategoryImage)
            cell.CategoryImage.isUserInteractionEnabled = false
            // название категории
            cell.CategoryText.text = player.category
            // статус пройдено
            cell.isComplete.text = "пройдено"
            // счет категории
            cell.CategoryScore.text = "\(player.counter)/100 баллов"
            // фон
            cell.contentView.backgroundColor = UIColor(patternImage: UIImage(named: player.background)!)
            return cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: QuizCategoriesTableViewCell.identifier, for: indexPath) as? QuizCategoriesTableViewCell else {
                fatalError("Unsupported cell")
            }
            cell.CategoryImage.isUserInteractionEnabled = false
            cell.ConfigureCell(category: categories[indexPath.row])
            return cell
        default:
            return UITableViewCell()
        }
    }
}
