//
//  ViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 16.02.2022.
//

import UIKit
import Speech
import SCLAlertView

class ViewController: UITabBarController {
    
    var player = SoundClass()
    let button = UIButton()
    var text = ""
    let audioEngine = AVAudioEngine()
    let speechReconizer = SFSpeechRecognizer(locale: Locale.init(identifier: "ru-RU"))
    let request = SFSpeechAudioBufferRecognitionRequest()
    var task: SFSpeechRecognitionTask?
    var quizViewModel = CategoriesViewModel()
    var isStart : Bool = false
    var icon = "voice.png"
    var base = QuizBaseViewModel()
    var animation = AnimationClass()
    let today = Date()
    var fb = FBAuth()
    var sound = ""
    
    func configureAudioSession() {
        
        do {
            try? AVAudioSession.sharedInstance().setCategory(.playAndRecord, mode: .default, policy: .default, options: .defaultToSpeaker)
        } catch  {
            
        }
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
    
    // handle new selection
    func tabChangedTo(selectedIndex: Int) {
        UserDefaults.standard.set(selectedIndex, forKey: "index")
        switch selectedIndex {
            
        case 0:
            self.icon = "newspaper.png"
            self.button.setImage(UIImage(named: self.icon), for: .normal)
            self.animation.springButton(button: self.button)
        case 1:
            self.icon = "planets.jpeg"
            self.button.setImage(UIImage(named: self.icon), for: .normal)
            self.animation.springButton(button: self.button)
        case 3:
            self.icon = "trophy.png"
            self.button.setImage(UIImage(named: self.icon), for: .normal)
            self.animation.springButton(button: self.button)
        case 4:
            self.icon = UserDefaults.standard.value(forKey: "url") as? String ?? ""
            self.button.layer.cornerRadius = self.button.frame.width / 2
            self.button.clipsToBounds = true
            self.button.sd_setImage(with: URL(string: self.icon), for: .normal)
            self.animation.springButton(button: self.button)
        default:
            break
            
        }
    }
    
    func startSpeechRecognization() {
        
        let node = audioEngine.inputNode
        let recordingFormat = node.outputFormat(forBus: 0)
        
        button.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, _) in
            self.request.append(buffer)
        }
        
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch let error {
            print("Error comes here for starting the audio listner =\(error.localizedDescription)")
        }
        
        guard let myRecognization = SFSpeechRecognizer() else {
            print("Recognization is not allow on your local")
            return
        }
        
        if !myRecognization.isAvailable {
            print("Recognization is free right now, Please try again after some time.")
        }
        
