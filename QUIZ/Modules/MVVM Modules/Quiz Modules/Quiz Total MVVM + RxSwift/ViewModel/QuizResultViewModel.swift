//
//  QuizResultViewModel.swift
//  QUIZ
//
//  Created by Марк Киричко on 10.10.2022.
//

import Foundation
import Firebase
import RxSwift
import RxCocoa

class QuizResultViewModel {
    
    var quizresult = PublishSubject<QuizResult>()
    var viewModel = CategoriesViewModel()
    private var firebaseManager = FirebaseManager()
    private let db = Firestore.firestore()
    var category: QuizCategoryModel?
    
    // View
    var storyboard: UIStoryboard?
    var view: UIView?
    
    func SetupView(view: UIView, storyboard: UIStoryboard) {
        self.view = view
        self.storyboard = storyboard
    }
    
    func GetQuizResult() {
        viewModel.CreateCategories()
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
                }
                else {
                    if let document = document {
                        let data = document.data()
                        if let category = document["lastquiz"] as? [String: Any] {
                            let category = category["category"] as? String ?? ""
                            
                            switch category {
                                
                            case "астрономия":
                                self.viewModel.goToQuize(quiz: QuizPlanets(), category: viewModel.categories[0].categories[0])
                                
                            case "история":
                                self.viewModel.goToQuize(quiz: QuizHistory(), category: viewModel.categories[0].categories[1])
                                
                            case "анатомия":
                                self.viewModel.goToQuize(quiz: QuizAnatomy(), category: viewModel.categories[0].categories[2])
                                
                            case "спорт":
                                self.viewModel.goToQuize(quiz: QuizSport(), category: viewModel.categories[0].categories[3])
                                
                            case "игры":
                                self.viewModel.goToQuize(quiz: QuizGames(), category: viewModel.categories[1].categories[0])
                                
                            case "IQ":
                                self.viewModel.goToQuize(quiz: QuizIQ(), category: viewModel.categories[1].categories[1])
                                
                            case "экономика":
                                self.viewModel.goToQuize(quiz: QuizEconomy(), category: viewModel.categories[1].categories[2])
                                
                            case "география":
                                self.viewModel.goToQuize(quiz: QuizGeography(), category: viewModel.categories[1].categories[3])
                                
                            case "экология":
                                self.viewModel.goToQuize(quiz: QuizEcology(), category: viewModel.categories[1].categories[4])
                                
                            case "физика":
                                self.viewModel.goToQuize(quiz: QuizPhysics(), category: viewModel.categories[1].categories[5])
                                
                            case "химия":
                                self.viewModel.goToQuize(quiz: QuizChemistry(), category: viewModel.categories[1].categories[6])
                                
                            case "информатика":
                                self.viewModel.goToQuize(quiz: QuizInformatics(), category: viewModel.categories[1].categories[7])
                                
                            case "литература":
                                self.viewModel.goToQuize(quiz: QuizLiterature(), category: viewModel.categories[2].categories[0])
                                
                            case "ПДД":
                                self.viewModel.goToQuize(quiz: QuizRoadTraffic(), category: viewModel.categories[2].categories[1])
                                
                            case "Swift":
                                self.viewModel.goToQuize(quiz: QuizSwift(), category: viewModel.categories[2].categories[2])
                                
                            case "подводный мир":
                                self.viewModel.goToQuize(quiz: QuizUnderwater(), category: viewModel.categories[3].categories[0])
                            
                            case "шахматы":
                                self.viewModel.goToQuize(quiz: QuizChess(), category: viewModel.categories[3].categories[1])
                                
                            case "хэллоуин":
                                self.viewModel.goToQuize(quiz: QuizHalloween(), category: viewModel.categories[4].categories[0])
                                
                            case "новый год":
                                self.viewModel.goToQuize(quiz: QuizNewYear(), category: viewModel.categories[5].categories[0])
                                
                            default:
                                break
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
            guard let vc = self.storyboard?.instantiateViewController(identifier: "ViewController") else {return}
            guard let window = self.view?.window else {return}
            window.rootViewController = vc
        }
    }
    
}
