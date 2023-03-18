//
//  QuizTabBarController.swift
//  QUIZ
//
//  Created by Марк Киричко on 16.02.2022.
//

import UIKit
import Speech

final class QuizTabBarController: UITabBarController {
    
    private let player = SoundClass()
    private let button = UIButton()
    private var text = ""
    private let audioEngine = AVAudioEngine()
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ru_RU"))
    private let request = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask: SFSpeechRecognitionTask?
    private let quizCategoriesViewModel = QuizCategoriesViewModel()
    private var isStart: Bool = false
    private var icon = "voice.png"
    private var quizBaseViewModel = QuizBaseViewModel()
    private let animation = AnimationClass()
    private let speechRecognitionManager = SpeechRecognitionManager()
    private let today = Date()
    private var firebaseManager = FirebaseManager()
    private var sound = ""
    
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
        self.cancelSpeechRecognization()
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
    
    func tabChangedTo(selectedIndex: Int) {
        UserDefaults.standard.set(selectedIndex, forKey: "index")
        switch selectedIndex {
            
        case 0:
            self.icon = "newspaper.png"
            self.button.setImage(UIImage(named: self.icon), for: .normal)
            self.animation.springButton(button: self.button)
            self.player.PlaySound(resource: "newspaper.mp3")
        case 1:
            self.icon = "astronomy.png"
            self.button.setImage(UIImage(named: self.icon), for: .normal)
            self.animation.springButton(button: self.button)
            self.player.PlaySound(resource: "IQ.mp3")
        case 3:
            self.icon = "trophy.png"
            self.button.setImage(UIImage(named: self.icon), for: .normal)
            self.animation.springButton(button: self.button)
            self.player.PlaySound(resource: "league.mp3")
        case 4:
            self.icon = UserDefaults.standard.value(forKey: "url") as? String ?? "https://cdn-icons-png.flaticon.com/512/3637/3637624.png"
            self.button.layer.cornerRadius = self.button.frame.width / 2
            self.button.clipsToBounds = true
            self.button.sd_setImage(with: URL(string: self.icon), for: .normal)
            self.animation.springButton(button: self.button)
            self.firebaseManager.PlayLastQuizSound()
        default:
            break
        }
    }
    
    func startSpeechRecognization() {
        
        let node = audioEngine.inputNode
        let recognitionFormat = node.outputFormat(forBus: 0)
        
        node.installTap(onBus: 0, bufferSize: 1024, format: recognitionFormat) {
            [unowned self](buffer, audioTime) in
            self.request.append(buffer)
        }
        
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch let error {
            print("\(error.localizedDescription)")
        }
        
        recognitionTask = speechRecognizer?.recognitionTask(with: request, resultHandler: {
            [unowned self] (result, error) in
            if let res = result?.bestTranscription {
                DispatchQueue.main.async {
                    self.text = res.formattedString
                    print(self.text)
                    self.CheckVoiceCommands(text: self.text)
                }
                
            } else if let error = error {
                print("\(error.localizedDescription)")
            }
        })
    }
    