        task = (speechReconizer?.recognitionTask(with: request, resultHandler: { (response, error) in
            guard let response = response else {
                if error != nil {
                    print(error.debugDescription)
                } else {
                    print("Problem in giving the response")
                }
                return
            }
            
            let message = response.bestTranscription.formattedString
            print("Message : \(message)")
            self.text = message
            
            for segment in response.bestTranscription.segments {
                let indexTo = message.index(message.startIndex, offsetBy: segment.substringRange.location)
                self.text = String(message[indexTo...])
            }
            
            switch self.text {
                
            // Навигация по приложению
            case _ where self.text.contains("Новост") || self.text.contains("новост"):
                self.selectedIndex = 0
                self.icon = "newspaper.png"
                self.button.setImage(UIImage(named: self.icon), for: .normal)
                self.animation.springButton(button: self.button)
                
            case _ where self.text.contains("Категори") || self.text.contains("категори"):
                self.selectedIndex = 1
                self.icon = "planets.jpeg"
                self.button.setImage(UIImage(named: self.icon), for: .normal)
                self.animation.springButton(button: self.button)
                
            case _ where self.text.contains("Куб") || self.text.contains("куб"):
                self.selectedIndex = 3
                self.icon = "trophy.png"
                self.button.setImage(UIImage(named: self.icon), for: .normal)
                self.animation.springButton(button: self.button)
                
            case _ where self.text.contains("Проф") || self.text.contains("проф"):
                self.selectedIndex = 4
                self.icon = UserDefaults.standard.value(forKey: "url") as? String ?? ""
                self.button.layer.cornerRadius = self.button.frame.width / 2
                self.button.clipsToBounds = true
                self.button.sd_setImage(with: URL(string: self.icon), for: .normal)
                self.animation.springButton(button: self.button)
                
            // Выбор категории викторины
            case _ where self.text.contains("Планет") || self.text.contains("планет") || self.text.contains("Космос") || self.text.contains("космос"):
                self.icon = "planets.jpeg"
                self.button.setImage(UIImage(named: self.icon), for: .normal)
                self.animation.springButton(button: self.button)
                self.player.Sound(resource: "space.wav")
                self.sound = "space.wav"
                self.quizViewModel.GoToStart(quiz: QuizPlanets(), storyboard: self.storyboard, view: self.view)
                
            case _ where self.text.contains("Истори") || self.text.contains("истори"):
                self.icon = "history.jpeg"
                self.button.setImage(UIImage(named: self.icon), for: .normal)
                self.animation.springButton(button: self.button)
                self.player.Sound(resource: "history.wav")
                self.sound = "history.wav"
                self.quizViewModel.GoToStart(quiz: QuizHistory(), storyboard: self.storyboard, view: self.view)
                
            case _ where self.text.contains("Анатоми") || self.text.contains("анатоми"):
                self.icon = "anatomy.jpeg"
                self.button.setImage(UIImage(named: self.icon), for: .normal)
                self.animation.springButton(button: self.button)
                self.player.Sound(resource: "anatomy.mp3")
                self.sound = "anatomy.mp3"
                self.quizViewModel.GoToStart(quiz: QuizAnatomy(), storyboard: self.storyboard, view: self.view)
                
            case _ where self.text.contains("Спорт") || self.text.contains("спорт"):
                self.icon = "sport.jpeg"
                self.button.setImage(UIImage(named: self.icon), for: .normal)
                self.animation.springButton(button: self.button)
                self.player.Sound(resource: "sport.wav")
                self.sound = "sport.wav"
                self.quizViewModel.GoToStart(quiz: QuizSport(), storyboard: self.storyboard, view: self.view)
                
            case _ where self.text.contains("Игр") || self.text.contains("игр"):
                self.icon = "games.jpeg"
                self.button.setImage(UIImage(named: self.icon), for: .normal)
                self.animation.springButton(button: self.button)
                self.player.Sound(resource: "games.mp3")
                self.sound = "games.mp3"
                self.quizViewModel.GoToStart(quiz: QuizGames(), storyboard: self.storyboard, view: self.view)
                
            case _ where self.text.contains("Интеллект") || self.text.contains("интеллект"):
                self.icon = "IQ.jpeg"
                self.button.setImage(UIImage(named: self.icon), for: .normal)
                self.animation.springButton(button: self.button)
                self.player.Sound(resource: "IQ.mp3")
                self.sound = "IQ.mp3"
                self.quizViewModel.GoToStart(quiz: QuizIQ(), storyboard: self.storyboard, view: self.view)
                
            case _ where self.text.contains("Эконом") || self.text.contains("эконом"):
                self.icon = "economy.jpeg"
                self.button.setImage(UIImage(named: self.icon), for: .normal)
                self.animation.springButton(button: self.button)
                self.player.Sound(resource: "economics.mp3")
                self.sound = "economics.mp3"
                self.quizViewModel.GoToStart(quiz: QuizEconomy(), storyboard: self.storyboard, view: self.view)
                
            case _ where self.text.contains("Географи") || self.text.contains("географи"):
                self.icon = "geography.jpeg"
                self.button.setImage(UIImage(named: self.icon), for: .normal)
                self.animation.springButton(button: self.button)
                self.player.Sound(resource: "geography.mp3")
                self.sound = "geography.mp3"
                self.quizViewModel.GoToStart(quiz: QuizGeography(), storyboard: self.storyboard, view: self.view)
                
            case _ where self.text.contains("Экологи") || self.text.contains("экологи"):
                self.icon = "ecology.jpeg"
                self.button.setImage(UIImage(named: self.icon), for: .normal)
                self.animation.springButton(button: self.button)
                self.player.Sound(resource: "ecology.wav")
                self.sound = "ecology.wav"
                self.quizViewModel.GoToStart(quiz: QuizEcology(), storyboard: self.storyboard, view: self.view)
                
            case _ where self.text.contains("Физ") || self.text.contains("физ"):
                self.icon = "physics.jpeg"
                self.button.setImage(UIImage(named: self.icon), for: .normal)
                self.animation.springButton(button: self.button)
                self.player.Sound(resource: "physics.mp3")
                self.sound = "physics.mp3"
                self.quizViewModel.GoToStart(quiz: QuizPhysics(), storyboard: self.storyboard, view: self.view)
                
            case _ where self.text.contains("Хим") || self.text.contains("хим"):
                self.icon = "chemistry.jpeg"
                self.button.setImage(UIImage(named: self.icon), for: .normal)
                self.animation.springButton(button: self.button)
                self.player.Sound(resource: "chemistry.mp3")
                self.sound = "chemistry.mp3"
                self.quizViewModel.GoToStart(quiz: QuizChemistry(), storyboard: self.storyboard, view: self.view)
                
            case _ where self.text.contains("Информа") || self.text.contains("информа"):
                self.icon = "informatics.jpeg"
                self.button.setImage(UIImage(named: self.icon), for: .normal)
                self.animation.springButton(button: self.button)
                self.player.Sound(resource: "informatics.mp3")
                self.sound = "informatics.mp3"
                self.quizViewModel.GoToStart(quiz: QuizInformatics(), storyboard: self.storyboard, view: self.view)
                
            case _ where self.text.contains("Литера") || self.text.contains("литера"):
                self.icon = "literature.jpeg"
                self.button.setImage(UIImage(named: self.icon), for: .normal)
                self.animation.springButton(button: self.button)
                self.player.Sound(resource: "literature.mp3")
                self.sound = "literature.mp3"
                self.quizViewModel.GoToStart(quiz: QuizLiterature(), storyboard: self.storyboard, view: self.view)
                
            case _ where self.text.contains("Дорог") || self.text.contains("дорог"):
                self.icon = "drive.jpeg"
                self.button.setImage(UIImage(named: self.icon), for: .normal)
                self.animation.springButton(button: self.button)
                self.player.Sound(resource: "roadtraffic.mp3")
                self.sound = "roadtraffic.mp3"
                self.quizViewModel.GoToStart(quiz: QuizRoadTraffic(), storyboard: self.storyboard, view: self.view)
                
            case _ where self.text.contains("Swift") || self.text.contains("swift"):
                self.icon = "swift.jpeg"
                self.button.setImage(UIImage(named: self.icon), for: .normal)
                self.animation.springButton(button: self.button)
                self.player.Sound(resource: "swift.mp3")
                self.sound = "swift.mp3"
                self.quizViewModel.GoToStart(quiz: QuizSwift(), storyboard: self.storyboard, view: self.view)
                
            case _ where self.text.contains("Мор") || self.text.contains("мор"):
                self.icon = "underwater.png"
                self.button.setImage(UIImage(named: self.icon), for: .normal)
                self.animation.springButton(button: self.button)
                self.player.Sound(resource: "underwater.wav")
                self.sound = "underwater.wav"
                self.quizViewModel.GoToStart(quiz: QuizUnderwater(), storyboard: self.storyboard, view: self.view)
                
            case _ where self.text.contains("Шахмат") || self.text.contains("шахмат"):
                self.icon = "chess.png"
                self.button.setImage(UIImage(named: self.icon), for: .normal)
                self.animation.springButton(button: self.button)
                self.player.Sound(resource: "chess.mp3")
                self.sound = "chess.mp3"
                self.quizViewModel.GoToStart(quiz: QuizChess(), storyboard: self.storyboard, view: self.view)
                
            case _ where self.text.contains("Halloween") || self.text.contains("halloween"):
                self.icon = "halloween.png"
                self.button.setImage(UIImage(named: self.icon), for: .normal)
                self.animation.springButton(button: self.button)
                self.player.Sound(resource: "halloween.wav")
                self.sound = "halloween.wav"
                self.quizViewModel.GoToStart(quiz: QuizHalloween(), storyboard: self.storyboard, view: self.view)
                
            case _ where self.text.contains("Рандом") || self.text.contains("рандом"):
                self.icon = "random.jpeg"
                self.button.setImage(UIImage(named: self.icon), for: .normal)
                self.animation.springButton(button: self.button)
                self.player.Sound(resource: "dice.wav")
                self.sound = "dice.wav"
                self.quizViewModel.PresentRandomQuiz(storyboard: self.storyboard, view: self.view)
                
            // Включение/Выключение музыки
            case _ where self.text.contains("Муз") || self.text.contains("муз"):
                self.icon = "halloween.png"
                self.button.setImage(UIImage(named: self.icon), for: .normal)
                self.player.Sound(resource: "halloween music.mp3")
                self.animation.StartRotateImage(image: self.button.imageView!)
                
            case _ where self.text.contains("Выкл") || self.text.contains("выкл"):
                self.icon = "voice.png"
                self.button.setImage(UIImage(named: self.icon), for: .normal)
                self.player.StopSound(resource: "halloween music.mp3")
                self.animation.StopRotateImage(image: self.button.imageView!)
                
            // Узнать текущее время
            case _ where self.text.contains("Врем") || self.text.contains("врем"):
                let hours   = (Calendar.current.component(.hour, from: self.today))
                let minutes = (Calendar.current.component(.minute, from: self.today))
                let day = (Calendar.current.component(.day, from: self.today))
                
                self.button.setImage(UIImage(named: ""), for: .normal)
                self.button.setTitleColor(.black, for: .normal)
                self.button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
                self.button.setTitle("\(hours):\(minutes)", for: .normal)
                self.base.sayComment(comment: "\(hours):\(minutes)")
                self.animation.springButton(button: self.button)
                
            // Узнать текущий год
            case _ where self.text.contains("Год") || self.text.contains("год"):
                let year = (Calendar.current.component(.year, from: self.today))
                self.button.setImage(UIImage(named: ""), for: .normal)
                self.button.setTitleColor(.black, for: .normal)
                self.button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
                self.button.setTitle("\(year)", for: .normal)
                self.base.sayComment(comment: "\(year)")
                self.animation.springButton(button: self.button)
                
            // выключить распознавание речи
            case _ where self.text.contains("Стоп") || self.text.contains("стоп"):
                self.button.sendActions(for: .touchUpInside)
              
            case _ where self.sound != "":
                self.player.StopSound(resource: self.sound)
                
            default:
                break
            }
        }))
    }
    
    
    func cancelSpeechRecognization(){
        audioEngine.stop() //AVAudioEngine()
        task?.cancel() //speechRecognizer?.recognitionTask
        request.endAudio()  //SFSpeechAudioBufferRecognitionRequest?
        audioEngine.inputNode.removeTap(onBus: 0)
    }
    
    @objc func VoiceCommands(_ sender: UIButton) {
        isStart = !isStart
        if isStart {
            player.Sound(resource: "click sound.wav")
            button.setImage(UIImage(named: "voice.png"), for: .normal)
            animation.springButton(button: button)
            startSpeechRecognization()
        } else {
            player.Sound(resource: "pause_sound.mp3")
            self.icon = "halloween.png"
            button.setImage(UIImage(named: self.icon), for: .normal)
            animation.springButton(button: button)
            cancelSpeechRecognization()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAudioSession()
        selectedIndex = UserDefaults.standard.object(forKey: "index") as? Int ?? 0
        button.setImage(UIImage(named: "halloween.png"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        button.layer.borderWidth = 2
        self.view.insertSubview(button, aboveSubview: self.tabBar)
        button.addTarget(self, action:  #selector(ViewController.VoiceCommands(_:)), for: .touchUpInside)
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
        player.Sound(resource: "future click sound.wav")
    }
}
