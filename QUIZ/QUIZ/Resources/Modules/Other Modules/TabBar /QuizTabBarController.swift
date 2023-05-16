//
//  QuizTabBarController.swift
//  QUIZ
//
//  Created by Марк Киричко on 16.02.2022.
//

import UIKit

final class QuizTabBarController: UITabBarController {
    
    private let player = SoundClass()
    private let button = UIButton()
    private let quizCategoriesViewModel = QuizCategoriesViewModel()
    private var isStart: Bool = false
    private var icon = "voice.png"
    private var currentIcon = ""
    private var quizBaseViewModel = QuizBaseViewModel()
    private let animation = AnimationClass()
    private let speechRecognitionManager = SpeechRecognitionManager()
    private let today = Date()
    private var firebaseManager = FirebaseManager()
    private let speechRecognition = SpeechRecognitionManager()
    private var sound = ""
    private var seconds = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.quizCategoriesViewModel.CreateCategories()
        quizBaseViewModel.viewController = self
        quizCategoriesViewModel.view = self.view
        quizCategoriesViewModel.storyboard = self.storyboard
        speechRecognitionManager.configureAudioSession()
        selectedIndex = UserDefaults.standard.object(forKey: "index") as? Int ?? 0
        button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        button.layer.borderWidth = 2
        self.view.insertSubview(button, aboveSubview: self.tabBar)
        button.addTarget(self, action:  #selector(QuizTabBarController.VoiceCommands(_:)), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        button.frame = CGRect.init(x: self.tabBar.center.x - 32, y: self.view.bounds.height - 100, width: 64, height: 64)
        button.layer.cornerRadius = 32
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.speechRecognition.cancelSpeechRecognition()
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        animation.TabBarItemAnimation(item: item)
    }
    
    // Override selectedViewController for User initiated changes
    override var selectedViewController: UIViewController? {
        didSet {
            tabChangedTo(selectedIndex: selectedIndex)
        }
    }
    // Override selectedIndex for Programmatic changes
    override var selectedIndex: Int {
        didSet {
            tabChangedTo(selectedIndex: selectedIndex)
        }
    }
    
    private func tabChangedTo(selectedIndex: Int) {
        UserDefaults.standard.set(selectedIndex, forKey: "index")
        switch selectedIndex {
            
        case 0:
            self.icon = "newspaper.png"
            self.button.setImage(UIImage(named: self.icon), for: .normal)
            self.player.PlaySound(resource: "newspaper.mp3")
        case 1:
            self.icon = "astronomy.png"
            self.button.setImage(UIImage(named: self.icon), for: .normal)
            self.player.PlaySound(resource: "IQ.mp3")
        case 3:
            self.icon = "trophy.png"
            self.button.setImage(UIImage(named: self.icon), for: .normal)
            self.player.PlaySound(resource: "league.mp3")
        case 4:
            self.icon = UserDefaults.standard.value(forKey: "url") as? String ?? "https://cdn-icons-png.flaticon.com/512/3637/3637624.png"
            self.button.layer.cornerRadius = self.button.frame.width / 2
            self.button.clipsToBounds = true
            self.button.sd_setImage(with: URL(string: self.icon), for: .normal)
            self.firebaseManager.LoadLastQuizCategoryData { result in
                self.player.PlaySound(resource: result.sound)
            }
        default:
            break
        }
        self.animation.SpringAnimation(view: self.button)
        self.currentIcon = icon
    }
    
