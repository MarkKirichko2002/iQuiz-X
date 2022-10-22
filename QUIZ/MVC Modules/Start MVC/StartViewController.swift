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
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var TitleName: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var view2: UIView!
    
    var player = SoundClass()
    var viewModel = CategoriesViewModel()
    var timer = Timer()
    var animation = AnimationClass()
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer.invalidate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let everyMinuteTimer = Timer.scheduledTimer(timeInterval: 0, target: self,
//                                                    selector: #selector(UpdateTime), userInfo: nil, repeats: true)
        
        self.CheckTime()
        
        StartButton.layer.cornerRadius = StartButton.frame.size.width / 10
        StartButton.clipsToBounds = true
        
        StartButton.layer.borderWidth = 2
        StartButton.layer.borderColor = UIColor.black.cgColor
        
        
        TodayQuizButton.layer.cornerRadius = TodayQuizButton.frame.size.width / 10
        TodayQuizButton.clipsToBounds = true
        
        TodayQuizButton.layer.borderWidth = 2
        TodayQuizButton.layer.borderColor = UIColor.black.cgColor
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(GoToQuizApp))
        self.StartButton.isUserInteractionEnabled = true
        self.StartButton.addGestureRecognizer(tap)
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(GoToRandomQuiz))
        self.TodayQuizButton.isUserInteractionEnabled = true
        self.TodayQuizButton.addGestureRecognizer(tap2)
    }
    
    
    var quizes = [QuizPlanets(), QuizHistory(), QuizAnatomy(), QuizSport(), QuizGames(), QuizIQ(), QuizEconomy(), QuizGeography(), QuizEconomy(), QuizPhysics(), QuizChemistry(), QuizInformatics()]
    
    
    func GenerateRandomIndex() {
        
        var randomindex = Int.random(in: 0..<quizes.count)
        
        UserDefaults.standard.set(randomindex, forKey: "index") as? Int
        
        var savedindex = UserDefaults.standard.object(forKey: "index") as? Int
        
        if randomindex == savedindex {
            randomindex = Int.random(in: 0..<quizes.count)
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
            
            self.TitleName.text = ("Сегодня \(currentday ?? "") \n 🕐: \(currentdate)")
            
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
            self.dailyquiz()
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
        
        //var currentdate = "2/5"
        
        var saveddate = UserDefaults.standard.object(forKey: "saveddate") as? String
        
        var randomindex = (UserDefaults.standard.object(forKey: "index") as? Int) ?? 100
        
        if currentdate != saveddate {
            print("next day")
            print("текущая дата \(currentdate)")
            print("сохраненная дата \(saveddate ?? "")")
            print("dates: \(currentdate) and \(saveddate ?? "") are not same")
            GenerateRandomIndex()
            dailyquiz()
            UserDefaults.standard.set(currentdate, forKey: "saveddate")
        }else if currentdate == saveddate {
            print("today")
            print("текущая дата \(currentdate)")
            print("сохраненная дата \(saveddate ?? "")")
            dailyquiz()
            print("dates: \(currentdate) and \(saveddate ?? "") are same")
        }
    }
    
    func writedate(date: String, key: String) {
        UserDefaults.standard.set(date, forKey: key)
        print(UserDefaults.standard.object(forKey: key) ?? "")
    }
    
    func dailyquiz() {
        var randomindex = (UserDefaults.standard.object(forKey: "index") as? Int) ?? 100
        
        //GenerateRandomIndex()
        
        let date = UserDefaults.standard.object(forKey: "saveddate")
        
        switch quizes[randomindex].checkid() {
            
            
        case 1:
            print("planets")
            self.TodayQuizButton.setTitle("планеты", for: .normal)
            //self.TodayQuizButton.backgroundColor = UIColor(patternImage: UIImage(named: "earth.background.jpeg")!)
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "earth.background.jpeg")!)
            self.scrollView.backgroundColor = UIColor(patternImage: UIImage(named: "earth.background.jpeg")!)
            self.view2.backgroundColor = UIColor(patternImage: UIImage(named: "earth.background.jpeg")!)
            self.Image.image = UIImage(named: "planets.jpeg")
            //self.TitleName.text = "Сегодня: \(date ?? "")"
            
            
        case 2:
            print("history")
            self.TodayQuizButton.setTitle("история", for: .normal)
            //self.TodayQuizButton.backgroundColor = UIColor(patternImage: UIImage(named: "earth.background.jpeg")!)
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "history.background.jpeg")!)
            self.scrollView.backgroundColor = UIColor(patternImage: UIImage(named: "history.background.jpeg")!)
            self.view2.backgroundColor = UIColor(patternImage: UIImage(named: "history.background.jpeg")!)
            self.Image.image = UIImage(named: "history.jpeg")
            
            
        case 3:
            print("anatomy")
            self.TodayQuizButton.setTitle("анатомия", for: .normal)
            //self.TodayQuizButton.backgroundColor = UIColor(patternImage: UIImage(named: "anatomy.background.jpeg")!)
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "anatomy.background.jpeg")!)
            self.scrollView.backgroundColor = UIColor(patternImage: UIImage(named: "anatomy.background.jpeg")!)
            self.view2.backgroundColor = UIColor(patternImage: UIImage(named: "anatomy.background.jpeg")!)
            self.Image.image = UIImage(named: "anatomy.jpeg")
            
            
        case 4:
            print("sport")
            self.TodayQuizButton.setTitle("спорт", for: .normal)
            //self.TodayQuizButton.backgroundColor = UIColor(patternImage: UIImage(named: "sport.background.jpeg")!)
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "sport.background.jpeg")!)
            self.scrollView.backgroundColor = UIColor(patternImage: UIImage(named: "sport.background.jpeg")!)
            self.view2.backgroundColor = UIColor(patternImage: UIImage(named: "sport.background.jpeg")!)
            self.Image.image = UIImage(named: "sport.jpeg")
            
        case 5:
            print("games")
            self.TodayQuizButton.setTitle("игры", for: .normal)
            //self.TodayQuizButton.backgroundColor = UIColor(patternImage: UIImage(named: "games.background.jpeg")!)
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "games.background.jpeg")!)
            self.scrollView.backgroundColor = UIColor(patternImage: UIImage(named: "games.background.jpeg")!)
            self.view2.backgroundColor = UIColor(patternImage: UIImage(named: "games.background.jpeg")!)
            self.Image.image = UIImage(named: "games.jpeg")
            
        case 6:
            print("IQ")
            self.TodayQuizButton.setTitle("IQ", for: .normal)
            //self.TodayQuizButton.backgroundColor = UIColor(patternImage: UIImage(named: "IQ.background.jpeg")!)
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "IQ.background.jpeg")!)
            self.scrollView.backgroundColor = UIColor(patternImage: UIImage(named: "IQ.background.jpeg")!)
            self.view2.backgroundColor = UIColor(patternImage: UIImage(named: "IQ.background.jpeg")!)
            self.Image.image = UIImage(named: "IQ.jpeg")
            
        case 7:
            print("economy")
            self.TodayQuizButton.setTitle("экономика", for: .normal)
            //self.TodayQuizButton.backgroundColor = UIColor(patternImage: UIImage(named: "economy.background.jpeg")!)
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "economy.background.jpeg")!)
            self.scrollView.backgroundColor = UIColor(patternImage: UIImage(named: "economy.background.jpeg")!)
            self.view2.backgroundColor = UIColor(patternImage: UIImage(named: "economy.background.jpeg")!)
            self.Image.image = UIImage(named: "economy.jpeg")
            
        case 8:
            print("geography")
            self.TodayQuizButton.setTitle("география", for: .normal)
            //self.TodayQuizButton.backgroundColor = UIColor(patternImage: UIImage(named: "geography.background.jpeg")!)
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "geography.background.jpeg")!)
            self.scrollView.backgroundColor = UIColor(patternImage: UIImage(named: "geography.background.jpeg")!)
            self.view2.backgroundColor = UIColor(patternImage: UIImage(named: "geography.background.jpeg")!)
            self.Image.image = UIImage(named: "geography.jpeg")
            
        case 9:
            print("ecology")
            self.TodayQuizButton.setTitle("экология", for: .normal)
            //self.TodayQuizButton.backgroundColor = UIColor(patternImage: UIImage(named: "ecology.background.jpeg")!)
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "ecology.background.jpeg")!)
            self.scrollView.backgroundColor = UIColor(patternImage: UIImage(named: "ecology.background.jpeg")!)
            self.view2.backgroundColor = UIColor(patternImage: UIImage(named: "ecology.background.jpeg")!)
            self.Image.image = UIImage(named: "ecology.jpeg")
            
        case 10:
            print("physics")
            self.TodayQuizButton.setTitle("физика", for: .normal)
            //self.TodayQuizButton.backgroundColor = UIColor(patternImage: UIImage(named: "physics.background.jpeg")!)
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "physics.background.jpeg")!)
            self.scrollView.backgroundColor = UIColor(patternImage: UIImage(named: "physics.background.jpeg")!)
            self.view2.backgroundColor = UIColor(patternImage: UIImage(named: "physics.background.jpeg")!)
            self.Image.image = UIImage(named: "physics.jpeg")
            
        case 11:
            print("chemistry")
            self.TodayQuizButton.setTitle("химия", for: .normal)
            //self.TodayQuizButton.backgroundColor = UIColor(patternImage: UIImage(named: "chemistry.background.jpeg")!)
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "chemistry.background.jpeg")!)
            self.scrollView.backgroundColor = UIColor(patternImage: UIImage(named: "chemistry.background.jpeg")!)
            self.view2.backgroundColor = UIColor(patternImage: UIImage(named: "chemistry.background.jpeg")!)
            self.Image.image = UIImage(named: "chemistry.jpeg")
            
        case 12:
            print("informatics")
            self.TodayQuizButton.setTitle("информатика", for: .normal)
            //self.TodayQuizButton.backgroundColor = UIColor(patternImage: UIImage(named: "informatics.background.jpeg")!)
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "informatics.background.jpeg")!)
            self.scrollView.backgroundColor = UIColor(patternImage: UIImage(named: "informatics.background.jpeg")!)
            self.view2.backgroundColor = UIColor(patternImage: UIImage(named: "informatics.background.jpeg")!)
            self.Image.image = UIImage(named: "informatics.jpeg")
            
        case 13:
            print("literature")
            self.TodayQuizButton.setTitle("литература", for: .normal)
            //self.TodayQuizButton.backgroundColor = UIColor(patternImage: UIImage(named: "literature.background.jpeg")!)
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "literature.background.jpeg")!)
            self.scrollView.backgroundColor = UIColor(patternImage: UIImage(named: "literature.background.jpeg")!)
            self.view2.backgroundColor = UIColor(patternImage: UIImage(named: "literature.background.jpeg")!)
            self.Image.image = UIImage(named: "literature.jpeg")
            
        case 14:
            print("roadtraffic")
            self.TodayQuizButton.setTitle("ПДД", for: .normal)
            //self.TodayQuizButton.backgroundColor = UIColor(patternImage: UIImage(named: "roadtraffic.background.jpeg")!)
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "drive.background.jpeg")!)
            self.scrollView.backgroundColor = UIColor(patternImage: UIImage(named: "drive.background.jpeg")!)
            self.view2.backgroundColor = UIColor(patternImage: UIImage(named: "drive.background.jpeg")!)
            self.Image.image = UIImage(named: "drive.jpeg")
            
        case 15:
            print("Swift")
            self.TodayQuizButton.setTitle("Swift", for: .normal)
            //self.TodayQuizButton.backgroundColor = UIColor(patternImage: UIImage(named: "Swift.background.jpeg")!)
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Swift.background.jpeg")!)
            self.scrollView.backgroundColor = UIColor(patternImage: UIImage(named: "Swift.background.jpeg")!)
            self.view2.backgroundColor = UIColor(patternImage: UIImage(named: "Swift.background.jpeg")!)
            self.Image.image = UIImage(named: "Swift.jpeg")
            
        case 16:
            print("underwater")
            self.TodayQuizButton.setTitle("подводный мир", for: .normal)
            //self.TodayQuizButton.backgroundColor = UIColor(patternImage: UIImage(named: "Swift.background.jpeg")!)
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "underwater.background.jpeg")!)
            self.scrollView.backgroundColor = UIColor(patternImage: UIImage(named: "underwater.background.jpeg")!)
            self.view2.backgroundColor = UIColor(patternImage: UIImage(named: "underwater.background.jpeg")!)
            self.Image.image = UIImage(named: "underwater.png")
            
        case 17:
            print("chess")
            self.TodayQuizButton.setTitle("шахматы", for: .normal)
            //self.TodayQuizButton.backgroundColor = UIColor(patternImage: UIImage(named: "Swift.background.jpeg")!)
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "chess.background.jpeg")!)
            self.scrollView.backgroundColor = UIColor(patternImage: UIImage(named: "chess.background.jpeg")!)
            self.view2.backgroundColor = UIColor(patternImage: UIImage(named: "chess.background.jpeg")!)
            self.Image.image = UIImage(named: "chess.png")
            
        case 18:
            print("halloween")
            self.TodayQuizButton.setTitle("хэллоуин", for: .normal)
            //self.TodayQuizButton.backgroundColor = UIColor(patternImage: UIImage(named: "Swift.background.jpeg")!)
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "halloween.background.jpeg")!)
            self.scrollView.backgroundColor = UIColor(patternImage: UIImage(named: "halloween.background.jpeg")!)
            self.view2.backgroundColor = UIColor(patternImage: UIImage(named: "halloween.background.jpeg")!)
            self.Image.image = UIImage(named: "halloween.png")
            
        default:
            print("other")
            //self.TodayQuizButton.backgroundColor = UIColor(patternImage: UIImage(named: "random.background.jpeg")!)
            
        }
        
    }
    
    @objc func GoToRandomQuiz() {
        
        player.Sound(resource: "IQ.mp3")
        self.animation.springButton(button: self.TodayQuizButton)
        
        let randomindex = UserDefaults.standard.object(forKey: "index") as? Int
        let c = quizes[randomindex!]
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.viewModel.goToQuize(quiz: c, storyboard: self.storyboard, view: self.view)
        }
    }
    
    @objc func GoToQuizApp() {
        
        self.player.Sound(resource: "future click sound.wav")
        self.animation.springButton(button: self.StartButton)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            guard let vc = self.storyboard?.instantiateViewController(identifier: "ViewController") else {return}
            guard let window = self.view.window else {return}
            window.rootViewController = vc
        }
    }
}
