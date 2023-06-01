//
//  QuizCategoriesViewModel.swift
//  QUIZ
//
//  Created by Марк Киричко on 02.07.2022.
//

import UIKit
import Combine
import SnapKit

class QuizCategoriesViewModel {
    
    private let firebaseManager = FirebaseManager()
    private let spinner = RoundedImageView()
    private let loadingText = UILabel()
    private let animation = AnimationClass()
    private let textRecognitionManager = TextRecognitionManager()
    var view: UIView?
    var storyboard: UIStoryboard?
    
    @Published var quizcategories = QuizCategories.categories
    
    func ShowLoading() {
        spinner.image = UIImage(named: "astronomy.png")
        view?.addSubview(spinner)
        loadingText.text = "загрузка результатов..."
        loadingText.font = UIFont.boldSystemFont(ofSize: 22.0)
        view?.addSubview(loadingText)
        makeConstraints()
        animation.StartRotateAnimation(view: spinner)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.LoadCategoriesResults()
            self.spinner.removeFromSuperview()
            self.loadingText.removeFromSuperview()
        }
    }
    
    private func makeConstraints() {
        spinner.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(250)
            make.height.equalTo(150)
            make.width.equalTo(150)
        }
        
        loadingText.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(spinner.snp.bottom).offset(20)
            make.height.equalTo(60)
            make.width.equalTo(250)
        }
    }
    
    func LoadCategoriesResults() {
        for category in quizcategories {
            configure(category)
        }
    }
    
    func configure(_ category: QuizCategoryModel)  {
        firebaseManager.LoadQuizCategoriesData(quizpath: category.quizpath) { result in
            self.quizcategories[category.id - 1].score = result.score
            self.quizcategories[category.id - 1].complete = result.complete
        }
    }
    
    func GoToQuiz(quiz: QuizBaseViewModel, category: QuizCategoryModel) {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "QuizBaseViewController", bundle: nil)
            guard let vc = storyboard.instantiateViewController(identifier: "QuizBaseViewController") as? QuizBaseViewController else {return}
            vc.quiz = quiz
            vc.category = category
            guard let window = self.view?.window else {return}
            window.rootViewController = vc
        }
    }
    
    func GoToStart(quiz: QuizBaseViewModel, category: QuizCategoryModel) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let vc = QuizStartViewController()
            vc.category = category
            guard let window = self.view?.window else {return}
            window.rootViewController = vc
        }
    }
    
    func PresentRandomQuiz() {
        DispatchQueue.main.async {
            let randomquizindex = Int.random(in: 0..<self.quizcategories.count)
            let randomquiz = self.quizcategories[randomquizindex]
            self.GoToStart(quiz: randomquiz.base, category: randomquiz)
        }
    }
    
    func CheckText(image: UIImage) {
        textRecognitionManager.recognizeText(image: image) { text in
            for category in self.quizcategories {
                if text.lowercased().contains(category.name) {
                    self.GoToStart(quiz: category.base, category: category)
                }
            }
        }
    }
}
