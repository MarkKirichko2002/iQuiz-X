//
//  QuizBase.swift
//  QUIZ
//
//  Created by Марк Киричко on 20.02.2022.
//

import AVFoundation
import Speech
import Vision
import Firebase
import SCLAlertView
import UIKit

class QuizBaseViewModel {
    
    var pl = AVAudioPlayer()
    var music = UserDefaults.standard.object(forKey: "music") as? Bool
    let isAttemptsOn = UserDefaults.standard.object(forKey: "onstatusattempts") as? Bool
    var isRecordOn = UserDefaults.standard.object(forKey: "onstatus") as? Bool
    var isRecordOnAudio = UserDefaults.standard.object(forKey: "onstatusaudio") as? Bool
    var GestureRecording = true
    var VoiceRecording = true
    var HintsStatus = true
    var SpeachStatus = true
    var MusicStatus = true
    var TimerStatus = true
    var AttemptsStatus = true
    var isTalking = false
    let synthesizer = AVSpeechSynthesizer()
    var quiznumber = 0
    var questionNumber = 0;
    var score = 0;
    var sound = ""
    var quiz: QuizModel?
    
    enum RemoteCommand: String {
        case none
        case one = "FIVE-UB-RHand"
        case two = "fist-UB-RHand"
    }
    
    var animation = AnimationClass()
    
    var timer = Timer()
    
    var AnswersCounter = 5
    
    var seconds = 10
    
    var counter = 0
    var AttemptsCounter = 5
    
    var CorrectAnswersCounter = 0
    var UnCorrectAnswersCounter = 0
    
    var player = SoundClass()
    var base: QuizBaseViewModel?
    
    var check2 = ""
    
    var isPlaying = true
    
    var word = ("","")
    
    var player2:AVAudioPlayer?
    
    let audioEngine = AVAudioEngine()
    let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ru_RU"))
    let request = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask: SFSpeechRecognitionTask?
    
    // камера
    let captureSession = AVCaptureSession()
    var captureDevice: AVCaptureDevice!
    var devicePosition: AVCaptureDevice.Position = .front
    
    var requests = [VNRequest]()
    
    let bufferSize = 3
    var commandBuffer = [RemoteCommand]()
    var currentCommand: RemoteCommand = .none {
        didSet {
            commandBuffer.append(currentCommand)
            if commandBuffer.count == bufferSize {
                if commandBuffer.filter({$0 == currentCommand}).count == bufferSize {
                    showAndSendCommand(command: currentCommand)
                    
                }
                commandBuffer.removeAll()
            }
        }
    }
    
    // Binding
    
