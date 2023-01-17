//
//  DailyQuizViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 06.01.2023.
//

import Foundation
import UIKit

final class DailyQuizViewController: UIViewController {
    
    var category: QuizCategoryModel?
    private let dateManager = DateManager()
    private let quizCategoriesViewModel = QuizCategoriesViewModel()
    
    @IBOutlet weak var DailyQuizCategoryIcon: RoundedImageView!
    @IBOutlet weak var DailyQuizCategoryName: UILabel!
    @IBOutlet weak var CurrentDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.quizCategoriesViewModel.view = self.view
        self.quizCategoriesViewModel.storyboard = self.storyboard
        if let category = self.category {
            view.backgroundColor = UIColor(patternImage: UIImage(named: category.background)!)
            DailyQuizCategoryIcon.image = UIImage(named: category.image)
            DailyQuizCategoryIcon.sound = category.sound
            DailyQuizCategoryIcon.color = UIColor.white
            DailyQuizCategoryName.text = category.name
            DailyQuizCategoryName.textColor = UIColor.white
            CurrentDateLabel.text = "сегодня: \(dateManager.GetCurrentDate())"
            CurrentDateLabel.textColor = UIColor.white
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.quizCategoriesViewModel.GoToQuiz(quiz: category.base, category: category)
            }
        }
    }
}
