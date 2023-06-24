//
//  QuizCategoriesTableViewController + Extensions.swift
//  QUIZ
//
//  Created by Марк Киричко on 24.06.2023.
//

import UIKit

// MARK: - UITableViewDataSource
extension QuizCategoriesTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizCategoriesViewModel.quizcategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QuizCategoriesTableViewCell.identifier, for: indexPath) as! QuizCategoriesTableViewCell
        cell.delegate = self
        cell.ConfigureCell(category: quizCategoriesViewModel.quizcategories[indexPath.row])
        return cell
    }
}

// MARK: -  UITableViewDelegate
extension QuizCategoriesTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        player.PlaySound(resource: quizCategoriesViewModel.quizcategories[indexPath.row].sound)
        
        NotificationCenter.default.post(name: Notification.Name("quizCategorySelected"), object: quizCategoriesViewModel.quizcategories[indexPath.row])
        
        if let cell = tableView.cellForRow(at: indexPath) as? QuizCategoriesTableViewCell {
            cell.didSelect(indexPath: indexPath)
        }
    }
}

// MARK: - CustomViewCellDelegate
extension QuizCategoriesTableViewController: CustomViewCellDelegate {
    
    func didElementClick() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.performSegue(withIdentifier: "showCategoryDetail", sender: nil)
        }
    }
}

extension QuizCategoriesTableViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCategoryDetail",
           let destinationController = segue.destination as? QuizCategoryDetailViewController,
           let indexSelectedCell = tableView.indexPathForSelectedRow {
            let category = quizCategoriesViewModel.quizcategories[indexSelectedCell.row]
            destinationController.category = category
        }
    }
}