    // status
    var RecordVideoStatus = QuizBaseObserver("")
    var RecordVideoStatusColor = QuizBaseObserver(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    var OnOffButtonStatus = QuizBaseObserver("")
    var OnOffButtonStatusTitle = QuizBaseObserver("")
    var SayQuestionButtonStatus = QuizBaseObserver("")
    var Choice1Status = QuizBaseObserver("")
    var Choice2Status = QuizBaseObserver("")
    var Choice3Status = QuizBaseObserver("")
    var Choice1StatusColor = QuizBaseObserver(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    var Choice2StatusColor = QuizBaseObserver(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    var Choice3StatusColor = QuizBaseObserver(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    var ScoreStatus = QuizBaseObserver("")
    var questionTextStatus = QuizBaseObserver("")
    var questionTextStatusColor = QuizBaseObserver(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    var TimeStatus = QuizBaseObserver("")
    var TimeStatusColor = QuizBaseObserver(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    var ImageStatus = QuizBaseObserver("")
    var AttemptsCountStatus = QuizBaseObserver("")
    var AnswersButtonStatus = QuizBaseObserver("")
    var viewStatus = QuizBaseObserver(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    var ScoreStatusColor = QuizBaseObserver(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    var AttemptsStatusColor = QuizBaseObserver(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    
    // labels
    var Time = QuizBaseObserver(UILabel())
    var RecordVideoLabel = QuizBaseObserver(UILabel())
    var Score = QuizBaseObserver(UILabel())
    var Attempts = QuizBaseObserver(UILabel())
    
    // buttons
    var OnOffButton = QuizBaseObserver(UIButton())
    
    // storyboard and view
    var storyboard: UIStoryboard?
    var view: UIView?
    var viewController: UIViewController?
    
    func SetQuizTheme() {
        base?.quiztheme()
    }
    
    func OpenCamera() {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.allowsEditing = true
        picker.delegate = self.viewController as? any UIImagePickerControllerDelegate & UINavigationControllerDelegate
        self.viewController?.present(picker, animated: true)
    }
    
    
    func SkipQuestion() {
        
        if self.base?.questionNumber ?? 0 < 19 {
            self.base?.questionNumber += 1
            self.updateUI()
        }
    }
    
    func recognizeText(image: UIImage?) {
        guard let cgImage = image?.cgImage else {
            return
        }
        
        // Handler
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        
        // Request
        let request = VNRecognizeTextRequest { [weak self] request,error in
            guard let observations = request.results as? [VNRecognizedTextObservation],
                  error == nil else {
                return
            }
            
            let text = observations.compactMap({
                $0.topCandidates(1).first?.string
            }).joined(separator: " ")
            
            switch text {
                
            case _ where text.contains("1"):
                self?.check2 = self?.base?.checkChoices()[0] ?? ""
                self?.questionTextStatus.value = self?.check2 ?? ""
                
            case _ where text.contains("2"):
                self?.check2 = self?.base?.checkChoices()[1] ?? ""
                self?.questionTextStatus.value = self?.check2 ?? ""
                
            case _ where text.contains("3"):
                self?.check2 = self?.base?.checkChoices()[2] ?? ""
                self?.questionTextStatus.value = self?.check2 ?? ""
                
            case _ where text.contains("Один"):
                self?.check2 = self?.base?.checkChoices()[0] ?? ""
                self?.questionTextStatus.value = self?.check2 ?? ""
                
            case _ where text.contains("Два"):
                self?.check2 = self?.base?.checkChoices()[1] ?? ""
                self?.questionTextStatus.value = self?.check2 ?? ""
                
            case _ where text.contains("Три"):
                self?.check2 = self?.base?.checkChoices()[2] ?? ""
                self?.questionTextStatus.value = self?.check2 ?? ""
                
            default:
                self?.questionTextStatus.value = text
                self?.check2 = ""
            }
        }
        
        do {
            try handler.perform([request])
        } catch {
            questionTextStatus.value = "\(error)"
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.CheckPhotoAnswer()
        }
    }
    
    func CheckPhotoAnswer() {
        
        let photoanswer = base?.checkAnswer(check2)
        
        if photoanswer == true && check2 != "" && counter < 100  {
            
            if isRecordOnAudio == true {
                stopSpeechRecognition()
                sayComment(comment: "Правильно")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.startRecognition()
                }
            } else {
                sayComment(comment: "Правильно")
            }
            
            if base?.questionNumber == 19 {
                self.PresentTotalScreen()
            }
            
            player.Sound(resource: "correct answer.wav")
            
            if base?.questionNumber ?? 0 < 19 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.SetQuizTheme()
                }
            }
            
            if Choice1Status.value == check2 {
                Choice1StatusColor.value = UIColor.systemGreen
            }
            
            if Choice2Status.value == check2 {
                Choice2StatusColor.value = UIColor.systemGreen
            }
            
            if Choice3Status.value == check2 {
                Choice3StatusColor.value = UIColor.systemGreen
            }
            
            counter += 5
            CorrectAnswersCounter += 1
            
            ScoreStatus.value = ("Счет: \(CorrectAnswersCounter)/100")
            print("Голос \(check2)")
            
            base?.nextQuestion()
            write(id: 1, quizpath: "quizplanets", category: "planets")
            write(id: 2, quizpath: "quizhistory", category: "history")
            write(id: 3, quizpath: "quizanatomy", category: "anatomy")
            write(id: 4, quizpath: "quizsport", category: "sport")
            write(id: 5, quizpath: "quizgames", category: "games")
            write(id: 6, quizpath: "quiziq", category: "IQ")
            write(id: 7, quizpath: "quizeconomy", category: "economy")
            write(id: 8, quizpath: "quizgeography", category: "geography")
            write(id: 9, quizpath: "quizecology", category: "ecology")
            write(id: 10, quizpath: "quizphysics", category: "physics")
            write(id: 11, quizpath: "quizchemistry", category: "chemistry")
            write(id: 12, quizpath: "quizinformatics", category: "informatics")
            write(id: 13, quizpath: "quizliterature", category: "literature")
            write(id: 14, quizpath: "quizroadtraffic", category: "roadtraffic")
            write(id: 15, quizpath: "quizswift", category: "Swift")
            write(id: 16, quizpath: "quizunderwater", category: "underwater")
            write(id: 17, quizpath: "quizchess", category: "chess")
            write(id: 18, quizpath: "quizhalloween", category: "halloween")
            
            questionTextStatus.value = "Правильно 👍👍👍!!!"
            Timer.scheduledTimer(timeInterval:0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
        }
        
        if photoanswer == false && check2 != "" {
            
            if AttemptsCounter == 0 && self.AttemptsStatus == true {
                PresentTotalScreen()
            }
            
            if isRecordOnAudio == true {
                stopSpeechRecognition()
                sayComment(comment: "Не правильно")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.startRecognition()
                }
            } else {
                sayComment(comment: "Не правильно")
            }
            
            if base?.questionNumber == 19 {
                self.PresentTotalScreen()
            }
            
            player.Sound(resource: "wrong answer.wav")
            
            if base?.questionNumber ?? 0 < 19 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.SetQuizTheme()
                }
            }
            
            if Choice1Status.value == check2 {
                Choice1StatusColor.value = UIColor.systemRed
            }
            
            if Choice2Status.value == check2 {
                Choice2StatusColor.value = UIColor.systemRed
            }
            
            if Choice3Status.value == check2 {
                Choice3StatusColor.value = UIColor.systemRed
            }
            
            AttemptsCounter -= 1
            AttemptsCountStatus.value = "Попыток осталось: \(AttemptsCounter)"
            print(AttemptsCounter)
            
            print("Голос \(check2)")
            ScoreStatus.value = ("Счет: \(String(counter))/100")
            AttemptsCountStatus.value = "Попыток осталось: \(AttemptsCounter)"
            
            write(id: 1, quizpath: "quizplanets", category: "planets")
            write(id: 2, quizpath: "quizhistory", category: "history")
            write(id: 3, quizpath: "quizanatomy", category: "anatomy")
            write(id: 4, quizpath: "quizsport", category: "sport")
            write(id: 5, quizpath: "quizgames", category: "games")
            write(id: 6, quizpath: "quiziq", category: "IQ")
            write(id: 7, quizpath: "quizeconomy", category: "economy")
            write(id: 8, quizpath: "quizgeography", category: "geography")
            write(id: 9, quizpath: "quizecology", category: "ecology")
            write(id: 10, quizpath: "quizphysics", category: "physics")
            write(id: 11, quizpath: "quizchemistry", category: "chemistry")
            write(id: 12, quizpath: "quizinformatics", category: "informatics")
            write(id: 13, quizpath: "quizliterature", category: "literature")
            write(id: 14, quizpath: "quizroadtraffic", category: "roadtraffic")
            write(id: 15, quizpath: "quizswift", category: "Swift")
            write(id: 16, quizpath: "quizunderwater", category: "underwater")
            write(id: 17, quizpath: "quizchess", category: "chess")
            write(id: 18, quizpath: "quizhalloween", category: "halloween")
            
            questionTextStatus.value = ("\(check2) не верный ответ 👎👎👎!!!")
            Timer.scheduledTimer(timeInterval:0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
        }
    }
    
    func AdvancedSpeechRecognition() {
        
        let checkvoice = base?.checkAnswer(check2)
        
        if checkvoice == true && check2 != "" && counter < 100  {
            
            stopSpeechRecognition()
            
            sayComment(comment: "Правильно")
            
            if base?.questionNumber == 19 {
                self.PresentTotalScreen()
            }
            
            player.Sound(resource: "correct answer.wav")
            
            if base?.questionNumber ?? 0 < 19 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.SetQuizTheme()
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.startRecognition()
            }
            
            if Choice1Status.value == check2 {
                Choice1StatusColor.value = UIColor.systemGreen
            }
            
            if Choice2Status.value == check2 {
                Choice2StatusColor.value = UIColor.systemGreen
            }
            
            if Choice3Status.value == check2 {
                Choice3StatusColor.value = UIColor.systemGreen
            }
            
            counter += 5
            CorrectAnswersCounter += 1
            
            ScoreStatus.value = ("Счет: \(CorrectAnswersCounter)/100")
            print("Голос \(check2)")
            
            base?.nextQuestion()
            write(id: 1, quizpath: "quizplanets", category: "planets")
            write(id: 2, quizpath: "quizhistory", category: "history")
            write(id: 3, quizpath: "quizanatomy", category: "anatomy")
            write(id: 4, quizpath: "quizsport", category: "sport")
            write(id: 5, quizpath: "quizgames", category: "games")
            write(id: 6, quizpath: "quiziq", category: "IQ")
            write(id: 7, quizpath: "quizeconomy", category: "economy")
            write(id: 8, quizpath: "quizgeography", category: "geography")
            write(id: 9, quizpath: "quizecology", category: "ecology")
            write(id: 10, quizpath: "quizphysics", category: "physics")
            write(id: 11, quizpath: "quizchemistry", category: "chemistry")
            write(id: 12, quizpath: "quizinformatics", category: "informatics")
            write(id: 13, quizpath: "quizliterature", category: "literature")
            write(id: 14, quizpath: "quizroadtraffic", category: "roadtraffic")
            write(id: 15, quizpath: "quizswift", category: "Swift")
            write(id: 16, quizpath: "quizunderwater", category: "underwater")
            write(id: 17, quizpath: "quizchess", category: "chess")
            write(id: 18, quizpath: "quizhalloween", category: "halloween")
            
            questionTextStatus.value = "Правильно 👍👍👍!!!"
            Timer.scheduledTimer(timeInterval:0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
        }
        
        if checkvoice == false && self.Attempts.value != nil && check2 != "" {
            
            stopSpeechRecognition()
            
            sayComment(comment: "Не правильно")
            
            if AttemptsCounter == 0 && self.AttemptsStatus == true {
                PresentTotalScreen()
            }
            
            if base?.questionNumber == 19 {
                self.PresentTotalScreen()
            }
            
            player.Sound(resource: "wrong answer.wav")
            
            if base?.questionNumber ?? 0 < 19 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.SetQuizTheme()
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.startRecognition()
            }
            
            if Choice1Status.value == check2 {
                Choice1StatusColor.value = UIColor.systemRed
            }
            
            if Choice2Status.value == check2 {
                Choice2StatusColor.value = UIColor.systemRed
            }
            
            if Choice3Status.value == check2 {
                Choice3StatusColor.value = UIColor.systemRed
            }
            
            AttemptsCounter -= 1
            AttemptsCountStatus.value = "Попыток осталось: \(AttemptsCounter)"
            print(AttemptsCounter)
            
            print("Голос \(check2)")
            ScoreStatus.value = ("Счет: \(String(counter))/100")
            AttemptsCountStatus.value = "Попыток осталось: \(AttemptsCounter)"
            
            write(id: 1, quizpath: "quizplanets", category: "planets")
            write(id: 2, quizpath: "quizhistory", category: "history")
            write(id: 3, quizpath: "quizanatomy", category: "anatomy")
            write(id: 4, quizpath: "quizsport", category: "sport")
            write(id: 5, quizpath: "quizgames", category: "games")
            write(id: 6, quizpath: "quiziq", category: "IQ")
            write(id: 7, quizpath: "quizeconomy", category: "economy")
            write(id: 8, quizpath: "quizgeography", category: "geography")
            write(id: 9, quizpath: "quizecology", category: "ecology")
            write(id: 10, quizpath: "quizphysics", category: "physics")
            write(id: 11, quizpath: "quizchemistry", category: "chemistry")
            write(id: 12, quizpath: "quizinformatics", category: "informatics")
            write(id: 13, quizpath: "quizliterature", category: "literature")
            write(id: 14, quizpath: "quizroadtraffic", category: "roadtraffic")
            write(id: 15, quizpath: "quizswift", category: "Swift")
            write(id: 16, quizpath: "quizunderwater", category: "underwater")
            write(id: 17, quizpath: "quizchess", category: "chess")
            write(id: 18, quizpath: "quizhalloween", category: "halloween")
            
            questionTextStatus.value = ("\(check2) не верный ответ 👎👎👎!!!")
            Timer.scheduledTimer(timeInterval:0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
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
                    // sender.isEnabled = true
                }
            case .denied:
                print("statu denied")
            case .notDetermined:
                print("statu not determined")
            case .restricted:
                print("statu restricted")
            }
        }
    }
    
    func checkAnswer(_ userAnswer: String) -> Bool {
        print(userAnswer)
        print(questions()[questionNumber].answer)
        if userAnswer == questions()[questionNumber].answer{
            score+=5
            return true;
        }
        return false;
    }
    
    func questions() -> [Question] {
        return []
    }
    
    init(){}
    
    func checkQuestion() -> String {
        return questions()[questionNumber].question
    }
    
    func checkQuestionNumber() -> Int {
        return questionNumber + 1
    }
    
    func checkImage() -> String {
        return questions()[questionNumber].image
    }
    
    func checkAnswer() -> String {
        return questions()[questionNumber].answer
    }
    
    func checkChoices() -> [String] {
        return questions()[questionNumber].choices
    }
    
    func checkProgress() -> Float {
        return Float(questionNumber) / Float(questions().count);
    }
    
    func checkScore() -> Int {
        return score
    }
    
    func checkid() -> Int {
        return quiz?.id ?? 1
    }
    
    func checklevel() -> Question.levelOfdifficulty {
        return questions()[questionNumber].levelOfdifficulty
    }
    
    func nextQuiz(){
        quiznumber += 1
    }
    
    func nextQuestion() {
        questionNumber += 1
        if(questionNumber==questions().count){
            questionNumber=0
            score = 0;
        }
    }
    
    func showAndSendCommand(command: RemoteCommand) {
        if command == .one {
            DispatchQueue.main.async {
                self.check2 = (self.base?.checkChoices()[0])!
                self.GestureAnswer()
            }
        } else if command == .two {
            DispatchQueue.main.async {
                self.check2 = (self.base?.checkChoices()[1])!
                self.GestureAnswer()
            }
        }
    }
    
    func GestureAnswer() {
        
        let checkgesture = base?.checkAnswer(check2)
        
        if checkgesture == true && check2 != "" && counter < 100 {
            
            self.captureSession.stopRunning()
            
            self.isRecordingNow()
            
            if isRecordOnAudio == true {
                stopSpeechRecognition()
                sayComment(comment: "Правильно")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.startRecognition()
                }
            } else {
                sayComment(comment: "Правильно")
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.captureSession.startRunning()
                self.isRecordingNow()
            }
            
            if base?.questionNumber == 19 {
                PresentTotalScreen()
            }
            
            player.Sound(resource: "correct answer.wav")
            
            if base?.questionNumber ?? 0 < 19 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.SetQuizTheme()
                }
            }
            
            if Choice1Status.value == check2 {
                Choice1StatusColor.value = UIColor.systemGreen
            }
            
            if Choice2Status.value == check2 {
                Choice2StatusColor.value = UIColor.systemGreen
            }
            
            if Choice3Status.value == check2 {
                Choice3StatusColor.value = UIColor.systemGreen
            }
            
            counter += 5
            CorrectAnswersCounter += 1
            ScoreStatus.value = ("Счет: \(CorrectAnswersCounter)/100")
            
            base?.nextQuestion()
            write(id: 1, quizpath: "quizplanets", category: "planets")
            write(id: 2, quizpath: "quizhistory", category: "history")
            write(id: 3, quizpath: "quizanatomy", category: "anatomy")
            write(id: 4, quizpath: "quizsport", category: "sport")
            write(id: 5, quizpath: "quizgames", category: "games")
            write(id: 6, quizpath: "quiziq", category: "IQ")
            write(id: 7, quizpath: "quizeconomy", category: "economy")
            write(id: 8, quizpath: "quizgeography", category: "geography")
            write(id: 9, quizpath: "quizecology", category: "ecology")
            write(id: 10, quizpath: "quizphysics", category: "physics")
            write(id: 11, quizpath: "quizchemistry", category: "chemistry")
            write(id: 12, quizpath: "quizinformatics", category: "informatics")
            write(id: 13, quizpath: "quizliterature", category: "literature")
            write(id: 14, quizpath: "quizroadtraffic", category: "roadtraffic")
            write(id: 15, quizpath: "quizswift", category: "Swift")
            write(id: 16, quizpath: "quizunderwater", category: "underwater")
            write(id: 17, quizpath: "quizchess", category: "chess")
            write(id: 18, quizpath: "quizhalloween", category: "halloween")
            
            Timer.scheduledTimer(timeInterval:0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
        }
        
        if checkgesture == false && check2 != "" && self.Attempts.value != nil {
            
            self.captureSession.stopRunning()
            
            if AttemptsCounter == 0 && self.AttemptsStatus == true {
                PresentTotalScreen()
            }
            
            isRecordingNow()
            
            if isRecordOnAudio == true {
                stopSpeechRecognition()
                sayComment(comment: "Не правильно")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.startRecognition()
                }
            } else {
                sayComment(comment: "Не правильно")
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.captureSession.startRunning()
            }
            
            if base?.questionNumber == 19 {
                PresentTotalScreen()
            }
            
            player.Sound(resource: "wrong answer.wav")
            
            if base?.questionNumber ?? 0 < 19 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.SetQuizTheme()
                }
            }
            
