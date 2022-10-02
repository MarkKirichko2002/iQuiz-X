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
            
            // Навигация по приложению
            if self.text.contains("Новост")  || self.text.contains("новост") {
                self.selectedIndex = 0
            }
            
            if self.text.contains("Категори")  || self.text.contains("категори") {
                self.selectedIndex = 1
            }
            
            if self.text.contains("Куб")  || self.text.contains("куб") {
                self.selectedIndex = 3
            }
            
            if self.text.contains("Проф")  || self.text.contains("проф") {
                self.selectedIndex = 4
            }
            
            // Выбор категории викторины
            
            if self.text.contains("Планет")  || self.text.contains("планет") {
                self.player.Sound(resource: "space.wav")
                self.quizViewModel.GoToStart(quiz: QuizPlanets(), storyboard: self.storyboard, view: self.view)
                self.cancelSpeechRecognization()
            } else if self.text.contains("Космос")  || self.text.contains("космос") {
                self.player.Sound(resource: "space.wav")
                self.quizViewModel.GoToStart(quiz: QuizPlanets(), storyboard: self.storyboard, view: self.view)
                self.cancelSpeechRecognization()
            }
            
            if self.text.contains("Истори")  || self.text.contains("истори") {
                self.player.Sound(resource: "history.wav")
                self.quizViewModel.GoToStart(quiz: QuizHistory(), storyboard: self.storyboard, view: self.view)
                self.cancelSpeechRecognization()
            }
            
            if self.text.contains("Анатоми")  || self.text.contains("анатоми") {
                self.player.Sound(resource: "anatomy.mp3")
                self.quizViewModel.GoToStart(quiz: QuizAnatomy(), storyboard: self.storyboard, view: self.view)
                self.cancelSpeechRecognization()
            }
            
            if self.text.contains("Спорт")  || self.text.contains("спорт") {
                self.player.Sound(resource: "sport.wav")
                self.quizViewModel.GoToStart(quiz: QuizSport(), storyboard: self.storyboard, view: self.view)
                self.cancelSpeechRecognization()
            }
            
            if self.text.contains("Игр")  || self.text.contains("игр") {
                self.player.Sound(resource: "games.mp3")
                self.quizViewModel.GoToStart(quiz: QuizGames(), storyboard: self.storyboard, view: self.view)
                self.cancelSpeechRecognization()
            }
            
            if self.text.contains("Интеллект")  || self.text.contains("интеллект") {
                self.player.Sound(resource: "IQ.mp3")
                self.quizViewModel.GoToStart(quiz: QuizIQ(), storyboard: self.storyboard, view: self.view)
                self.cancelSpeechRecognization()
            }
            
            if self.text.contains("Эконом")  || self.text.contains("эконом") {
                self.player.Sound(resource: "economics.mp3")
                self.quizViewModel.GoToStart(quiz: QuizEconomy(), storyboard: self.storyboard, view: self.view)
                self.cancelSpeechRecognization()
            }
            
            if self.text.contains("Географи")  || self.text.contains("географи") {
                self.player.Sound(resource: "geography.mp3")
                self.quizViewModel.GoToStart(quiz: QuizGeography(), storyboard: self.storyboard, view: self.view)
                self.cancelSpeechRecognization()
            }
            
            if self.text.contains("Экологи")  || self.text.contains("экологи") {
                self.player.Sound(resource: "ecology.wav")
                self.quizViewModel.GoToStart(quiz: QuizEcology(), storyboard: self.storyboard, view: self.view)
                self.cancelSpeechRecognization()
            }
            
            if self.text.contains("Физ")  || self.text.contains("физ") {
                self.player.Sound(resource: "physics.mp3")
                self.quizViewModel.GoToStart(quiz: QuizPhysics(), storyboard: self.storyboard, view: self.view)
                self.cancelSpeechRecognization()
            }
            
            if self.text.contains("Хим")  || self.text.contains("хим") {
                self.player.Sound(resource: "chemistry.mp3")
                self.quizViewModel.GoToStart(quiz: QuizChemistry(), storyboard: self.storyboard, view: self.view)
                self.cancelSpeechRecognization()
            }
            
            if self.text.contains("Информа")  || self.text.contains("информа") {
                self.player.Sound(resource: "informatics.mp3")
                self.quizViewModel.GoToStart(quiz: QuizInformatics(), storyboard: self.storyboard, view: self.view)
                self.cancelSpeechRecognization()
            }
            
            if self.text.contains("Литера")  || self.text.contains("литера") {
                self.player.Sound(resource: "literature.mp3")
                self.quizViewModel.GoToStart(quiz: QuizLiterature(), storyboard: self.storyboard, view: self.view)
                self.cancelSpeechRecognization()
            }
            
            if self.text.contains("Дорог")  || self.text.contains("дорог") {
                self.player.Sound(resource: "roadtraffic.mp3")
                self.quizViewModel.GoToStart(quiz: QuizRoadTraffic(), storyboard: self.storyboard, view: self.view)
                self.cancelSpeechRecognization()
            }
            
            if self.text.contains("Swift")  || self.text.contains("swift") {
                self.player.Sound(resource: "swift.mp3")
                self.quizViewModel.GoToStart(quiz: QuizSwift(), storyboard: self.storyboard, view: self.view)
                self.cancelSpeechRecognization()
            }
            
            if self.text.contains("Мор")  || self.text.contains("мор") {
                self.player.Sound(resource: "underwater.wav")
                self.quizViewModel.GoToStart(quiz: QuizUnderwater(), storyboard: self.storyboard, view: self.view)
                self.cancelSpeechRecognization()
            }
            
            if self.text.contains("Шахмат")  || self.text.contains("шахмат") {
                self.player.Sound(resource: "chess.mp3")
                self.quizViewModel.GoToStart(quiz: QuizChess(), storyboard: self.storyboard, view: self.view)
                self.cancelSpeechRecognization()
            }
            
            if self.text.contains("Halloween")  || self.text.contains("halloween") {
                self.player.Sound(resource: "halloween.wav")
                self.quizViewModel.GoToStart(quiz: QuizHalloween(), storyboard: self.storyboard, view: self.view)
                self.cancelSpeechRecognization()
            }
            
            
            if self.text.contains("Рандом")  || self.text.contains("рандом") {
                self.player.Sound(resource: "dice.wav")
                self.quizViewModel.PresentRandomQuiz(storyboard: self.storyboard, view: self.view)
                self.cancelSpeechRecognization()
            }
            
            // Включение/Выключение музыки
            if self.text.contains("Муз")  || self.text.contains("муз") {
                self.player.Sound(resource: "halloween music.mp3")
            } else if self.text.contains("Выкл")  || self.text.contains("выкл") {
                self.player.StopSound(resource: "halloween music.mp3")
            }
            
        }))
    }
    
    
    func cancelSpeechRecognization(){
        task?.finish()
        task?.cancel()
        task = nil
        
        request.endAudio()
        audioEngine.stop()
        
        if audioEngine.inputNode.numberOfInputs > 0 {
            audioEngine.inputNode.removeTap(onBus: 0)
        }
        
    }
    
    
    @objc func VoiceCommands(_ sender: UIButton) {
        isStart = !isStart
        if isStart {
            startSpeechRecognization()
            button.setImage(UIImage(named: icon), for: .normal)
        } else {
            cancelSpeechRecognization()
            button.setImage(UIImage(named: "halloween.png"), for: .normal)
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
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let barItemView = item.value(forKey: "view") as? UIView else { return }
        
        let timeInterval: TimeInterval = 0.3
        let propertyAnimator = UIViewPropertyAnimator(duration: timeInterval, dampingRatio: 1.5) {
            barItemView.transform = CGAffineTransform.identity.scaledBy(x: 1.5, y: 1.5)
        }
        propertyAnimator.addAnimations({ barItemView.transform = .identity }, delayFactor: CGFloat(timeInterval))
        propertyAnimator.startAnimation()
        player.Sound(resource: "future click sound.wav")
    }
}


