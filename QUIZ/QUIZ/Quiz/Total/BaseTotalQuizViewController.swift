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
    
    let db = Firestore.firestore()
    
    var player = SoundClass()
    
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
                        let category = category["category"] as? String ?? "lol"
                        self.ScoreLabel.text = ("Лучший счет: \(String(bestscore)) баллов")
                        self.CorrectAnswers.text = "Количество правильных ответов: \(CorrectAnswersCounter ?? 0)/20"
                        self.CommentLabel.text = category
                        self.Image.image = UIImage(named: image ?? "")
                        self.view.backgroundColor = UIColor(patternImage: UIImage(named: background!)!)
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
                            //self.Image.layer.borderColor = UIColor.systemYellow.cgColor
                            self.Image.flash()
                        }
                        
                    }
                    
                    if let category = document["image"] as? [String: Any] {
                        let photo = category["photo"] as? String
                        let imageURL = URL(string: photo ?? "")
                        self.Image.sd_setImage(with: imageURL)
                        print(photo)
                        
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
    
    
    func PresentQuiz(quiz: QuizBase) {
        goToQuize(quiz: quiz)
    }
    
    
    func goToQuize(quiz: QuizBase) {
        DispatchQueue.main.async {
            guard let vc = self.storyboard?.instantiateViewController(identifier: "BaseQuizViewController") else {return}
            (vc as? BaseQuizViewController)?.setQuizeModel(quiz: quiz)
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
                            let category = category["category"] as? String ?? "lol"
                            
                            switch category {
                                
                            case "планеты":
                                self.PresentQuiz(quiz: QuizPlanets())
                                
                            case "история":
                                self.PresentQuiz(quiz: QuizHistory())
                                
                            case "анатомия":
                                self.PresentQuiz(quiz: QuizAnatomy())
                                
                            case "спорт":
                                self.PresentQuiz(quiz: QuizSport())
                                
                            case "игры":
                                self.PresentQuiz(quiz: QuizGames())
                                
                            case "IQ":
                                self.PresentQuiz(quiz: QuizIQ())
                                
                            case "экономика":
                                self.PresentQuiz(quiz: QuizEconomy())
                                
                            case "география":
                                self.PresentQuiz(quiz: QuizGeography())
                                
                            case "экология":
                                self.PresentQuiz(quiz: QuizEcology())
                                
                            case "физика":
                                self.PresentQuiz(quiz: QuizPhysics())
                                
                            case "химия":
                                self.PresentQuiz(quiz: QuizChemistry())
                                
                            case "информатика":
                                self.PresentQuiz(quiz: QuizInformatics())
                                
                            case "литература":
                                self.PresentQuiz(quiz: QuizLiterature())
                                
                            case "ПДД":
                                self.PresentQuiz(quiz: QuizRoadTraffic())
                                
                            case "Swift":
                                self.goToQuize(quiz: QuizSwift())
                                
                            case "подводный мир":
                                self.goToQuize(quiz: QuizUnderwater())
                            
                            case "шахматы":
                                self.goToQuize(quiz: QuizChess())
                                
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