            if Choice1Status.value == check2 {
                Choice1StatusColor.value = UIColor.systemRed
            }
            
            if Choice2Status.value == check2 {
                Choice2StatusColor.value = UIColor.systemRed
            }
            
            if Choice3Status.value == check2 {
                Choice3StatusColor.value = UIColor.systemRed
            }
            
            AttemptsCounter -= 1
            AttemptsCountStatus.value = "Попыток осталось: \(AttemptsCounter)"
            print(AttemptsCounter)
            
            print("Голос \(check2)")
            ScoreStatus.value = ("Счет: \(String(counter))/100")
            AttemptsCountStatus.value = "Попыток осталось: \(AttemptsCounter)"
            
            base?.nextQuestion()
            write(id: 1, quizpath: "quizplanets", category: "planets")
            write(id: 2, quizpath: "quizhistory", category: "history")
            write(id: 3, quizpath: "quizanatomy", category: "anatomy")
            write(id: 4, quizpath: "quizsport", category: "sport")
            write(id: 5, quizpath: "quizgames", category: "games")
            write(id: 6, quizpath: "quiziq", category: "IQ")
            write(id: 7, quizpath: "quizeconomy", category: "economy")
            write(id: 8, quizpath: "quizgeography", category: "geography")
            write(id: 9, quizpath: "quizecology", category: "ecology")
            write(id: 10, quizpath: "quizphysics", category: "physics")
            write(id: 11, quizpath: "quizchemistry", category: "chemistry")
            write(id: 12, quizpath: "quizinformatics", category: "informatics")
            write(id: 13, quizpath: "quizliterature", category: "literature")
            write(id: 14, quizpath: "quizroadtraffic", category: "roadtraffic")
            write(id: 15, quizpath: "quizswift", category: "Swift")
            write(id: 16, quizpath: "quizunderwater", category: "underwater")
            write(id: 17, quizpath: "quizchess", category: "chess")
            write(id: 18, quizpath: "quizhalloween", category: "halloween")
            
