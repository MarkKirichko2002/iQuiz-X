//
//  QuizStatisticTableViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 15.03.2022.
//

import UIKit
import Combine

final class QuizStatisticTableViewController: UITableViewController {
    
    private let quizCategoriesViewModel = QuizCategoriesViewModel()
    private var cancellation: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: QuizCategoriesTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: QuizCategoriesTableViewCell.identifier)
        quizCategoriesViewModel.$quizcategories.sink { [weak self] category in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }.store(in: &cancellation)
        self.quizCategoriesViewModel.LoadCategoriesResults()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizCategoriesViewModel.quizcategories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QuizCategoriesTableViewCell.identifier, for: indexPath) as! QuizCategoriesTableViewCell
        cell.ConfigureCell(category: quizCategoriesViewModel.quizcategories[indexPath.row])
        return cell
    }
}
