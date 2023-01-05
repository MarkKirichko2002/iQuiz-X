//
//  StartViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 19.03.2022.
//

import UIKit
import AVFoundation
import AVKit
import Vision
import Firebase
import SCLAlertView

class StartViewController: UIViewController {
    
    @IBOutlet weak var StartButton: UIButton!
    @IBOutlet weak var TodayQuizButton: UIButton!
    @IBOutlet weak var Image: RoundedImageView!
    @IBOutlet weak var TitleName: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var view2: UIView!
    
    private let player = SoundClass()
    private let navigationManager = NavigationManager()
    private let categoriesViewModel = CategoriesViewModel()
    private let timer = Timer()
    private let animation = AnimationClass()
    private var sound = ""
    private let randomindex = UserDefaults.standard.object(forKey: "index") as? Int ?? 0
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer.invalidate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoriesViewModel.view = self.view
        categoriesViewModel.storyboard = self.storyboard
        // навигация
        navigationManager.storyboard = self.storyboard
        navigationManager.vc = self
        navigationManager.button = self.StartButton
        
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
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(GoToRandomQuiz))
        self.TodayQuizButton.isUserInteractionEnabled = true
        self.TodayQuizButton.addGestureRecognizer(tap2)
    }
    
    func GenerateRandomIndex() {
        
        var randomindex = Int.random(in: 0..<categoriesViewModel.quizcategories.count - 1)
        
        UserDefaults.standard.set(randomindex, forKey: "index") as? Int
        
        let savedindex = UserDefaults.standard.object(forKey: "index") as? Int
        
        if randomindex == savedindex {
            randomindex = Int.random(in: 0..<categoriesViewModel.quizcategories.count-1)
        } else {}
    }
    
    
    @objc func UpdateTime() {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let sec = calendar.component(.second, from: date)
        let hourString = String(hour)
        let minutesString = String(minutes)
        let seconds = String(sec)
        
        var weakday = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        
        var weakdays = String(weakday)
        var months = String(month)
        
        var currentdate = ("\(hourString) ч. : \(minutesString) м. : \(seconds) с.")
        
        var currentday = weakdays + "/" + months
        
        print(currentday)
        
        switch month {
            
            
        case 1:
            
            months = "Января"
            
            currentday = ("\(weakdays) \(months)")
            
            self.TitleName.text = ("Сегодня \(currentday) \n 🕐: \(currentdate)")
            
            print("january")
            
        case 2:
            
            months = "Февраля"
            
            currentday = ("\(weakdays) \(months)")
            
            self.TitleName.text = ("Сегодня \(currentday) \n 🕐: \(currentdate)")
            
            print("february")
            
        case 3:
            
            months = "Марта"
            
            currentday = ("\(weakdays) \(months)")
            
            self.TitleName.text = ("Сегодня \(currentday) \n 🕐: \(currentdate)")
            
            print("march")
            
        case 4:
            
            months = "Апреля"
            
            currentday = ("\(weakdays) \(months)")
            
            self.TitleName.text = ("Сегодня \(currentday) \n 🕐: \(currentdate)")
            
            print("april")
            
        case 5:
            
            months = "Мая"
            
            currentday = ("\(weakdays) \(months)")
            
            self.TitleName.text = ("Сегодня \(currentday) \n 🕐: \(currentdate)")
            
            print("may")
            
            
        case 6:
            
            months = "Июня"
            
            currentday = ("\(weakdays) \(months)")
            
            self.TitleName.text = ("Сегодня \(currentday) \n 🕐: \(currentdate)")
            
            print("june")
            
            
        case 7:
            
            months = "Июля"
            
            currentday = ("\(weakdays) \(months)")
            
            self.TitleName.text = ("Сегодня \(currentday) \n 🕐: \(currentdate)")
            
            print("july")
            
            
        case 8:
            
            months = "Августа"
            
            currentday = ("\(weakdays) \(months)")
            
            self.TitleName.text = ("Сегодня \(currentday) \n 🕐: \(currentdate)")
            
            print("august")
            
        case 9:
            
            months = "Сентября"
            
            currentday = ("\(weakdays) \(months)")
            
            self.TitleName.text = ("Сегодня \(currentday) \n 🕐: \(currentdate)")
            
            print("september")
            
        case 10:
            
            months = "Октября"
            
            currentday = ("\(weakdays) \(months)")
            
            self.TitleName.text = ("Сегодня \(currentday) \n 🕐: \(currentdate)")
            
            print("october")
            
        case 11:
            
            months = "Ноября"
            
            currentday = ("\(weakdays) \(months)")
            
            self.TitleName.text = ("Сегодня \(currentday) \n 🕐: \(currentdate)")
            
            print("november")
            
        case 12:
            
            months = "Декабрь"
            
            currentday = ("\(weakdays) \(months)")
            
            self.TitleName.text = ("Сегодня \(currentday) \n 🕐: \(currentdate)")
            print("december")
            
        default: break
            
        }
        
        if hourString == "00" && minutesString == "0" && seconds == "0" {
            self.GenerateRandomIndex()
            self.DailyQuiz()
        }
        
    }
    
    func CheckTime() {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let sec = calendar.component(.second, from: date)
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        
        let hourString = String(hour)
        let minutesString = String(minutes)
        let seconds = String(sec)
        let days = String(day)
        let months = String(month)
        
        var currentdate = days + "/" + months
        
        var saveddate = UserDefaults.standard.object(forKey: "saveddate") as? String
        
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
    
    func writedate(date: String, key: String) {
        UserDefaults.standard.set(date, forKey: key)
        print(UserDefaults.standard.object(forKey: key) ?? "")
    }
    
    func DailyQuiz() {
        
        Image.sound = categoriesViewModel.quizcategories[randomindex].sound
        sound = categoriesViewModel.quizcategories[randomindex].sound
        
        self.TodayQuizButton.setTitle(categoriesViewModel.quizcategories[randomindex].name, for: .normal)
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: categoriesViewModel.quizcategories[randomindex].background)!)
        self.scrollView.backgroundColor = UIColor(patternImage: UIImage(named: categoriesViewModel.quizcategories[randomindex].background)!)
        self.view2.backgroundColor = UIColor(patternImage: UIImage(named: categoriesViewModel.quizcategories[randomindex].background)!)
        self.Image.image = UIImage(named: categoriesViewModel.quizcategories[randomindex].image)
    }
    
    @objc func GoToRandomQuiz() {
        
        player.PlaySound(resource: sound)
        self.animation.springButton(button: self.TodayQuizButton)
        
        let c = categoriesViewModel.quizcategories[randomindex]
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.categoriesViewModel.GoToQuiz(quiz: c.base, category: c)
        }
    }
}
