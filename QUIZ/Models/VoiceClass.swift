//
//  VoiceClass.swift
//  QUIZ
//
//  Created by Марк Киричко on 12.03.2022.
//

import Foundation
import UIKit
import Speech
import AVFoundation

class VoiceClass {
    
    var check2 = ""

    var isPlaying = true
    
    var word = ("","")
    
    var player2:AVAudioPlayer?
    
    let audioEngine = AVAudioEngine()
    let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ru_RU"))
    let request = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask: SFSpeechRecognitionTask?
    var button = UIButton()
    
    func voice() {
        CheckChoiceNumber()
        
        
        switch check2 {
            
        case "Стоп":
            sender.isSelected = true
            
        default:
            break
        }
        
        let checkvoice = quiz?.checkAnswer(check2)
        
        
        if !sender.isSelected{
            recognizeButton.setImage(UIImage(systemName: "mic.fill"), for: .normal)
            questionText.text = "Говорите ответ..."
           
        } else {
            recognizeButton.setImage(UIImage(systemName: "mic.slash"), for: .normal)
            questionText.text = ("Вопрос №\(quiz?.checkQuestionNumber() ?? 0) \(quiz?.checkQuestion() ?? "")")
        }
    
        if checkvoice! == true {
            if quiz?.checklevel() == .easy {
                counter += 4
                CorrectAnswersCounter += 1
            } else if quiz?.checklevel() == .normal {
                counter += 11
                CorrectAnswersCounter += 1
            } else if quiz?.checklevel() == .hard {
                counter += 17
                CorrectAnswersCounter += 1
            }
            Score.text = ("Счет: \(CorrectAnswersCounter)")
            print("Голос \(check2)")
            
            quiz?.nextQuestion()
            write()
            
            player.Sound(resource: "victory_sound.mp3")
            
            SCLAlertView().showCustom("правильно", subTitle: check2, color: .systemGreen, icon: UIImage(systemName: "person" ?? "")!, closeButtonTitle: "далее", timeout: .none, colorStyle: UInt.max, colorTextButton: UInt.max, circleIconImage: UIImage(systemName: "person"), animationStyle: .topToBottom)
            Timer.scheduledTimer(timeInterval:0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
        }
        
        
        if checkvoice! == false {
            print("Голос \(check2)")
            counter
            Score.text = ("Счет: \(String(counter))")
            print(checkvoice)
            Attempts.text = "Попыток осталось: \(AttemptsCounter)"
            write()
        }
        
        //configure player
        guard let url = Bundle.main.url(forResource: word.0, withExtension: "mp3") else { return }
        player2 = try? AVAudioPlayer(contentsOf: url)
        
        //configure speech recogniton
        SFSpeechRecognizer.requestAuthorization {[unowned self] (status) in
            switch status {
            case .authorized:
                DispatchQueue.main.async {
                    [unowned self] in
                    self.recognizeButton.isEnabled = true
                }
            case .denied:
                print("statu denied")
            case .notDetermined:
                print("statu not determined")
            case .restricted:
                print("statu restricted")
            }
        }
        
        if sender.isSelected {
            audioEngine.stop()
            request.endAudio()
            recognitionTask?.cancel()
            audioEngine.inputNode.removeTap(onBus: 0)
        } else {
            startRecognition()
            //audioEngine.inputNode.removeTap(onBus: 0)
        }
        
        button.isSelected = !button.isSelected
    }
    
    
    fileprivate func startRecognition () {
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
            return
        }
        
        recognitionTask = speechRecognizer?.recognitionTask(with: request, resultHandler: {
            [unowned self] (result, error) in
            if let res = result?.bestTranscription {
                DispatchQueue.main.async { [unowned self] in
                    check2 = res.formattedString

                }
            } else if let error = error {
                print("\(error.localizedDescription)")
            }
        })
    }
    
    
    
    
    
}
