//
//  QuizResultsViewModel.swift
//  QUIZ
//
//  Created by Марк Киричко on 10.10.2022.
//

import Firebase
import RxSwift
import RxCocoa

class QuizResultsViewModel {
    
    var quizresult = PublishSubject<QuizResult>()
    var category: QuizCategoryModel?
    let quizCategoriesViewModel = QuizCategoriesViewModel()
    private let firebaseManager = FirebaseManager()
    private let db = Firestore.firestore()
    
    // View
    var storyboard: UIStoryboard?
    var view: UIView?
    
    func SetupView(view: UIView, storyboard: UIStoryboard) {
        self.view = view
        self.storyboard = storyboard
    }
    
    func GetQuizResult() {
        quizCategoriesViewModel.CreateCategories()
        firebaseManager.LoadLastQuizCategoryData { result in
            self.quizresult.onNext(result)
        }
    }
    
    // перезапустить викторину
    func restartGame() {
        DispatchQueue.main.async {
            
            let docRef = self.db.collection("users").document((Auth.auth().currentUser?.email)!)
            
            docRef.getDocument { [self] document, error in
                if let error = error as NSError? {
                    print("Error getting document: \(error.localizedDescription)")
                } else {
                    if let document = document {
                        if let category = document["lastquiz"] as? [String: Any] {
                            let category = category["category"] as? String ?? ""
                            
                            for i in self.quizCategoriesViewModel.quizcategories {
                                if category == i.name {
                                    self.quizCategoriesViewModel.GoToQuiz(quiz: i.base, category: i)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    // переход к экрану с категориями
    func PresentCategoryScreen() {
        DispatchQueue.main.async {
            guard let vc = self.storyboard?.instantiateViewController(identifier: "QuizTabBarController") else {return}
            guard let window = self.view?.window else {return}
            window.rootViewController = vc
        }
    }
}