    private func CheckVoiceCommands(text: String) {
        
        switch text {
            
        // Навигация по приложению
        case _ where text.contains("Новост") || text.contains("новост"):
            self.selectedIndex = 0
            icon = "newspaper.png"
            button.setImage(UIImage(named: self.icon), for: .normal)
            animation.SpringAnimation(view: self.button)
            player.PlaySound(resource: "newspaper.mp3")
            
            self.speechRecognition.cancelSpeechRecognition()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.speechRecognition.startSpeechRecognition()
            }
            
        case _ where selectedIndex == 0  && text.lowercased().contains("категори"):
            if text.lowercased().contains("техно") {
                NewsListViewModel().GetNews(category: .technology)
                self.icon = "technology"
                self.button.setImage(UIImage(named: self.icon), for: .normal)
                self.animation.SpringAnimation(view: self.button)
                self.player.PlaySound(resource: "technology.wav")
                self.speechRecognition.cancelSpeechRecognition()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.speechRecognition.startSpeechRecognition()
                }
            } else if text.lowercased().contains("спорт") {
                NewsListViewModel().GetNews(category: .sport)
                self.icon = "sport.jpeg"
                self.button.setImage(UIImage(named: self.icon), for: .normal)
                self.animation.SpringAnimation(view: self.button)
                self.player.PlaySound(resource: "sport.mp3")
                self.speechRecognition.cancelSpeechRecognition()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.speechRecognition.startSpeechRecognition()
                }
            } else if text.lowercased().contains("бизнес") {
                NewsListViewModel().GetNews(category: .business)
                self.icon = "business"
                self.button.setImage(UIImage(named: self.icon), for: .normal)
                self.animation.SpringAnimation(view: self.button)
                self.player.PlaySound(resource: "economics.mp3")
                self.speechRecognition.cancelSpeechRecognition()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.speechRecognition.startSpeechRecognition()
                }
            } else if text.lowercased().contains("топ") {
                NewsListViewModel().GetNews(category: .general)
                self.icon = "newspaper"
                self.button.setImage(UIImage(named: self.icon), for: .normal)
                self.animation.SpringAnimation(view: self.button)
                self.player.PlaySound(resource: "newspaper.mp3")
                self.speechRecognition.cancelSpeechRecognition()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.speechRecognition.startSpeechRecognition()
                }
            } else {
                
            }
        
        case _ where text.lowercased().contains("викторин"):
            self.selectedIndex = 1
            self.icon = "astronomy.png"
            self.button.setImage(UIImage(named: self.icon), for: .normal)
            self.animation.SpringAnimation(view: self.button)
            self.player.PlaySound(resource: "IQ.mp3")
            
            self.speechRecognition.cancelSpeechRecognition()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.speechRecognition.startSpeechRecognition()
            }
            
        case _ where text.lowercased().contains("категори"):
            if text.lowercased().contains("последняя") {
                firebaseManager.LoadLastQuizCategoryData { category in
                    self.icon = category.icon
                    self.button.setImage(UIImage(named: self.icon), for: .normal)
                    self.animation.SpringAnimation(view: self.button)
                    self.player.PlaySound(resource: category.sound)
                }
                self.speechRecognition.cancelSpeechRecognition()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.speechRecognition.startSpeechRecognition()
                }
            }
            
            for i in 0...5 {
                for value in self.quizCategoriesViewModel.categories[i].categories {
                    if text.lowercased().contains("какой счёт у категории \(value.name)") {
                        firebaseManager.LoadQuizCategoriesData(quizpath: value.quizpath) { category in
                            self.seconds = 2
                            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                                self.icon = value.image
                                self.button.setImage(UIImage(named: self.icon), for: .normal)
                                self.animation.SpringAnimation(view: self.button)
                                self.player.PlaySound(resource: value.sound)
                                self.seconds -= 1
                                if self.seconds == 0 {
                                    timer.invalidate()
                                    DispatchQueue.main.async {
                                        self.button.setImage(UIImage(named: ""), for: .normal)
                                        self.button.setTitleColor(.black, for: .normal)
                                        self.button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
                                        self.button.setTitle("\(category.score)", for: .normal)
                                        self.animation.SpringAnimation(view: self.button)
                                    }
                                }
                            }
                        }
                        self.speechRecognition.cancelSpeechRecognition()
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.speechRecognition.startSpeechRecognition()
                        }
                    }
                }
            }
            
        case _ where text.lowercased().contains("куб"):
            self.selectedIndex = 3
            self.icon = "trophy.png"
            self.button.setImage(UIImage(named: self.icon), for: .normal)
            self.animation.SpringAnimation(view: self.button)
            self.player.PlaySound(resource: "league.mp3")
            
            self.speechRecognition.cancelSpeechRecognition()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.speechRecognition.startSpeechRecognition()
            }
            
        case _ where text.lowercased().contains("проф"):
            self.selectedIndex = 4
            self.icon = UserDefaults.standard.value(forKey: "url") as? String ?? "https://cdn-icons-png.flaticon.com/512/3637/3637624.png"
            self.button.layer.cornerRadius = self.button.frame.width / 2
            self.button.clipsToBounds = true
            self.button.sd_setImage(with: URL(string: self.icon), for: .normal)
            self.animation.SpringAnimation(view: self.button)
            self.firebaseManager.LoadLastQuizCategoryData { result in
                self.player.PlaySound(resource: result.sound)
            }
            
            self.speechRecognition.cancelSpeechRecognition()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.speechRecognition.startSpeechRecognition()
            }
         
        // выбор категории викторины
        case _ where text != "":
            for i in 0...5 {
                for value in self.quizCategoriesViewModel.categories[i].categories {
                    if text.lowercased().contains(value.voiceCommand) {
                        DispatchQueue.main.async {
                            self.icon = value.image
                            self.button.setImage(UIImage(named: self.icon), for: .normal)
                            self.animation.SpringAnimation(view: self.button)
                            self.player.PlaySound(resource: value.sound)
                            self.sound = value.sound
                        }
                        
                        var sec = 6
                        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                            sec -= 1
                            print(sec)
                            self.button.setImage(UIImage(named: ""), for: .normal)
                            self.button.setTitle("\(sec)", for: .normal)
                            self.button.setTitleColor(.black, for: .normal)
                            if sec == 0 {
                                timer.invalidate()
                                self.quizCategoriesViewModel.GoToStart(quiz: value.base, category: value)
                            }
                        }
                    }
                }
            }
                
        // Включение/Выключение музыки
        case _ where text.lowercased().contains("муз"):
            self.icon = "astronomy.png"
            self.button.setImage(UIImage(named: self.icon), for: .normal)
            self.sound = "space music.mp3"
            self.player.PlaySound(resource: self.sound)
            self.animation.StartRotateAnimation(view: self.button.imageView!)
            
        case _ where text.lowercased().contains("выкл"):
            self.icon = "voice.png"
            self.button.setImage(UIImage(named: self.icon), for: .normal)
            self.player.StopSound(resource: self.sound)
            self.animation.StopRotateAnimation(view: self.button.imageView!)
            
        // Узнать текущее время
        case _ where text.lowercased().contains("врем"):
            let hours   = (Calendar.current.component(.hour, from: self.today))
            let minutes = (Calendar.current.component(.minute, from: self.today))
            
            self.button.setImage(UIImage(named: ""), for: .normal)
            self.button.setTitleColor(.black, for: .normal)
            self.button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            self.button.setTitle("\(hours):\(minutes)", for: .normal)
            self.quizBaseViewModel.sayComment(comment: "\(hours):\(minutes)")
            self.animation.SpringAnimation(view: self.button)
            
        // Узнать текущий год
        case _ where text.lowercased().contains("год"):
            let year = (Calendar.current.component(.year, from: self.today))
            self.button.setImage(UIImage(named: ""), for: .normal)
            self.button.setTitleColor(.black, for: .normal)
            self.button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            self.button.setTitle("\(year)", for: .normal)
            self.quizBaseViewModel.sayComment(comment: "\(year)")
            self.animation.SpringAnimation(view: self.button)
            
        // Открыть камеру
        case _ where text.lowercased().contains("камер"):
            self.icon = "camera.png"
            self.button.setImage(UIImage(named: self.icon), for: .normal)
            self.animation.SpringAnimation(view: self.button)
            self.player.PlaySound(resource: "camera.mp3")
            self.sound = "camera.mp3"
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.quizBaseViewModel.OpenCamera()
            }
            
        // показать экран настроек
        case _ where text.lowercased().contains("настрой"):
            self.icon = "gear.png"
            self.button.setImage(UIImage(named: self.icon), for: .normal)
            self.animation.SpringAnimation(view: self.button)
            self.player.PlaySound(resource: "settings.mp3")
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.performSegue(withIdentifier: "showSettings", sender: nil)
            }
            
        case _ where text.lowercased().contains("закр"):
            self.dismiss(animated: true)
            
        // выключить распознавание речи
        case _ where text.lowercased().contains("cтоп"):
            self.button.sendActions(for: .touchUpInside)
            
        case _ where self.sound != "":
            self.player.StopSound(resource: self.sound)
            
        default:
            break
        }
    }
    
    @objc private func VoiceCommands(_ sender: UIButton) {
        isStart = !isStart
        if isStart {
            player.PlaySound(resource: "click sound.wav")
            button.setImage(UIImage(named: "voice.png"), for: .normal)
            animation.SpringAnimation(view: button)
            speechRecognition.startSpeechRecognition()
            speechRecognition.registerSpeechRecognitionHandler { text in
                self.CheckVoiceCommands(text: text)
            }
        } else {
            player.PlaySound(resource: "pause_sound.mp3")
            button.setImage(UIImage(named: self.currentIcon), for: .normal)
            animation.SpringAnimation(view: button)
            speechRecognition.cancelSpeechRecognition()
        }
    }
}

extension QuizTabBarController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            picker.dismiss(animated: true, completion: nil)
            self.speechRecognition.startSpeechRecognition()
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as?
                UIImage else {
            return
        }
        
        quizCategoriesViewModel.CheckText(image: image)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            picker.dismiss(animated: true, completion: nil)
            self.speechRecognition.startSpeechRecognition()
        }
    }
}