            Timer.scheduledTimer(timeInterval:0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
        }
    }
    
    func answerSelected(sender: UIButton) {
        let userAnswer = sender.currentTitle!
        let check = base?.checkAnswer(userAnswer)
        
        if  check! && counter < 100 {
            
            if isRecordOnAudio == true {
                stopSpeechRecognition()
                sayComment(comment: "Правильно")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.startRecognition()
                }
            } else {
                sayComment(comment: "Правильно")
            }
            
            RestartTimer()
            
            if base?.questionNumber == 19 {
                PresentTotalScreen()
                write(id: 1, quizpath: "quizplanets", category: "planets")
                write(id: 2, quizpath: "quizhistory", category: "history")
                write(id: 3, quizpath: "quizanatomy", category: "anatomy")
                write(id: 4, quizpath: "quizsport", category: "sport")
                write(id: 5, quizpath: "quizgames", category: "games")
                write(id: 6, quizpath: "quiziq", category: "IQ")
                write(id: 7, quizpath: "quizeconomy", category: "economy")
                write(id: 8, quizpath: "quizgeography", category: "geography")
                write(id: 9, quizpath: "quizecology", category: "ecology")
                write(id: 10, quizpath: "quizphysics", category: "physics")
                write(id: 11, quizpath: "quizchemistry", category: "chemistry")
                write(id: 12, quizpath: "quizinformatics", category: "informatics")
                write(id: 13, quizpath: "quizliterature", category: "literature")
                write(id: 14, quizpath: "quizroadtraffic", category: "roadtraffic")
                write(id: 15, quizpath: "quizswift", category: "Swift")
                write(id: 16, quizpath: "quizunderwater", category: "underwater")
                write(id: 17, quizpath: "quizchess", category: "chess")
                write(id: 18, quizpath: "quizhalloween", category: "halloween")
            }
            
            player.Sound(resource: "correct answer.wav")
            
            if base?.questionNumber ?? 0 < 19 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.SetQuizTheme()
                }
            }
            
            sender.backgroundColor = UIColor.green;
            questionTextStatus.value = "Правильно!"
            
            counter += 5
            CorrectAnswersCounter += 1
            
            ScoreStatus.value = ("Счет: \(String(counter))/100")
            animation.springLabel(label: Score.value)
            
            write(id: 1, quizpath: "quizplanets", category: "planets")
            write(id: 2, quizpath: "quizhistory", category: "history")
            write(id: 3, quizpath: "quizanatomy", category: "anatomy")
            write(id: 4, quizpath: "quizsport", category: "sport")
            write(id: 5, quizpath: "quizgames", category: "games")
            write(id: 6, quizpath: "quiziq", category: "IQ")
            write(id: 7, quizpath: "quizeconomy", category: "economy")
            write(id: 8, quizpath: "quizgeography", category: "geography")
            write(id: 9, quizpath: "quizecology", category: "ecology")
            write(id: 10, quizpath: "quizphysics", category: "physics")
            write(id: 11, quizpath: "quizchemistry", category: "chemistry")
            write(id: 12, quizpath: "quizinformatics", category: "informatics")
            write(id: 13, quizpath: "quizliterature", category: "literature")
            write(id: 14, quizpath: "quizroadtraffic", category: "roadtraffic")
            write(id: 15, quizpath: "quizswift", category: "Swift")
            write(id: 16, quizpath: "quizunderwater", category: "underwater")
            write(id: 17, quizpath: "quizchess", category: "chess")
            write(id: 18, quizpath: "quizhalloween", category: "halloween")
            
        } else if !check! {
            
            if isRecordOnAudio == true {
                stopSpeechRecognition()
                sayComment(comment: "Не Правильно")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.startRecognition()
                }
            } else {
                sayComment(comment: "Не Правильно")
            }
            
            RestartTimer()
            
            if base?.questionNumber == 19 {
                PresentTotalScreen()
            }
            
            player.Sound(resource: "wrong answer.wav")
            
            if base?.questionNumber ?? 0 < 19 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.SetQuizTheme()
                }
            }
            
            if AttemptsCounter == 0 && self.AttemptsStatus == true {
                PresentTotalScreen()
            }
            
            if counter == 0 && self.Attempts != nil {
                sender.backgroundColor = UIColor.red;
                questionTextStatus.value = "Не правильно!"
                counter = 0
                AttemptsCounter -= 1
                UnCorrectAnswersCounter += 1
                ScoreStatus.value = ("Счет: \(String(counter))/100")
                AttemptsCountStatus.value = ("Попыток осталось: \(String(AttemptsCounter))")
                animation.springLabel(label: Attempts.value)
                
                write(id: 1, quizpath: "quizplanets", category: "planets")
                write(id: 2, quizpath: "quizhistory", category: "history")
                write(id: 3, quizpath: "quizanatomy", category: "anatomy")
                write(id: 4, quizpath: "quizsport", category: "sport")
                write(id: 5, quizpath: "quizgames", category: "games")
                write(id: 6, quizpath: "quiziq", category: "IQ")
                write(id: 7, quizpath: "quizeconomy", category: "economy")
                write(id: 8, quizpath: "quizgeography", category: "geography")
                write(id: 9, quizpath: "quizecology", category: "ecology")
                write(id: 10, quizpath: "quizphysics", category: "physics")
                write(id: 11, quizpath: "quizchemistry", category: "chemistry")
                write(id: 12, quizpath: "quizinformatics", category: "informatics")
                write(id: 13, quizpath: "quizliterature", category: "literature")
                write(id: 14, quizpath: "quizroadtraffic", category: "roadtraffic")
                write(id: 15, quizpath: "quizswift", category: "Swift")
                write(id: 16, quizpath: "quizunderwater", category: "underwater")
                write(id: 17, quizpath: "quizchess", category: "chess")
                write(id: 18, quizpath: "quizhalloween", category: "halloween")
                
            } else if counter > 0 && self.Attempts != nil {
                
                sender.backgroundColor = UIColor.red
                AttemptsCounter -= 1
                UnCorrectAnswersCounter += 1
                ScoreStatus.value = ("Счет: \(String(counter))/100")
                AttemptsCountStatus.value = ("Попыток осталось: \(String(AttemptsCounter))")
                animation.springLabel(label: Attempts.value)
                
                write(id: 1, quizpath: "quizplanets", category: "planets")
                write(id: 2, quizpath: "quizhistory", category: "history")
                write(id: 3, quizpath: "quizanatomy", category: "anatomy")
                write(id: 4, quizpath: "quizsport", category: "sport")
                write(id: 5, quizpath: "quizgames", category: "games")
                write(id: 6, quizpath: "quiziq", category: "IQ")
                write(id: 7, quizpath: "quizeconomy", category: "economy")
                write(id: 8, quizpath: "quizgeography", category: "geography")
                write(id: 9, quizpath: "quizecology", category: "ecology")
                write(id: 10, quizpath: "quizphysics", category: "physics")
                write(id: 11, quizpath: "quizchemistry", category: "chemistry")
                write(id: 12, quizpath: "quizinformatics", category: "informatics")
                write(id: 13, quizpath: "quizliterature", category: "literature")
                write(id: 14, quizpath: "quizroadtraffic", category: "roadtraffic")
                write(id: 15, quizpath: "quizswift", category: "Swift")
                write(id: 16, quizpath: "quizunderwater", category: "underwater")
                write(id: 17, quizpath: "quizchess", category: "chess")
                write(id: 18, quizpath: "quizhalloween", category: "halloween")
                
            }
        }
        
        write(id: 1, quizpath: "quizplanets", category: "planets")
        write(id: 2, quizpath: "quizhistory", category: "history")
        write(id: 3, quizpath: "quizanatomy", category: "anatomy")
        write(id: 4, quizpath: "quizsport", category: "sport")
        write(id: 5, quizpath: "quizgames", category: "games")
        write(id: 6, quizpath: "quiziq", category: "IQ")
        write(id: 7, quizpath: "quizeconomy", category: "economy")
        write(id: 8, quizpath: "quizgeography", category: "geography")
        write(id: 9, quizpath: "quizecology", category: "ecology")
        write(id: 10, quizpath: "quizphysics", category: "physics")
        write(id: 11, quizpath: "quizchemistry", category: "chemistry")
        write(id: 12, quizpath: "quizinformatics", category: "informatics")
        write(id: 13, quizpath: "quizliterature", category: "literature")
        write(id: 14, quizpath: "quizroadtraffic", category: "roadtraffic")
        write(id: 15, quizpath: "quizswift", category: "Swift")
        write(id: 16, quizpath: "quizunderwater", category: "underwater")
        write(id: 17, quizpath: "quizchess", category: "chess")
        write(id: 18, quizpath: "quizhalloween", category: "halloween")
        
        
        base?.nextQuestion()
        
        Timer.scheduledTimer(timeInterval:0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
    }
    
    func isRecordingNow() {
        
        DispatchQueue.main.async {
            
            self.checkGestureSetting()
            
            if self.captureSession.isRunning == true {
                self.RecordVideoStatus.value = "Rec ●"
                self.RecordVideoStatusColor.value = UIColor.systemRed
                //self.RecordVideoLabel.value.font = UIFont(name: "System", size: 20)
                print("is recording")
                
            } else if self.captureSession.isRunning == false {
                
                self.RecordVideoStatus.value = "Rec ●"
                self.RecordVideoStatusColor.value = UIColor.systemGreen
                //self.RecordVideoLabel.value.font = UIFont(name: "System", size: 20)
                print("isn't recording")
                print(self.captureSession.isRunning)
                
                var timeLeft = 4
                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                    print("timer fired!")
                    
                    timeLeft -= 1
                    
                    self.RecordVideoStatus.value = "Rec ● \(timeLeft)"
                    
                    
                    if self.GestureRecording == false {
                        timeLeft = 0
                    }
                    
                    print(timeLeft)
                    
                    if(timeLeft==0)  {
                        timer.invalidate()
                        self.RecordVideoStatus.value = "Rec ●"
                    }
                }
                
            }
        }
    }
    
    func exitOrientationFromDeviceOrientation() -> CGImagePropertyOrientation {
        let curDeviceOrientation = UIDevice.current.orientation
        let exifOrientation: CGImagePropertyOrientation
        
        switch curDeviceOrientation {
            
        case UIDeviceOrientation.portraitUpsideDown:
            exifOrientation = .left
            
        case UIDeviceOrientation.landscapeLeft:
            exifOrientation = .upMirrored
            
        case UIDeviceOrientation.landscapeRight:
            exifOrientation = .down
            
        case UIDeviceOrientation.portrait:
            exifOrientation = .up
            
        default:
            exifOrientation = .up
        }
        return exifOrientation
    }
    
    
    func handleClassification (request: VNRequest, error: Error?) {
        guard let observations = request.results else {print("no results"); return}
        
        let classifications = observations
            .compactMap({$0 as? VNClassificationObservation})
            .filter({$0.confidence > 0.6})
            .map({$0.identifier})
        
        print(classifications)
        
        switch classifications.first {
            
        case "None":
            currentCommand = .none
            
        case "FIVE-UB-RHand":
            currentCommand = .one
            
        case "fist-UB-RHand":
            currentCommand = .two
            
            
        case .none:
            break
        case .some(_):
            break
        }
    }
    
    func CurrentMusic() {
        OnOffButtonStatus.value = quiz?.music ?? ""
    }
    
    func stopMusic() {
        // if base?.checkid() == id {
        if self.OnOffButton != nil {
            if isPlaying == true {
                player.StopSound(resource: quiz?.music ?? "")
                isPlaying = false
                OnOffButtonStatus.value = quiz?.music ?? ""
                OnOffButtonStatus.value = "music button"
            } else if isPlaying == false || self.MusicStatus == false {
                print("Music: \(self.MusicStatus)")
                player.Sound(resource: quiz?.music ?? "")
                isPlaying = true
                OnOffButtonStatus.value = quiz?.music ?? ""
                OnOffButtonStatus.value = "music button selected"
            }
        }
        // }
    }
    
    func checkSpeachSetting() {
        var isSpeachOn = UserDefaults.standard.object(forKey: "onstatusspeach") as? Bool
        
        print(isSpeachOn)
        
        if isSpeachOn == true {
            print("speach now")
        } else if isSpeachOn == false || isSpeachOn == nil {
            print("speach not now")
            self.SpeachStatus = false
        }
        
        if self.SpeachStatus == false {
            print("speach doesnt working")
        } else {}
    }
    
    func checkHintsSetting(sender: UIButton) {
        var isHintsOn = UserDefaults.standard.object(forKey: "onstatushints") as? Bool
        
        print(isHintsOn)
        
        if isHintsOn == true {
            print("hints now")
        } else if isHintsOn == false || isHintsOn == nil {
            print("hints not now")
            //self.captureSession.stopRunning()
            self.HintsStatus = false
        }
        
        if self.HintsStatus == false {
            print("hints doesnt working")
            sender.removeFromSuperview()
        } else {
            
        }
    }
    
    func checkGestureSetting() {
        
        if isRecordOn == true {
            print("record now")
        } else if isRecordOn == false || isRecordOn == nil {
            print("record not now")
            //self.captureSession.stopRunning()
            self.GestureRecording = false
        }
        
        if self.GestureRecording == false {
            print("time out")
            self.captureSession.stopRunning()
        }
    }
    
    func checkAudioSetting() {
        
        print(isRecordOnAudio)
        
        if isRecordOnAudio == true {
            print("record audio now")
            startRecognition()
        } else if isRecordOnAudio == false || isRecordOnAudio == nil {
            print("record audio not now")
        }
    }
    
    
    func checkMusicSetting() {
        var isMusicOn = UserDefaults.standard.object(forKey: "onstatusmusic") as? Bool
        
        print("Музыка \(isMusicOn)")
        
        if isMusicOn == true {
            print("music now")
        } else if isMusicOn == false || isMusicOn == nil {
            print("music not now")
            //self.captureSession.stopRunning()
            self.MusicStatus = false
        }
        
        if self.MusicStatus == false {
            print("music doesnt working")
            self.StopMusicOption(id: 1, resource: "space music.mp3")
            self.StopMusicOption(id: 2, resource: "history music.mp3")
            self.StopMusicOption(id: 3, resource: "anatomy music.mp3")
            self.StopMusicOption(id: 4, resource: "sport music.mp3")
            self.StopMusicOption(id: 5, resource: "games music.mp3")
            self.StopMusicOption(id: 6, resource: "IQ music.mp3")
            self.StopMusicOption(id: 7, resource: "economy music.mp3")
            self.StopMusicOption(id: 8, resource: "geography music.mp3")
            self.StopMusicOption(id: 9, resource: "ecology music.mp3")
            self.StopMusicOption(id: 10, resource: "physics music.mp3")
            self.StopMusicOption(id: 11, resource: "chemistry music.mp3")
            self.StopMusicOption(id: 12, resource: "informatics music.mp3")
            self.StopMusicOption(id: 13, resource: "literature music.mp3")
            self.StopMusicOption(id: 14, resource: "drive music.mp3")
            self.StopMusicOption(id: 15, resource: "Swift music.mp3")
            self.StopMusicOption(id: 16, resource: "underwater music.mp3")
            self.StopMusicOption(id: 17, resource: "chess music.mp3")
        } else {
            print("music working")
        }
    }
    
    func checkTimerSetting() {
        var isTimerOn = UserDefaults.standard.object(forKey: "onstatustimer") as? Bool
        
        print(isTimerOn)
        
        if isTimerOn == true {
            print("timer now")
        } else if isTimerOn == false || isTimerOn == nil {
            print("timer not now")
            //self.captureSession.stopRunning()
            self.TimerStatus = false
        }
    }
    
    func checkAttemptsSetting() {
        
        print(isAttemptsOn)
        
        if isAttemptsOn == true {
            print("attempts now")
        } else if isAttemptsOn == false || isAttemptsOn == nil {
            print("attempts not now")
            //self.captureSession.stopRunning()
            self.AttemptsStatus = false
        }
        
        if self.AttemptsStatus == false {
            self.Attempts.value.removeFromSuperview()
        }
    }
    
    @objc func ShowAnswers() {
        SCLAlertView().showInfo("варианты ответов", subTitle: "1)\(base?.checkChoices()[0] ?? "") 2)\(base?.checkChoices()[1] ?? "") 3)\(base?.checkChoices()[2] ?? "")")
    }
    
    
    func PresentTotalScreen() {
        
        self.VoiceRecording = false
        self.GestureRecording = false
        
        //self.captureSession.stopRunning()
        self.synthesizer.stopSpeaking(at: .immediate)
        
        DispatchQueue.main.async {
            
            self.captureSession.stopRunning()
            print("В данный момент: \(self.captureSession.isRunning)")
            
            self.player.StopSound(resource: self.sound)
            
            let vc = self.storyboard?.instantiateViewController(identifier: "BaseTotalQuizViewController") as? BaseTotalQuizViewController
            guard let window = self.view?.window else {return}
            vc?.quizBaseViewModel = self.base
            window.rootViewController = vc
        }
    }
    
    @objc func updateUI(){
        
        level()
        
        questionTextStatus.value = ("Вопрос №\(base?.checkQuestionNumber() ?? 0): \(base?.checkQuestion() ?? "")")
        
        ScoreStatus.value = "Счет: \(counter)/100"
        
        base?.nextQuiz()
        
        Choice1StatusColor.value = UIColor.clear
        Choice2StatusColor.value = UIColor.clear
        Choice3StatusColor.value = UIColor.clear
        
        Choice1Status.value = base?.checkChoices()[0] ?? ""
        Choice2Status.value = base?.checkChoices()[1] ?? ""
        Choice3Status.value = base?.checkChoices()[2] ?? ""
        
        ImageStatus.value = base?.checkImage() ?? ""
    }
    
    
    func setupVision() {
        guard let visionModel = try? VNCoreMLModel(for: example_5s0_hand_model().model) else {return}
        let classificationRequest = VNCoreMLRequest(model: visionModel, completionHandler: self.handleClassification)
        classificationRequest.imageCropAndScaleOption = .centerCrop
        
        self.requests = [classificationRequest]
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {return}
        let exifOrientation = self.exitOrientationFromDeviceOrientation()
        
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: exifOrientation, options: [:])
        do {
            try imageRequestHandler.perform(self.requests)
        } catch {
            print(error)
        }
    }
    
    func prepareCamera() {
        let avaliableDevices = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .front).devices
        captureDevice = avaliableDevices.first
        
        if captureDevice != nil {
            beginSession()
        } else {
            print("captureDevice = nil")
        }
        
    }
    
    func beginSession() {
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: captureDevice)
            captureSession.addInput(captureDeviceInput)
        } catch {
            print("Could not create video device input")
            return
        }
        
        if let inputs = captureSession.inputs as? [AVCaptureDeviceInput] {
            for input in inputs {
                captureSession.removeInput(input)
            }
        }
        
        captureSession.beginConfiguration()
        captureSession.sessionPreset = .vga640x480
        
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.videoSettings = [kCGImagePropertyDNGBlackLevelDeltaH as String: Int(kCVPixelFormatType_420YpCbCr8BiPlanarFullRange)]
        dataOutput.alwaysDiscardsLateVideoFrames = true
        
        if captureSession.canAddOutput(dataOutput) {
            captureSession.addOutput(dataOutput)
        }
        
        captureSession.commitConfiguration()
        
        let queue = DispatchQueue(label: "captureQueue")
        dataOutput.setSampleBufferDelegate(self, queue: queue)
        
        captureSession.startRunning()
        
    }
    
    func StopMusicOption(id: Int, resource: String) {
        if base?.checkid() == id {
            if MusicStatus == false {
                player.StopSound(resource: resource)
                OnOffButton.value.isUserInteractionEnabled = false
                OnOffButton.value.removeFromSuperview()
            }
        }
    }
    
    func CheckVoiceCommands() {
        
        switch check2 {
            
        case _ where check2.contains("один") || check2.contains("Один"):
            check2 = base?.checkChoices()[0] ?? ""
            questionTextStatus.value = ("Ваш ответ: \(check2)")
            
        case _ where check2.contains("два") || check2.contains("Два"):
            check2 = base?.checkChoices()[1] ?? ""
            questionTextStatus.value = ("Ваш ответ: \(check2)")
            
        case _ where check2.contains("три") || check2.contains("Три"):
            check2 = base?.checkChoices()[2] ?? ""
            questionTextStatus.value = ("Ваш ответ: \(check2)")
            
        case _ where check2.contains("перв") || check2.contains("Перв"):
            check2 = base?.checkChoices()[0] ?? ""
            questionTextStatus.value = ("Ваш ответ: \(check2)")
            
        case _ where check2.contains("втор") || check2.contains("Втор"):
            check2 = base?.checkChoices()[1] ?? ""
            questionTextStatus.value = ("Ваш ответ: \(check2)")
            
        case _ where check2.contains("трет") || check2.contains("Трет"):
            check2 = base?.checkChoices()[2] ?? ""
            questionTextStatus.value = ("Ваш ответ: \(check2)")
            
        case _ where check2.contains("решение") || check2.contains("Решение"):
            check2 = ""
            if self.HintsStatus == true {
                self.ShowAnswer()
            }
            
            stopSpeechRecognition()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.startRecognition()
            }
            
        case _ where check2.contains("След") || check2.contains("след"):
            check2 = ""
            self.SkipQuestion()
            
            stopSpeechRecognition()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.startRecognition()
            }
            
        case _ where check2.contains("Вопрос") || check2.contains("вопрос"):
            check2 = ""
            
            sayComment(comment: "\(base?.checkQuestion() ?? "")\(base?.checkChoices() ?? [""])")
            
            stopSpeechRecognition()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.startRecognition()
            }
            
        case _ where check2.contains("Счёт") || check2.contains("счёт"):
            check2 = ""
            
            sayComment(comment: "\(counter)")
            
            stopSpeechRecognition()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.startRecognition()
            }
            
        case _ where check2.contains("Включить музыку") || check2.contains("включить музыку"):
            check2 = ""
            
            OnOffButton.value.sendActions(for: .touchUpInside)
            
            stopSpeechRecognition()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.startRecognition()
            }
            
            
        case _ where check2.contains("Выключить музыку") || check2.contains("выключить музыку"):
            check2 = ""
            
            OnOffButton.value.sendActions(for: .touchUpInside)
            
            stopSpeechRecognition()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.startRecognition()
            }
            
        case _ where check2.contains("Камер") || check2.contains("камер"):
            check2 = ""
            self.OpenCamera()
            
        case _ where check2.contains("Заверш") || check2.contains("заверш") || check2.contains("Выйти") || check2.contains("выйти") || check2.contains("Выход") || check2.contains("выход"):
            check2 = ""
            self.player.StopSound(resource: sound)
            self.exit()
            
        default:
            check2 = ""
        }
        
        self.AdvancedSpeechRecognition()
    }
    
    func stopSpeechRecognition() {
        audioEngine.stop() //AVAudioEngine()
        recognitionTask?.cancel() //speechRecognizer?.recognitionTask
        request.endAudio()  //SFSpeechAudioBufferRecognitionRequest?
        audioEngine.inputNode.removeTap(onBus: 0)
    }
    
    
    func exit() {
        DispatchQueue.main.async {
            guard let vc = self.storyboard?.instantiateViewController(identifier: "ViewController") else {return}
            guard let window = self.view?.window else {return}
            window.rootViewController = vc
            UserDefaults.standard.set(false, forKey: "music")
        }
    }
    
    func sayComment(comment: String) {
        let utterance = AVSpeechUtterance(string: comment)
        utterance.voice = AVSpeechSynthesisVoice(language: "ru-RU")
        synthesizer.speak(utterance)
        
        if SpeachStatus == false {
            synthesizer.stopSpeaking(at: .immediate)
        }
    }
    
    func say() {
        if isTalking == false {
            let utterance = AVSpeechUtterance(string: "\(base?.checkQuestion() ?? "")\(base?.checkChoices() ?? [""])")
            utterance.voice = AVSpeechSynthesisVoice(language: "ru-RU")
            synthesizer.speak(utterance)
            isTalking = true
        } else {
            synthesizer.stopSpeaking(at: .immediate)
            isTalking = false
            self.SayQuestionButtonStatus.value = "synthesizer"
        }
    }
    
    func startRecognition () {
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
                DispatchQueue.main.async {
                    self.check2 = res.formattedString
                    print(self.check2)
                    self.CheckVoiceCommands()
                }
            } else if let error = error {
                print("\(error.localizedDescription)")
            }
        })
    }
    
    func LastQuiz(category: String, image: String, background: String) {
        let db = Firestore.firestore()
        let ref = db.collection("users").document((Auth.auth().currentUser?.email)!)
        ref.updateData([
            "lastquiz": [
                "bestscore": counter,
                "CorrectAnswersCounter": CorrectAnswersCounter,
                "UnCorrectAnswersCounter": UnCorrectAnswersCounter,
                "complete": true,
                "category": category,
                "Id": base?.checkid() ?? 0,
                "image": image,
                "background": background,
                "sound": quiz?.sound
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("success")
                //print(ref)
            }
        }
    }
    
    func write(id: Int, quizpath: String, category: String) {
        let db = Firestore.firestore()
        
        if base?.checkid() == id {
            let ref = db.collection("users").document((Auth.auth().currentUser?.email)!)
            ref.updateData([
                quizpath: [
                    "bestscore": counter,
                    "CorrectAnswersCounter": CorrectAnswersCounter,
                    "UnCorrectAnswersCounter": UnCorrectAnswersCounter,
                    "complete": true,
                    "category": category
                ]
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("success")
                    print(ref)
                }
            }
            
            switch category {
                
            case "planets":
                LastQuiz(category: "планеты", image: "planets.jpeg", background: "earth.background.jpeg")
                //CurrentQuiz()
            case "history":
                LastQuiz(category: "история", image: "history.jpeg", background: "history.background.jpeg")
                //CurrentQuiz()
            case "anatomy":
                LastQuiz(category: "анатомия", image: "anatomy.jpeg", background: "anatomy.background.jpeg")
                //CurrentQuiz()
            case "sport":
                LastQuiz(category: "спорт", image: "sport.jpeg", background: "sport.background.jpeg")
                //CurrentQuiz()
            case "games":
                LastQuiz(category: "игры", image: "games.jpeg", background: "games.background.jpeg")
                //CurrentQuiz()
            case "IQ":
                LastQuiz(category: "IQ", image: "IQ.jpeg", background: "IQ.background.jpeg")
                //CurrentQuiz()
            case "economy":
                LastQuiz(category: "экономика", image: "economy.jpeg", background: "economy.background.jpeg")
                //CurrentQuiz()
            case "geography":
                LastQuiz(category: "география", image: "geography.jpeg", background: "geography.background.jpeg")
                //CurrentQuiz()
            case "ecology":
                LastQuiz(category: "экология", image: "ecology.jpeg", background: "ecology.background.jpeg")
                //CurrentQuiz()
            case "physics":
                LastQuiz(category: "физика", image: "physics.jpeg", background: "physics.background.jpeg")
                //CurrentQuiz()
            case "chemistry":
                LastQuiz(category: "химия", image: "chemistry.jpeg", background: "chemistry.background.jpeg")
                //CurrentQuiz()
            case "informatics":
                LastQuiz(category: "информатика", image: "informatics.jpeg", background: "informatics.background.jpeg")
                //CurrentQuiz()
            case "literature":
                LastQuiz(category: "литература", image: "literature.jpeg", background: "literature.background.jpeg")
                //CurrentQuiz()
            case "roadtraffic":
                LastQuiz(category: "ПДД", image: "drive.jpeg", background: "drive.background.jpeg")
                //CurrentQuiz()
            case "Swift":
                LastQuiz(category: "Swift", image: "swift.jpeg", background: "swift.background.jpeg")
                //CurrentQuiz()
            case "underwater":
                LastQuiz(category: "подводный мир", image: "underwater.png", background: "underwater.background.jpeg")
                //CurrentQuiz()
            case "chess":
                LastQuiz(category: "шахматы", image: "chess.png", background: "chess.background.jpeg")
                //CurrentQuiz()
            case "halloween":
                LastQuiz(category: "хэллоуин", image: "halloween.png", background: "halloween.background.jpeg")
                
            default:
                break
            }
            
        }
    }
    
    
    func level() {
        if TimeStatus != nil {
            if base?.checklevel() == .easy {
                seconds = 60
                //questionText.textColor = UIColor.systemGreen
                TimeStatus.value = ("Осталось: \(String(seconds)) секунд")
            } else if base?.checklevel() == . normal {
                seconds = 30
                //questionText.textColor = UIColor.systemYellow
                TimeStatus.value = ("Осталось: \(String(seconds)) секунд")
            } else if base?.checklevel() == . hard {
                seconds = 15
                //questionText.textColor = UIColor.systemRed
                TimeStatus.value = ("Осталось: \(String(seconds)) секунд")
            }
        }
    }
    
    @objc func timerClass() {
        
        if Time != nil {
            seconds -= 1
            TimeStatus.value = ("Осталось: \(String(seconds)) секунд")
        }
        
        if self.TimerStatus == false {
            timer.invalidate()
            
            if Time != nil {
                Time.value.removeFromSuperview()
            }
        }
        
        
        if Time != nil {
            if (seconds <= 5 ) {
                animation.springLabel(label: Time.value)
                TimeStatusColor.value = UIColor.red
            }
            
            if (seconds > 5) {
                TimeStatusColor.value = UIColor.systemGreen
            }
            
            if (seconds > 0) && (seconds < 5) {
                TimeStatus.value = ("Осталось: \(String(seconds)) секунды")
            }
            
            if (seconds == 1) {
                TimeStatus.value = ("Осталось: \(String(seconds)) секунда")
            }
            
            
            if (seconds == 0) {
                
                if base?.questionNumber == 19 {
                    PresentTotalScreen()
                }
                
                if AttemptsCounter == 0 && self.AttemptsStatus == true {
                    PresentTotalScreen()
                }
                
                if counter == 0 && self.Attempts != nil {
                    counter = 0
                    AttemptsCounter -= 1
                    ScoreStatus.value = ("Счет: \(String(counter))/100")
                    AttemptsCountStatus.value = ("Попыток осталось: \(String(AttemptsCounter))")
                    animation.springLabel(label: Attempts.value)
                } else if counter > 0 && self.Attempts != nil {
                    AttemptsCounter -= 1
                    ScoreStatus.value = ("Счет: \(String(counter))/100")
                    AttemptsCountStatus.value = ("Попыток осталось: \(String(AttemptsCounter))")
                    animation.springLabel(label: Attempts.value)
                    animation.springLabel(label: Score.value)
                }
                
                //timer.invalidate()
                
                base?.nextQuestion()
                
                //RestartTimer()
                
                Timer.scheduledTimer(timeInterval:0.1, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
            }
        }
    }
    
    func RestartTimer() {
        timer.invalidate()
        level()
        if Time.value != nil {
            TimeStatus.value = String(seconds)
        }
        timerClass()
        startTimer()
    }
    
    func startTimer() {
        //Make sure there arent any others timers running
        timer.invalidate()
        //Create the timer
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerClass), userInfo: nil, repeats: true)
    }
    
    func setQuizeModel(base: QuizBaseViewModel) {
        self.base = base
    }
    
    func quiztheme() {
        viewStatus.value = UIColor(patternImage: UIImage(named: quiz?.background ?? "")!)
        player.Sound(resource: quiz?.music ?? "")
        self.checkMusicSetting()
        CurrentMusic()
        OnOffButtonStatusTitle.value = quiz?.music ?? ""
        sound = quiz?.music ?? ""
    }
    
    func configureAudioSession() {
        
        do {
            try? AVAudioSession.sharedInstance().setCategory(.playAndRecord, mode: .default, policy: .default, options: .defaultToSpeaker)
        } catch  {
            
        }
    }
    
    func ShowAnswer() {
        if AnswersCounter <= 0 {
            SCLAlertView().showWarning("У вас осталось 0 подсказок", subTitle: "решайте сами")
            AnswersCounter = 0
            AnswersButtonStatus.value = ("\(AnswersCounter)")
        } else if Choice1Status.value == "" || Choice2Status.value == "" || Choice3Status.value == "" {
            print(AnswersCounter)
        } else {
            AnswersCounter = AnswersCounter - 1
            AnswersButtonStatus.value = ("\(AnswersCounter)")
            player.Sound(resource: "broken light bulb.mp3")
            
            if Choice1Status.value != base?.checkAnswer() {
                Choice1Status.value = ""
            }
            if Choice2Status.value != base?.checkAnswer() {
                Choice2Status.value = ""
            }
            if Choice3Status.value != base?.checkAnswer() {
                Choice3Status.value = ""
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.SetQuizTheme()
            }
        }
    }
    
    func OnOffSound() {
        self.stopMusic()
    }
}


extension QuizBaseViewModel: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    func isEqual(_ object: Any?) -> Bool {
        return true
    }
    
    var hash: Int {
        return 1
    }
    
    var superclass: AnyClass? {
        return superclass
    }
    
    func `self`() -> Self {
        return self
    }
    
    func perform(_ aSelector: Selector!) -> Unmanaged<AnyObject>! {
        var object: Unmanaged<AnyObject>!
        return object
    }
    
    func perform(_ aSelector: Selector!, with object: Any!) -> Unmanaged<AnyObject>! {
        var object: Unmanaged<AnyObject>!
        return object
    }
    
    func perform(_ aSelector: Selector!, with object1: Any!, with object2: Any!) -> Unmanaged<AnyObject>! {
        var object: Unmanaged<AnyObject>!
        return object
    }
    
    func isProxy() -> Bool {
        return true
    }
    
    func isKind(of aClass: AnyClass) -> Bool {
        return true
    }
    
    func isMember(of aClass: AnyClass) -> Bool {
        return true
    }
    
    func conforms(to aProtocol: Protocol) -> Bool {
        return true
    }
    
    func responds(to aSelector: Selector!) -> Bool {
        return true
    }
    
    var description: String {
        return ""
    }
    
}
