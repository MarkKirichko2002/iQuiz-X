//
//  QuizSectionsTableViewController + Extensions.swift
//  QUIZ
//
//  Created by Марк Киричко on 24.06.2023.
//

import UIKit

// MARK: - UITableViewDataSource
extension QuizSectionsTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizSectionsViewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: QuizSectionsTableViewCell.identifier, for: indexPath) as? QuizSectionsTableViewCell else {return UITableViewCell()}
        cell.vc = self
        cell.configure(section: quizSectionsViewModel.sections[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension QuizSectionsTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        player.PlaySound(resource: quizSectionsViewModel.sections[indexPath.row].sound)
        
        if let cell = tableView.cellForRow(at: indexPath) as? QuizSectionsTableViewCell {
            cell.didSelect(indexPath: indexPath)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.GoToQuizSection(section: self.quizSectionsViewModel.sections[indexPath.row])
        }
    }
}


extension QuizSectionsTableViewController {
    
    private func GoToQuizSection(section: QuizSectionModel) {
        
        switch section.id {
            
        case 2:
            let storyboard = UIStoryboard(name: "QuizCategoriesTableViewController", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "QuizCategoriesTableViewController")
            vc.title = "Категории \(section.itemsCount)/19"
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 3:
            let storyboard = UIStoryboard(name: "QuizTasksListViewController", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "QuizTasksListViewController")
            vc.title = "Задания \(section.itemsCount)/19"
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 4:
            let vc = QuizAchievementsTableViewController()
            vc.title = "Достижения \(section.itemsCount)/1"
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 5:
            let vc = QuizWallpapersListViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            
        default:
            break
        }
    }
}
