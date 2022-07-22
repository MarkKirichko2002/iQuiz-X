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
    let button = UIButton.init(type: .custom)
    var text = ""
    let audioEngine = AVAudioEngine()
    let speechReconizer = SFSpeechRecognizer(locale: Locale.init(identifier: "ru-RU"))
    let request = SFSpeechAudioBufferRecognitionRequest()
    var task: SFSpeechRecognitionTask?
  
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
    
    @objc func startSpeechRecognization(_ sender: UIButton){
        
        let node = audioEngine.inputNode
        let recordingFormat = node.outputFormat(forBus: 0)
        
        switch sender.isSelected {
            
        case false:
            
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
                
                if self.text.contains("Стоп")  || self.text.contains("стоп") {
                    self.cancelSpeechRecognization()
                }
                
                if self.text.contains("Игроков")  || self.text.contains("игроков") {
                    self.selectedIndex = 3
                }
                
                if self.text.contains("Профиль")  || self.text.contains("профиль") {
                    self.selectedIndex = 4
                }
                
            }))
            
        case true:
            cancelSpeechRecognization()
        }
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.setImage(UIImage(named: "quiz"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        button.layer.borderWidth = 2
        self.view.insertSubview(button, aboveSubview: self.tabBar)
        button.addTarget(self, action:  #selector(ViewController.startSpeechRecognization(_:)), for: .touchUpInside)
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


