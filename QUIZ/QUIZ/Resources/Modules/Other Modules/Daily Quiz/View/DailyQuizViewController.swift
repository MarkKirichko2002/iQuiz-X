//
//  DailyQuizViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 06.01.2023.
//

import UIKit

final class DailyQuizViewController: UIViewController {
    
    var category: QuizCategoryModel?
    private let dateManager = DateManager()
    private let quizCategoriesViewModel = QuizCategoriesViewModel()
    
    private let DailyQuizCategoryIcon: RoundedImageView = {
        let icon = RoundedImageView()
        icon.color = UIColor.white
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    private let DailyQuizCategoryName: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = .systemFont(ofSize: 28, weight: .black)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let CurrentDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = .systemFont(ofSize: 28, weight: .black)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews(DailyQuizCategoryIcon, DailyQuizCategoryName, CurrentDateLabel)
        self.quizCategoriesViewModel.view = self.view
        self.quizCategoriesViewModel.storyboard = self.storyboard
        SetUpConstraints()
        DisplayDailyCategory()
    }
    
    private func SetUpConstraints() {
        NSLayoutConstraint.activate([
            
            DailyQuizCategoryIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            DailyQuizCategoryIcon.widthAnchor.constraint(equalToConstant: 200),
            DailyQuizCategoryIcon.heightAnchor.constraint(equalToConstant: 200),
            
            DailyQuizCategoryName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            DailyQuizCategoryName.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            DailyQuizCategoryName.heightAnchor.constraint(equalToConstant: 30),
            DailyQuizCategoryName.topAnchor.constraint(equalTo: DailyQuizCategoryIcon.bottomAnchor, constant: 40),
            
            CurrentDateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            CurrentDateLabel.heightAnchor.constraint(equalToConstant: 30),
            CurrentDateLabel.topAnchor.constraint(equalTo: DailyQuizCategoryName.bottomAnchor, constant: 40)
        ])
    }
    
    private func DisplayDailyCategory() {
        if let category = self.category {
            view.backgroundColor = UIColor(patternImage: UIImage(named: category.background)!)
            DailyQuizCategoryIcon.image = UIImage(named: category.image)
            DailyQuizCategoryIcon.sound = category.sound
            DailyQuizCategoryName.text = category.name
            CurrentDateLabel.text = "сегодня: \(dateManager.GetCurrentDate())"
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.quizCategoriesViewModel.GoToQuiz(quiz: category.base, category: category)
            }
        }
    }
}