    func CheckVoiceCommands(text: String) {
        
        switch text {
            
        // Навигация по приложению
        case _ where text.contains("Новост") || self.text.contains("новост"):
            self.selectedIndex = 0
            icon = "newspaper.png"
            button.setImage(UIImage(named: self.icon), for: .normal)
            animation.springButton(button: self.button)
            player.PlaySound(resource: "newspaper.mp3")
            
            self.cancelSpeechRecognization()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.startSpeechRecognization()
            }
            
        case _ where selectedIndex == 0  && text.lowercased().contains("категори"):
            if text.lowercased().contains("техно") {
                NewsListViewModel().GetNews(category: .technology)
                self.icon = "technology"
                self.button.setImage(UIImage(named: self.icon), for: .normal)
                self.animation.springButton(button: self.button)
                self.player.PlaySound(resource: "technology.wav")
                self.cancelSpeechRecognization()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.startSpeechRecognization()
                }
            } else if text.lowercased().contains("спорт") {
                NewsListViewModel().GetNews(category: .sport)
                self.icon = "sport.jpeg"
                self.button.setImage(UIImage(named: self.icon), for: .normal)
                self.animation.springButton(button: self.button)
                self.player.PlaySound(resource: "sport.mp3")
                self.cancelSpeechRecognization()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.startSpeechRecognization()
                }
            } else if text.lowercased().contains("бизнес") {
                NewsListViewModel().GetNews(category: .business)
                self.icon = "business"
                self.button.setImage(UIImage(named: self.icon), for: .normal)
                self.animation.springButton(button: self.button)
                self.player.PlaySound(resource: "economics.mp3")
                self.cancelSpeechRecognization()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.startSpeechRecognization()
                }
            } else if text.lowercased().contains("топ") {
                NewsListViewModel().GetNews(category: .general)
                self.icon = "newspaper"
                self.button.setImage(UIImage(named: self.icon), for: .normal)
                self.animation.springButton(button: self.button)
                self.player.PlaySound(resource: "newspaper.mp3")
                self.cancelSpeechRecognization()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.startSpeechRecognization()
                }
            } else {
                
            }
        
        case _ where text.lowercased().contains("викторин"):
            self.selectedIndex = 1
            self.icon = "astronomy.png"
            self.button.setImage(UIImage(named: self.icon), for: .normal)
            self.animation.springButton(button: self.button)
            self.player.PlaySound(resource: "IQ.mp3")
            
            self.cancelSpeechRecognization()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.startSpeechRecognization()
            }
            
        case _ where text.lowercased().contains("категори"):
            if text.lowercased().contains("последняя") {
                firebaseManager.LoadLastQuizCategoryData { category in
                    self.icon = category.icon
                    self.button.setImage(UIImage(named: self.icon), for: .normal)
                    self.animation.springButton(button: self.button)
                    self.player.PlaySound(resource: category.sound)
                }
                self.cancelSpeechRecognization()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.startSpeechRecognization()
                }
            }
            
            for i in 0...5 {
                for value in self.quizCategoriesViewModel.categories[i].categories {
                    if text.lowercased().contains("какой счёт у категории \(value.name)") {
                        firebaseManager.LoadQuizCategoriesData(quizpath: value.quizpath) { category in
                            var seconds = 2
                            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                                self.icon = value.image
                                self.button.setImage(UIImage(named: self.icon), for: .normal)
                                self.animation.springButton(button: self.button)
                                self.player.PlaySound(resource: value.sound)
                                seconds -= 1
                                if seconds == 0 {
                                    timer.invalidate()
                                    DispatchQueue.main.async {
                                        self.button.setImage(UIImage(named: ""), for: .normal)
                                        self.button.setTitleColor(.black, for: .normal)
                                        self.button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
                                        self.button.setTitle("\(category.score)", for: .normal)
                                        self.animation.springButton(button: self.button)
                                    }
                                }
                            }
                        }
                        self.cancelSpeechRecognization()
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.startSpeechRecognization()
                        }
                    }
                }
            }
            
        case _ where text.lowercased().contains("куб"):
            self.selectedIndex = 3
            self.icon = "trophy.png"
            self.button.setImage(UIImage(named: self.icon), for: .normal)
            self.animation.springButton(button: self.button)
            self.player.PlaySound(resource: "league.mp3")
            
            self.cancelSpeechRecognization()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.startSpeechRecognization()
            }
            
        case _ where text.lowercased().contains("проф"):
            self.selectedIndex = 4
            self.icon = UserDefaults.standard.value(forKey: "url") as? String ?? "https://cdn-icons-png.flaticon.com/512/3637/3637624.png"
            self.button.layer.cornerRadius = self.button.frame.width / 2
            self.button.clipsToBounds = true
            self.button.sd_setImage(with: URL(string: self.icon), for: .normal)
            self.animation.springButton(button: self.button)
            self.firebaseManager.PlayLastQuizSound()
            
            self.cancelSpeechRecognization()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.startSpeechRecognization()
            }
         
        // выбор категории викторины
        case _ where text != "":
            for i in 0...5 {
                for value in self.quizCategoriesViewModel.categories[i].categories {
                    if self.text.lowercased().contains(value.voiceCommand) {
                        DispatchQueue.main.async {
                            self.icon = value.image
                            self.button.setImage(UIImage(named: self.icon), for: .normal)
                            self.animation.springButton(button: self.button)
                            self.player.PlaySound(resource: value.sound)
                            self.sound = value.sound
                            self.quizCategoriesViewModel.GoToStart(quiz: value.base, category: value)
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
            self.animation.StartRotateImage(image: self.button.imageView!)
            
        case _ where text.lowercased().contains("выкл"):
            self.icon = "voice.png"
            self.button.setImage(UIImage(named: self.icon), for: .normal)
            self.player.StopSound(resource: self.sound)
            self.animation.StopRotateImage(image: self.button.imageView!)
            
        // Узнать текущее время
        case _ where text.lowercased().contains("врем"):
            let hours   = (Calendar.current.component(.hour, from: self.today))
            let minutes = (Calendar.current.component(.minute, from: self.today))
            
            self.button.setImage(UIImage(named: ""), for: .normal)
            self.button.setTitleColor(.black, for: .normal)
            self.button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            self.button.setTitle("\(hours):\(minutes)", for: .normal)
            self.quizBaseViewModel.sayComment(comment: "\(hours):\(minutes)")
            self.animation.springButton(button: self.button)
            
        // Узнать текущий год
        case _ where text.lowercased().contains("год"):
            let year = (Calendar.current.component(.year, from: self.today))
            self.button.setImage(UIImage(named: ""), for: .normal)
            self.button.setTitleColor(.black, for: .normal)
            self.button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            self.button.setTitle("\(year)", for: .normal)
            self.quizBaseViewModel.sayComment(comment: "\(year)")
            self.animation.springButton(button: self.button)
            
        // Открыть камеру
        case _ where text.lowercased().contains("камер"):
            self.icon = "camera.png"
            self.button.setImage(UIImage(named: self.icon), for: .normal)
            self.animation.springButton(button: self.button)
            self.player.PlaySound(resource: "camera.mp3")
            self.sound = "camera.mp3"
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.quizBaseViewModel.OpenCamera()
            }
            
        // показать экран настроек
        case _ where text.lowercased().contains("настрой"):
            self.icon = "gear.png"
            self.button.setImage(UIImage(named: self.icon), for: .normal)
            self.animation.springButton(button: self.button)
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
    
    func cancelSpeechRecognization(){
        audioEngine.stop()
        recognitionTask?.cancel()
        request.endAudio()
        audioEngine.inputNode.removeTap(onBus: 0)
    }
    
    @objc func VoiceCommands(_ sender: UIButton) {
        isStart = !isStart
        if isStart {
            player.PlaySound(resource: "click sound.wav")
            button.setImage(UIImage(named: "voice.png"), for: .normal)
            animation.springButton(button: button)
            startSpeechRecognization()
        } else {
            player.PlaySound(resource: "pause_sound.mp3")
            self.icon = "astronomy.png"
            button.setImage(UIImage(named: self.icon), for: .normal)
            animation.springButton(button: button)
            cancelSpeechRecognization()
        }
    }
}

extension QuizTabBarController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            picker.dismiss(animated: true, completion: nil)
            self.startSpeechRecognization()
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
            self.startSpeechRecognization()
        }
    }
}
