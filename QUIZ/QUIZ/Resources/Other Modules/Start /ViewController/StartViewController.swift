//
//  StartViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 19.03.2022.
//

import UIKit

final class StartViewController: UIViewController {
    
    private let player = SoundClass()
    private let navigationManager = NavigationManager()
    private let quizCategoriesViewModel = QuizCategoriesViewModel()
    private let animation = AnimationClass()
    private let randomindex = UserDefaults.standard.object(forKey: "index") as? Int ?? 0
    
    @IBOutlet weak var StartButton: UIButton!
    @IBOutlet weak var TodayQuizButton: UIButton!
    @IBOutlet weak var Image: RoundedImageView!
    @IBOutlet weak var TitleName: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var view2: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpView()
    }
    
    private func SetUpView() {
        quizCategoriesViewModel.view = self.view
        quizCategoriesViewModel.storyboard = self.storyboard
        // навигация
        navigationManager.view = self.view
        navigationManager.storyboard = self.storyboard
        navigationManager.vc = self
        navigationManager.button = self.StartButton
        navigationManager.button2 = self.TodayQuizButton
        navigationManager.category = self.quizCategoriesViewModel.quizcategories[randomindex]
        
        self.CheckTime()
        self.Image.color = .white
        
        StartButton.layer.cornerRadius = StartButton.frame.size.width / 10
        StartButton.clipsToBounds = true
        
        StartButton.layer.borderWidth = 2
        StartButton.layer.borderColor = UIColor.black.cgColor
        
        TodayQuizButton.layer.cornerRadius = TodayQuizButton.frame.size.width / 10
        TodayQuizButton.clipsToBounds = true
        
        TodayQuizButton.layer.borderWidth = 2
        TodayQuizButton.layer.borderColor = UIColor.black.cgColor
        
        let tap = UITapGestureRecognizer(target: navigationManager, action: #selector(navigationManager.GoToQuizApp))
        self.StartButton.isUserInteractionEnabled = true
        self.StartButton.addGestureRecognizer(tap)
        
        let tap2 = UITapGestureRecognizer(target: navigationManager, action: #selector(navigationManager.GoToDailyQuiz))
        self.TodayQuizButton.isUserInteractionEnabled = true
        self.TodayQuizButton.addGestureRecognizer(tap2)
    }
    
    private func GenerateRandomIndex() {
        
        var randomindex = Int.random(in: 0..<quizCategoriesViewModel.quizcategories.count - 1)
        
        UserDefaults.standard.set(randomindex, forKey: "index")
        
        let savedindex = UserDefaults.standard.object(forKey: "index") as? Int
        
        if randomindex == savedindex {
            randomindex = Int.random(in: 0..<quizCategoriesViewModel.quizcategories.count-1)
        } else {}
    }
    
    private func CheckTime() {
        
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let days = String(day)
        let months = String(month)
        let currentdate = days + "/" + months
        let saveddate = UserDefaults.standard.object(forKey: "saveddate") as? String
        
        if currentdate != saveddate {
            print("next day")
            print("текущая дата \(currentdate)")
            print("сохраненная дата \(saveddate ?? "")")
            print("dates: \(currentdate) and \(saveddate ?? "") are not same")
            GenerateRandomIndex()
            DailyQuiz()
            UserDefaults.standard.set(currentdate, forKey: "saveddate")
        } else if currentdate == saveddate {
            print("today")
            print("текущая дата \(currentdate)")
            print("сохраненная дата \(saveddate ?? "")")
            DailyQuiz()
            print("dates: \(currentdate) and \(saveddate ?? "") are same")
        }
    }
    
    private func DailyQuiz() {
        
        Image.sound = quizCategoriesViewModel.quizcategories[randomindex].sound
        
        self.TodayQuizButton.setTitle(quizCategoriesViewModel.quizcategories[randomindex].name, for: .normal)
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: quizCategoriesViewModel.quizcategories[randomindex].background)!)
        self.scrollView.backgroundColor = UIColor(patternImage: UIImage(named: quizCategoriesViewModel.quizcategories[randomindex].background)!)
        self.view2.backgroundColor = UIColor(patternImage: UIImage(named: quizCategoriesViewModel.quizcategories[randomindex].background)!)
        self.Image.image = UIImage(named: quizCategoriesViewModel.quizcategories[randomindex].image)
    }
    
    @objc private func GoToRandomQuiz() {
        
        player.PlaySound(resource: quizCategoriesViewModel.quizcategories[randomindex].sound)
        self.animation.SpringAnimation(view: self.TodayQuizButton)
        
        let c = quizCategoriesViewModel.quizcategories[randomindex]
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.quizCategoriesViewModel.GoToQuiz(quiz: c.base, category: c)
        }
    }
}
