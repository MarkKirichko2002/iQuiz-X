//
//  PlayerDetailViewViewModel + Extensions.swift
//  QUIZ
//
//  Created by Марк Киричко on 24.06.2023.
//

import UIKit

// MARK: - UITableViewDataSource
extension PlayerDetailViewViewModel: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return categories.count
        case 3:
            return tasks.count
        default:
            return 0
        }
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
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: QuizTasksTableViewCell.identifier, for: indexPath) as? QuizTasksTableViewCell else {
                fatalError("Unsupported cell")
            }
            cell.TaskImage.isUserInteractionEnabled = false
            cell.ConfigureCell(task: tasks[indexPath.row])
            return cell
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - UITableViewDelegate
extension PlayerDetailViewViewModel: UITableViewDelegate {
    
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
        case 3:
            lbl.text = "Задания"
        default:
            lbl.text = ""
        }
        view.addSubview(lbl)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       return 40
   }
}
