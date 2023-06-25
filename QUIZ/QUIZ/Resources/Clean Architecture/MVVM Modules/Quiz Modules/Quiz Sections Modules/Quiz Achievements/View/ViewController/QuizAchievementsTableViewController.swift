//
//  QuizAchievementsTableViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 26.03.2023.
//

import UIKit

class QuizAchievementsTableViewController: UITableViewController {
    
    let quizAchievementsViewModel = QuizAchievementsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quizAchievementsViewModel.delegate = self
        tableView.register(UINib(nibName: QuizAchievementsTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: QuizAchievementsTableViewCell.identifier)
        quizAchievementsViewModel.GetAchievementsData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizAchievementsViewModel.achievements.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: QuizAchievementsTableViewCell.identifier, for: indexPath) as? QuizAchievementsTableViewCell else {
            fatalError()
        }
        cell.configureCell(achievements: quizAchievementsViewModel.achievements[indexPath.row])
        return cell
    }
}
