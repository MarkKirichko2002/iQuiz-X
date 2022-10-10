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
    
    let db = Firestore.firestore()
    var player = SoundClass()
    var viewModel = CategoriesViewModel()
    var category: QuizModel?
    
    // View
    var storyboard: UIStoryboard?
    var view: UIView?
    
    func SetupView(view: UIView, storyboard: UIStoryboard) {
        self.view = view
        self.storyboard = storyboard
    }
    
    func LoadQuizResult() {
        let docRef = db.collection("users").document((Auth.auth().currentUser?.email)!)
        
        docRef.getDocument { document, error in
            if let error = error as NSError? {
                print("Error getting document: \(error.localizedDescription)")
            }
            else {
                if let document = document {
                    let data = document.data()
                    if let category = document["lastquiz"] as? [String: Any] {
                        let CorrectAnswersCounter = category["CorrectAnswersCounter"] as? Int
                        let image = category["image"] as? String
                        let background = category["background"] as? String
                        let bestscore = category["bestscore"] as? Int ?? 0
                        let category = category["category"] as? String ?? ""
                        
                        let result = QuizResult(categoryName: category, icon: image ?? "", bestscore: bestscore, CorrectAnswersCounter: CorrectAnswersCounter ?? 0, background: background ?? "")
                        
//                        self.ScoreLabel.text = ("счет: \(String(bestscore))/100 баллов")
//                        self.CorrectAnswers.text = "Правильные ответы: \(CorrectAnswersCounter ?? 0)/20"
//                        self.CommentLabel.text = category
//                        self.Image.image = UIImage(named: image ?? "")
//                        self.view.backgroundColor = UIColor(patternImage: UIImage(named: background!)!)
//                        self.view2.backgroundColor = UIColor(patternImage: UIImage(named: background!)!)
//                        self.scrollView.backgroundColor = UIColor(patternImage: UIImage(named: background!)!)
                       
//                        if bestscore == 0 {
//                            self.CommentLabel.text = "категория \(category) не пройдена!"
//                            self.player.Sound(resource: "bgm.mp3")
//                        }
//
//                        if bestscore == 100 {
//                            self.ExitButton.flash()
//                            self.player.Sound(resource: "victory_sound.mp3")
//                            self.CommentLabel.text = "категория \(category) 100%"
//                            self.Image.image = UIImage(named: "trophy.png")
//                            self.Image.flash()
//                        }
                        
                        self.quizresult.onNext(result)
                    }
                }
            }
        }
    }
    
    // перезапустить викторину
    func restartGame() {
        DispatchQueue.main.async {
            
            let docRef = self.db.collection("users").document((Auth.auth().currentUser?.email)!)
            
            docRef.getDocument { document, error in
                if let error = error as NSError? {
                    print("Error getting document: \(error.localizedDescription)")
                }
                else {
                    if let document = document {
                        let data = document.data()
                        if let category = document["lastquiz"] as? [String: Any] {
                            let category = category["category"] as? String ?? ""
                            
                            switch category {
                                
                            case "планеты":
                                self.viewModel.goToQuize(quiz: QuizPlanets(), storyboard: self.storyboard, view: self.view!)
                                
                            case "история":
                                self.viewModel.goToQuize(quiz: QuizHistory(), storyboard: self.storyboard, view: self.view!)
                                
                            case "анатомия":
                                self.viewModel.goToQuize(quiz: QuizAnatomy(), storyboard: self.storyboard, view: self.view!)
                                
                            case "спорт":
                                self.viewModel.goToQuize(quiz: QuizSport(), storyboard: self.storyboard, view: self.view!)
                                
                            case "игры":
                                self.viewModel.goToQuize(quiz: QuizGames(), storyboard: self.storyboard, view: self.view!)
                                
                            case "IQ":
                                self.viewModel.goToQuize(quiz: QuizIQ(), storyboard: self.storyboard, view: self.view!)
                                
                            case "экономика":
                                self.viewModel.goToQuize(quiz: QuizEconomy(), storyboard: self.storyboard, view: self.view!)
                                
                            case "география":
                                self.viewModel.goToQuize(quiz: QuizGeography(), storyboard: self.storyboard, view: self.view!)
                                
                            case "экология":
                                self.viewModel.goToQuize(quiz: QuizEcology(), storyboard: self.storyboard, view: self.view!)
                                
                            case "физика":
                                self.viewModel.goToQuize(quiz: QuizPhysics(), storyboard: self.storyboard, view: self.view!)
                                
                            case "химия":
                                self.viewModel.goToQuize(quiz: QuizChemistry(), storyboard: self.storyboard, view: self.view!)
                                
                            case "информатика":
                                self.viewModel.goToQuize(quiz: QuizInformatics(), storyboard: self.storyboard, view: self.view!)
                                
                            case "литература":
                                self.viewModel.goToQuize(quiz: QuizLiterature(), storyboard: self.storyboard, view: self.view!)
                                
                            case "ПДД":
                                self.viewModel.goToQuize(quiz: QuizRoadTraffic(), storyboard: self.storyboard, view: self.view!)
                                
                            case "Swift":
                                self.viewModel.goToQuize(quiz: QuizSwift(), storyboard: self.storyboard, view: self.view!)
                                
                            case "подводный мир":
                                self.viewModel.goToQuize(quiz: QuizUnderwater(), storyboard: self.storyboard, view: self.view!)
                            
                            case "шахматы":
                                self.viewModel.goToQuize(quiz: QuizChess(), storyboard: self.storyboard, view: self.view!)
                                
                            case "хэллоуин":
                                self.viewModel.goToQuize(quiz: QuizHalloween(), storyboard: self.storyboard, view: self.view!)
                                
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
