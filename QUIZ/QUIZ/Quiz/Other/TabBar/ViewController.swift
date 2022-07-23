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
        
    }
    
    func startSpeechRecognization(){
        
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
            
            let lastString: String = ""
            for segment in response.bestTranscription.segments {
                let indexTo = message.index(message.startIndex, offsetBy: segment.substringRange.location)
                //lastString = String(message[indexTo...])
                self.text = String(message[indexTo...])
            }
            
            
            if self.text.contains("Новости")  || self.text.contains("новости") {
                self.selectedIndex = 0
            }
            
            if self.text.contains("Категории")  || self.text.contains("категории") {
                self.selectedIndex = 1
            }
            
            if self.text.contains("Игроков")  || self.text.contains("игроков") {
                self.selectedIndex = 3
            }
            
            if self.text.contains("Профиль")  || self.text.contains("профиль") {
                self.selectedIndex = 4
            }
            
            // Выбор категории викторины
            
            if self.text.contains("Планеты")  || self.text.contains("планеты") {
                self.quizViewModel.goToQuize(quiz: QuizPlanets(), storyboard: self.storyboard, view: self.view)
                self.cancelSpeechRecognization()
            }
            
            if self.text.contains("История")  || self.text.contains("история") {
                self.quizViewModel.goToQuize(quiz: QuizHistory(), storyboard: self.storyboard, view: self.view)
                self.cancelSpeechRecognization()
            }
            
            if self.text.contains("Анатомия")  || self.text.contains("анатомия") {
                self.quizViewModel.goToQuize(quiz: QuizAnatomy(), storyboard: self.storyboard, view: self.view)
                self.cancelSpeechRecognization()
            }
            
            if self.text.contains("Спорт")  || self.text.contains("спорт") {
                self.quizViewModel.goToQuize(quiz: QuizSport(), storyboard: self.storyboard, view: self.view)
                self.cancelSpeechRecognization()
            }
            
            if self.text.contains("Игры")  || self.text.contains("игры") {
                self.quizViewModel.goToQuize(quiz: QuizGames(), storyboard: self.storyboard, view: self.view)
                self.cancelSpeechRecognization()
            }
            
            if self.text.contains("Интеллект")  || self.text.contains("интеллект") {
                self.quizViewModel.goToQuize(quiz: QuizIQ(), storyboard: self.storyboard, view: self.view)
                self.cancelSpeechRecognization()
            }
            
            if self.text.contains("Экономика")  || self.text.contains("экономика") {
                self.quizViewModel.goToQuize(quiz: QuizEconomy(), storyboard: self.storyboard, view: self.view)
                self.cancelSpeechRecognization()
            }
            
            if self.text.contains("География")  || self.text.contains("география") {
                self.quizViewModel.goToQuize(quiz: QuizGeography(), storyboard: self.storyboard, view: self.view)
                self.cancelSpeechRecognization()
            }
            
            if self.text.contains("Экология")  || self.text.contains("экология") {
                self.quizViewModel.goToQuize(quiz: QuizEcology(), storyboard: self.storyboard, view: self.view)
                self.cancelSpeechRecognization()
            }
            
            if self.text.contains("Физика")  || self.text.contains("физика") {
                self.quizViewModel.goToQuize(quiz: QuizPhysics(), storyboard: self.storyboard, view: self.view)
                self.cancelSpeechRecognization()
            }
            
            if self.text.contains("Химия")  || self.text.contains("химия") {
                self.quizViewModel.goToQuize(quiz: QuizChemistry(), storyboard: self.storyboard, view: self.view)
                self.cancelSpeechRecognization()
            }
            
            if self.text.contains("Информатика")  || self.text.contains("информатика") {
                self.quizViewModel.goToQuize(quiz: QuizInformatics(), storyboard: self.storyboard, view: self.view)
                self.cancelSpeechRecognization()
            }
            
            if self.text.contains("Литература")  || self.text.contains("литература") {
                self.quizViewModel.goToQuize(quiz: QuizLiterature(), storyboard: self.storyboard, view: self.view)
                self.cancelSpeechRecognization()
            }
            
            if self.text.contains("Дорога")  || self.text.contains("дорога") {
                self.quizViewModel.goToQuize(quiz: QuizRoadTraffic(), storyboard: self.storyboard, view: self.view)
                self.cancelSpeechRecognization()
            }
            
            if self.text.contains("Swift")  || self.text.contains("swift") {
                self.quizViewModel.goToQuize(quiz: QuizSwift(), storyboard: self.storyboard, view: self.view)
                self.cancelSpeechRecognization()
            }
            
            if self.text.contains("Море")  || self.text.contains("море") {
                self.quizViewModel.goToQuize(quiz: QuizUnderwater(), storyboard: self.storyboard, view: self.view)
                self.cancelSpeechRecognization()
            }
            
            if self.text.contains("Шахматы")  || self.text.contains("шахматы") {
                self.quizViewModel.goToQuize(quiz: QuizChess(), storyboard: self.storyboard, view: self.view)
                self.cancelSpeechRecognization()
            }
            
            if self.text.contains("Рандом")  || self.text.contains("рандом") {
                self.quizViewModel.PresentRandomQuiz(storyboard: self.storyboard, view: self.view)
                self.cancelSpeechRecognization()
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
            button.setImage(UIImage(named: "planets.jpeg"), for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.setImage(UIImage(named: "quiz"), for: .normal)
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


