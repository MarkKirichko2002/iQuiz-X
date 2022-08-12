//
//  BaseTotalQuizViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 16.02.2022.
//

import UIKit
import Firebase
import SDWebImage
import Vision
import AVKit

class BaseTotalQuizViewController: UIViewController {
    
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var ScoreLabel: UILabel!
    @IBOutlet weak var ExitButton: UIButton!
    @IBOutlet weak var CorrectAnswers: UILabel!
    @IBOutlet weak var CommentLabel: UILabel!
    @IBOutlet weak var RetryButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var view2: UIView!
    
    let db = Firestore.firestore()
    
    var player = SoundClass()
    var viewModel = CategoriesViewModel()
    
    func loadScore() {
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
                        self.ScoreLabel.text = ("счет: \(String(bestscore))/100 баллов")
                        self.CorrectAnswers.text = "Правильные ответы: \(CorrectAnswersCounter ?? 0)/20"
                        self.CommentLabel.text = category
                        self.Image.image = UIImage(named: image ?? "")
                        self.view.backgroundColor = UIColor(patternImage: UIImage(named: background!)!)
                        self.view2.backgroundColor = UIColor(patternImage: UIImage(named: background!)!)
                        self.scrollView.backgroundColor = UIColor(patternImage: UIImage(named: background!)!)
                        print(category)
                        
                        if bestscore == 0 {
                            self.CommentLabel.text = "категория \(category) не пройдена!"
                            self.player.Sound(resource: "bgm.mp3")
                        }
                        
                        if bestscore < 100 {
                            self.RetryButton.flash()
                        }
                        
                        if bestscore == 100 {
                            self.ExitButton.flash()
                            self.player.Sound(resource: "victory_sound.mp3")
                            self.CommentLabel.text = "категория \(category) 100%"
                            self.Image.image = UIImage(named: "trophy.png")
                            self.Image.flash()
                        }
                        
                    }
                    
                    if let category = document["image"] as? [String: Any] {
                        let photo = category["photo"] as? String
                        let imageURL = URL(string: photo ?? "")
                        self.Image.sd_setImage(with: imageURL)
                    }
                    
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RetryButton.layer.borderWidth = 2
        RetryButton.layer.borderColor = UIColor.black.cgColor
        ExitButton.layer.borderWidth = 2
        ExitButton.layer.borderColor = UIColor.black.cgColor
        
        loadScore()
        Image.layer.cornerRadius = Image.frame.size.width / 2
        Image.clipsToBounds = true
        Image.layer.borderWidth = 5
        Image.layer.borderColor = UIColor.black.cgColor
        
        CommentLabel.font = UIFont.boldSystemFont(ofSize: 20)
        ScoreLabel.font = UIFont.boldSystemFont(ofSize: 20)
        CorrectAnswers.font = UIFont.boldSystemFont(ofSize: 20)
        
        ExitButton.layer.cornerRadius = ExitButton.frame.size.width / 5
        ExitButton.clipsToBounds = true
        
        RetryButton.layer.cornerRadius = RetryButton.frame.size.width / 5
        RetryButton.clipsToBounds = true
        
    }
    
    
    @IBAction func presentCategoryScreen() {
        PresentCategoryScreen()
    }
    
    @IBAction func restart() {
        restartGame()
    }
    
    
    func PresentCategoryScreen() {
        
        DispatchQueue.main.async {
            guard let vc = self.storyboard?.instantiateViewController(identifier: "ViewController") else {return}
            guard let window = self.view.window else {return}
            window.rootViewController = vc
        }
    }
    
    
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
                                self.viewModel.goToQuize(quiz: QuizPlanets(), storyboard: self.storyboard, view: self.view)
                                
                            case "история":
                                self.viewModel.goToQuize(quiz: QuizHistory(), storyboard: self.storyboard, view: self.view)
                                
                            case "анатомия":
                                self.viewModel.goToQuize(quiz: QuizAnatomy(), storyboard: self.storyboard, view: self.view)
                                
                            case "спорт":
                                self.viewModel.goToQuize(quiz: QuizSport(), storyboard: self.storyboard, view: self.view)
                                
                            case "игры":
                                self.viewModel.goToQuize(quiz: QuizGames(), storyboard: self.storyboard, view: self.view)
                                
                            case "IQ":
                                self.viewModel.goToQuize(quiz: QuizIQ(), storyboard: self.storyboard, view: self.view)
                                
                            case "экономика":
                                self.viewModel.goToQuize(quiz: QuizEconomy(), storyboard: self.storyboard, view: self.view)
                                
                            case "география":
                                self.viewModel.goToQuize(quiz: QuizGeography(), storyboard: self.storyboard, view: self.view)
                                
                            case "экология":
                                self.viewModel.goToQuize(quiz: QuizEcology(), storyboard: self.storyboard, view: self.view)
                                
                            case "физика":
                                self.viewModel.goToQuize(quiz: QuizPhysics(), storyboard: self.storyboard, view: self.view)
                                
                            case "химия":
                                self.viewModel.goToQuize(quiz: QuizChemistry(), storyboard: self.storyboard, view: self.view)
                                
                            case "информатика":
                                self.viewModel.goToQuize(quiz: QuizInformatics(), storyboard: self.storyboard, view: self.view)
                                
                            case "литература":
                                self.viewModel.goToQuize(quiz: QuizLiterature(), storyboard: self.storyboard, view: self.view)
                                
                            case "ПДД":
                                self.viewModel.goToQuize(quiz: QuizRoadTraffic(), storyboard: self.storyboard, view: self.view)
                                
                            case "Swift":
                                self.viewModel.goToQuize(quiz: QuizSwift(), storyboard: self.storyboard, view: self.view)
                                
                            case "подводный мир":
                                self.viewModel.goToQuize(quiz: QuizUnderwater(), storyboard: self.storyboard, view: self.view)
                            
                            case "шахматы":
                                self.viewModel.goToQuize(quiz: QuizChess(), storyboard: self.storyboard, view: self.view)
                                
                            default:
                                break
                            }
                            
                        }
                        
                    }
                }
            }
        }
    }
}





