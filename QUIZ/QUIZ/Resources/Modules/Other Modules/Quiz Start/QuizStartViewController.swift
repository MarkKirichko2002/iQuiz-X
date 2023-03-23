//
//  QuizStartViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 11.08.2022.
//

import UIKit

final class QuizStartViewController: UIViewController {
    
    private let quizCategoriesViewModel = QuizCategoriesViewModel()
    var category: QuizCategoryModel?
    private var seconds = 6 {
        didSet {
            animation.SpringAnimation(view: TimerLabeL)
            TimerLabeL.text = ("\(seconds)")
        }
    }
    private let animation = AnimationClass()
    private var timer = Timer()
    
    // иконка категории
    private let QuizCategoryIcon: RoundedImageView = {
        let icon = RoundedImageView()
        icon.color = UIColor.white
        icon.borderWidth = 5
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    // название категории
    private let QuizCategoryName: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = .systemFont(ofSize: 25, weight: .black)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // вопрос
    private let QuestionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = .systemFont(ofSize: 25, weight: .black)
        label.text = "Вы готовы?"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // таймер
    private let TimerLabeL: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = .systemFont(ofSize: 25, weight: .black)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    @objc func time() {
        seconds -= 1
        
        if seconds == 0 {
            timer.invalidate()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews(QuizCategoryIcon, QuizCategoryName, QuestionLabel, TimerLabeL)
        quizCategoriesViewModel.view = self.view
        quizCategoriesViewModel.storyboard = self.storyboard
        SetUpConstraints()
        DisplayCurrentCategory()
    }
    
    private func SetUpConstraints() {
        NSLayoutConstraint.activate([
            // иконка
            QuizCategoryIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            QuizCategoryIcon.widthAnchor.constraint(equalToConstant: 150),
            QuizCategoryIcon.heightAnchor.constraint(equalToConstant: 150),
            // название категории
            QuizCategoryName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            QuizCategoryName.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            QuizCategoryName.heightAnchor.constraint(equalToConstant: 30),
            QuizCategoryName.topAnchor.constraint(equalTo: QuizCategoryIcon.bottomAnchor, constant: 50),
            // вопрос
            QuestionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            QuestionLabel.heightAnchor.constraint(equalToConstant: 30),
            QuestionLabel.topAnchor.constraint(equalTo: QuizCategoryName.bottomAnchor, constant: 50),
            // таймер
            TimerLabeL.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            TimerLabeL.heightAnchor.constraint(equalToConstant: 30),
            TimerLabeL.topAnchor.constraint(equalTo: QuestionLabel.bottomAnchor, constant: 50)
        ])
    }
    
    private func DisplayCurrentCategory() {
        if let category = self.category {
            view.backgroundColor = UIColor(patternImage: UIImage(named: category.background)!)
            QuizCategoryIcon.sound = category.sound
            QuizCategoryIcon.image = UIImage(named: category.image)
            QuizCategoryName.text = category.name
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(time), userInfo: nil, repeats: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                self.quizCategoriesViewModel.GoToQuiz(quiz: category.base, category: category)
            }
        }
    }
}
