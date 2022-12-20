//
//  ViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 16.02.2022.
//

import UIKit
import Speech

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
    var fb = FirebaseManager()
    var sound = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quizViewModel.CreateCategories()
        base.viewController = self
        quizViewModel.view = self.view
        quizViewModel.storyboard = self.storyboard
        configureAudioSession()
        selectedIndex = UserDefaults.standard.object(forKey: "index") as? Int ?? 0
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
    }
    
    func configureAudioSession() {
        do {
            try? AVAudioSession.sharedInstance().setCategory(.playAndRecord, mode: .default, policy: .default, options: .mixWithOthers)
        } catch {
            print(error)
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
    
    func tabChangedTo(selectedIndex: Int) {
        UserDefaults.standard.set(selectedIndex, forKey: "index")
        switch selectedIndex {
            
        case 0:
            self.icon = "newspaper.png"
            self.button.setImage(UIImage(named: self.icon), for: .normal)
            self.animation.springButton(button: self.button)
            self.player.PlaySound(resource: "newspaper.mp3")
        case 1:
            self.icon = "newyear.png"
            self.button.setImage(UIImage(named: self.icon), for: .normal)
            self.animation.springButton(button: self.button)
            self.player.PlaySound(resource: "newyear.mp3")
        case 3:
            self.icon = "trophy.png"
            self.button.setImage(UIImage(named: self.icon), for: .normal)
            self.animation.springButton(button: self.button)
            self.player.PlaySound(resource: "league.mp3")
        case 4:
            self.icon = UserDefaults.standard.value(forKey: "url") as? String ?? ""
            self.button.layer.cornerRadius = self.button.frame.width / 2
            self.button.clipsToBounds = true
            self.button.sd_setImage(with: URL(string: self.icon), for: .normal)
            self.animation.springButton(button: self.button)
            self.fb.PlayLastQuizSound()
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
        
        task = (speechReconizer?.recognitionTask(with: request, resultHandler: { [self] (response, error) in
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
                self.player.PlaySound(resource: "newspaper.mp3")
                
            case _ where self.text.contains("Категори") || self.text.contains("категори"):
                self.selectedIndex = 1
                self.icon = "newyear.png"
                self.button.setImage(UIImage(named: self.icon), for: .normal)
                self.animation.springButton(button: self.button)
                self.player.PlaySound(resource: "IQ.mp3")
                
            case _ where self.text.contains("Куб") || self.text.contains("куб"):
                self.selectedIndex = 3
                self.icon = "trophy.png"
                self.button.setImage(UIImage(named: self.icon), for: .normal)
                self.animation.springButton(button: self.button)
                self.player.PlaySound(resource: "league.mp3")
                
            case _ where self.text.contains("Проф") || self.text.contains("проф"):
                self.selectedIndex = 4
                self.icon = UserDefaults.standard.value(forKey: "url") as? String ?? ""
                self.button.layer.cornerRadius = self.button.frame.width / 2
                self.button.clipsToBounds = true
                self.button.sd_setImage(with: URL(string: self.icon), for: .normal)
                self.animation.springButton(button: self.button)
                self.fb.PlayLastQuizSound()
             
            // выбор категории викторины
            case _ where self.text != "":
                for i in 0...5 {
                    for value in quizViewModel.categories[i].categories {
                        if text.lowercased().contains(value.voiceCommand) {
                            self.icon = value.image
                            self.button.setImage(UIImage(named: self.icon), for: .normal)
                            self.animation.springButton(button: self.button)
                            self.player.PlaySound(resource: value.sound)
                            self.sound = value.sound
                            self.quizViewModel.GoToStart(quiz: value.base, category: value)
                        }
                    }
                }
                
            // Включение/Выключение музыки
            case _ where self.text.contains("Муз") || self.text.contains("муз"):
                self.icon = "newyear.png"
                self.button.setImage(UIImage(named: self.icon), for: .normal)
                self.sound = "newyear music.mp3"
                self.player.PlaySound(resource: self.sound)
                self.animation.StartRotateImage(image: self.button.imageView!)
                
            case _ where self.text.contains("Выкл") || self.text.contains("выкл"):
                self.icon = "voice.png"
                self.button.setImage(UIImage(named: self.icon), for: .normal)
                self.player.StopSound(resource: self.sound)
                self.animation.StopRotateImage(image: self.button.imageView!)
                
            // Узнать текущее время
            case _ where self.text.contains("Врем") || self.text.contains("врем"):
                let hours   = (Calendar.current.component(.hour, from: self.today))
                let minutes = (Calendar.current.component(.minute, from: self.today))
                
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
                
            // Открыть камеру
            case _ where self.text.contains("Камер") || self.text.contains("камер"):
                self.icon = "camera.png"
                self.button.setImage(UIImage(named: self.icon), for: .normal)
                self.animation.springButton(button: self.button)
                self.player.PlaySound(resource: "camera.mp3")
                self.sound = "camera.mp3"
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.base.OpenCamera()
                }
                
            // показать экран настроек
            case _ where self.text.contains("Настрой") || self.text.contains("настрой"):
                self.icon = "gear.png"
                self.button.setImage(UIImage(named: self.icon), for: .normal)
                self.animation.springButton(button: self.button)
                self.player.PlaySound(resource: "settings.mp3")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.performSegue(withIdentifier: "showSettings", sender: nil)
                }
                
            case _ where self.text.contains("Закр") || self.text.contains("закр"):
                self.dismiss(animated: true)
                
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
        audioEngine.stop()
        task?.cancel()
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
            self.icon = "newyear.png"
            button.setImage(UIImage(named: self.icon), for: .normal)
            animation.springButton(button: button)
            cancelSpeechRecognization()
        }
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
        
        quizViewModel.recognizeText(image: image)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            picker.dismiss(animated: true, completion: nil)
            self.startSpeechRecognization()
        }
    }
}

