//
//  QuizCategoriesViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 23.01.2023.
//

import UIKit

class QuizCategoriesViewController: UIViewController {
    
    private let quizCategoriesListView = QuizCategoriesListView()
    private var category: QuizCategoryModel?
    private let player = SoundClass()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpView()
    }
    
    private func SetUpView() {
        view.addSubview(quizCategoriesListView)
        quizCategoriesListView.delegate = self
        NSLayoutConstraint.activate([
            quizCategoriesListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            quizCategoriesListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            quizCategoriesListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            quizCategoriesListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}

extension QuizCategoriesViewController: QuizCategoriesListViewDelegate {
    
    func ShowDetailCategoryScreen(view: UIView, category: QuizCategoryModel) {
        player.PlaySound(resource: category.sound)
        self.category = category
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.performSegue(withIdentifier: "showCategoryDetail", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if (segue.identifier == "showCategoryDetail") {
          let secondView = segue.destination as! QuizCategoryDetailViewController
          secondView.category = category
       }
    }
    
}
