//
//  RandomViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 20.02.2022.
//

import UIKit
import SCLAlertView
import Firebase
import AVFoundation
import AVKit
import Speech
import Vision

class BaseQuizViewController: UIViewController {
    
    var pl = AVAudioPlayer()
    var music = UserDefaults.standard.object(forKey: "music") as? Bool
    var GestureRecording = true
    var VoiceRecording = true
    var HintsStatus = true
    var SpeachStatus = true
    var MusicStatus = true
    var TimerStatus = true
    var AttemptsStatus = true
    var isTalking = false
    let synthesizer = AVSpeechSynthesizer()
    
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
    var quiz: QuizBase?
    
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
    
    
    @IBOutlet weak var Score: UILabel!
    @IBOutlet weak var questionText: UILabel!
    
    @IBOutlet weak var Choice1: UIButton!
    @IBOutlet weak var Choice2: UIButton!
    @IBOutlet weak var Choice3: UIButton!
    @IBOutlet weak var OnOffButton: UIButton!
    
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var Attempts: UILabel!
    @IBOutlet weak var Time: UILabel!
    @IBOutlet weak var RecordVideoLabeL: UILabel!
    
    @IBOutlet weak var PauseButton: UIButton!
    @IBOutlet weak var AnswersButton: UIButton!
    @IBOutlet weak var SayQuestionButton: UIButton!
    @IBOutlet weak var recognizeButton: UIButton!
    @IBOutlet weak var MusicButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.checkHintsSetting()
        self.checkAudioSetting()
        self.checkGestureSetting()
        self.checkSpeachSetting()
        self.checkTimerSetting()
        self.checkAttemptsSetting()
        let tap = UITapGestureRecognizer(target: self, action: #selector(ShowAnswers))
        self.Image.isUserInteractionEnabled = true
        self.Image.addGestureRecognizer(tap)
        isRecordingNow()
        setupVision()
        startTimer()
        updateUI()
        level()
        Image.layer.cornerRadius = Image.frame.size.width / 20
        Image.clipsToBounds = true
        
        quiztheme(id: 1, background: "earth.background.jpeg", music: "space music.mp3")
        quiztheme(id: 2, background: "history.background.jpeg", music: "history music.mp3")
        quiztheme(id: 3, background: "anatomy.background.jpeg", music: "anatomy music.mp3")
        quiztheme(id: 4, background: "sport.background.jpeg", music: "sport music.mp3")
        quiztheme(id: 5, background: "games.background.jpeg", music: "games music.mp3")
        quiztheme(id: 6, background: "IQ.background.jpeg", music: "IQ music.mp3")
        quiztheme(id: 7, background: "economy.background.jpeg", music: "economy music.mp3")
        quiztheme(id: 8, background: "geography.background.jpeg", music: "geography music.mp3")
        quiztheme(id: 9, background: "ecology.background.jpeg", music: "ecology music.mp3")
        quiztheme(id: 10, background: "physics.background.jpeg", music: "physics music.mp3")
        quiztheme(id: 11, background: "chemistry.background.jpeg", music: "chemistry music.mp3")
        quiztheme(id: 12, background: "informatics.background.jpeg", music: "informatics music.mp3")
        quiztheme(id: 13, background: "literature.background.jpeg", music: "literature music.mp3")
        quiztheme(id: 14, background: "drive.background.jpeg", music: "drive music.mp3")
        quiztheme(id: 15, background: "swift.background.jpeg", music: "Swift music.mp3")
        quiztheme(id: 16, background: "underwater.background.jpeg", music: "underwater music.mp3")
        quiztheme(id: 17, background: "chess.background.jpeg", music: "chess music.mp3")
        
        //SayQuestionButton.sizeToFit()
        PauseButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        questionText.font = UIFont.boldSystemFont(ofSize: 20)
        Time.font = UIFont.boldSystemFont(ofSize: 15)
        Attempts.font = UIFont.boldSystemFont(ofSize: 15)
        Score.font = UIFont.boldSystemFont(ofSize: 15)
        SayQuestionButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        AnswersButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
    }
    
    @IBAction func RecordAnswer(_ sender: UIButton) {
        
        configureAudioSession()
        
        CheckChoiceNumber()
        
        let checkvoice = quiz?.checkAnswer(check2)
        
        if !sender.isSelected{
            recognizeButton.setImage(UIImage(named: "microphone selected"), for: .normal)
            questionText.text = "Говорите ответ..."
            recognizeButton.isUserInteractionEnabled = false
            stop()
        } else {
            recognizeButton.setImage(UIImage(named: "microphone"), for: .normal)
            questionText.text = ("Вопрос №\(quiz?.checkQuestionNumber() ?? 0) \(quiz?.checkQuestion() ?? "")")
            recognizeButton.isUserInteractionEnabled = true
        }
        
        if recognizeButton.isSelected && checkvoice == true && counter < 100 {
            
            
            if quiz?.questionNumber == 19 {
                PresentTotalScreen()
            }
            
            if Choice1.titleLabel?.text == check2 {
                Choice1.backgroundColor = UIColor.systemGreen
            }
            
            if Choice2.titleLabel?.text == check2 {
                Choice2.backgroundColor = UIColor.systemGreen
            }
            
            if Choice3.titleLabel?.text == check2 {
                Choice3.backgroundColor = UIColor.systemGreen
            }
            
            
            counter += 5
            CorrectAnswersCounter += 1
            
            
            Score.text = ("Счет: \(CorrectAnswersCounter)")
            print("Голос \(check2)")
            
            quiz?.nextQuestion()
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
            
            SCLAlertView().showSuccess("Правильно 👍👍👍!!!", subTitle: check2)
            Timer.scheduledTimer(timeInterval:0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
        }
        
        
        if recognizeButton.isSelected && checkvoice == false && self.Attempts != nil && check2 != "" {
            
            if Choice1.titleLabel?.text == check2 {
                Choice1.backgroundColor = UIColor.systemRed
            }
            
            if Choice2.titleLabel?.text == check2 {
                Choice2.backgroundColor = UIColor.systemRed
            }
            
            if Choice3.titleLabel?.text == check2 {
                Choice3.backgroundColor = UIColor.systemRed
            }
            
            AttemptsCounter -= 1
            Attempts.text = "Попыток осталось: \(AttemptsCounter)"
            print(AttemptsCounter)
            
            print("Голос \(check2)")
            Score.text = ("Счет: \(String(counter))")
            Attempts.text = "Попыток осталось: \(AttemptsCounter)"
            
            //quiz?.nextQuestion()
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
            
            SCLAlertView().showError("\(check2) не верный ответ 👎👎👎!!!", subTitle: "попробуйте еще раз")
            //viewDidLoad()
            //player.Sound(resource: "fail2.mp3")
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
        
        sender.isSelected = !sender.isSelected
        
    }
    

    @IBAction func sayquestion() {
        say()
    }
    
    
    @IBAction func OnOffSound() {
        self.stopMusic(id: 1, resource: "space music.mp3")
        self.stopMusic(id: 2, resource: "history music.mp3")
        self.stopMusic(id: 3, resource: "anatomy music.mp3")
        self.stopMusic(id: 4, resource: "sport music.mp3")
        self.stopMusic(id: 5, resource: "games music.mp3")
        self.stopMusic(id: 6, resource: "IQ music.mp3")
        self.stopMusic(id: 7, resource: "economy music.mp3")
        self.stopMusic(id: 8, resource: "geography music.mp3")
        self.stopMusic(id: 9, resource: "ecology music.mp3")
        self.stopMusic(id: 10, resource: "physics music.mp3")
        self.stopMusic(id: 11, resource: "chemistry music.mp3")
        self.stopMusic(id: 12, resource: "informatics music.mp3")
        self.stopMusic(id: 13, resource: "literature music.mp3")
        self.stopMusic(id: 14, resource: "drive music.mp3")
        self.stopMusic(id: 15, resource: "Swift music.mp3")
        self.stopMusic(id: 16, resource: "underwater music.mp3")
        self.stopMusic(id: 17, resource: "chess music.mp3")
        
    }
    
    @IBAction func answerSelected(_ sender: UIButton) {
        
        let userAnswer = sender.currentTitle!
        let check = quiz?.checkAnswer(userAnswer)
        
        
        if  check! && counter < 100 {
            
            RestartTimer()
            
            if quiz?.questionNumber == 19 {
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
            }
            
            sender.backgroundColor = UIColor.green;
            SCLAlertView().showSuccess("Правильно", subTitle: "правильный ответ: \(quiz?.checkAnswer() ?? "")")
            //player.Sound(resource: "victory_sound.mp3")
            
            counter += 5
            CorrectAnswersCounter += 1
            
            Score.text = ("Счет: \(String(counter))")
            animation.springLabel(label: Score)
            
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
            
        } else if !check! {
            
            
            RestartTimer()
            
            if quiz?.questionNumber == 19 {
                PresentTotalScreen()
            }
            
            if AttemptsCounter == 0 && self.AttemptsStatus == true {
                PresentTotalScreen()
            }
            
            if counter == 0 && self.Attempts != nil {
                sender.backgroundColor = UIColor.red;
                SCLAlertView().showError("не правильно", subTitle: "правильный ответ: \(quiz?.checkAnswer() ?? "")")
                //player.Sound(resource: "fail2.mp3")
                counter = 0
                AttemptsCounter -= 1
                UnCorrectAnswersCounter += 1
                Score.text = ("Счет: \(String(counter))")
                Attempts.text = ("Попыток осталось: \(String(AttemptsCounter))")
                animation.springLabel(label: Attempts)
                
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
                
            } else if counter > 0 && self.Attempts != nil {
                sender.backgroundColor = UIColor.red;
                SCLAlertView().showError("не правильно", subTitle: "правильный ответ:  \(quiz?.checkAnswer() ?? "")")
                //player.Sound(resource: "fail2.mp3")
                AttemptsCounter -= 1
                UnCorrectAnswersCounter += 1
                Score.text = ("Счет: \(String(counter))")
                Attempts.text = ("Попыток осталось: \(String(AttemptsCounter))")
                animation.springLabel(label: Attempts)
                
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
        quiz?.nextQuestion()
        
        
        Timer.scheduledTimer(timeInterval:0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
    }
    
    @IBAction func PresentСategoryScreen() {
        self.captureSession.stopRunning()
        pause()
        player.Sound(resource: "pause_sound.mp3")
    }
    
    @IBAction func showAnswer() {
        
        if AnswersCounter <= 0 {
            SCLAlertView().showWarning("У вас осталось 0 подсказок", subTitle: "решайте сами")
            AnswersCounter = 0
            AnswersButton.setTitle(" \(AnswersCounter)", for: .normal)
            AnswersButton.isUserInteractionEnabled = false
        } else {
            AnswersCounter = AnswersCounter - 1
            AnswersButton.setTitle(" \(AnswersCounter)", for: .normal)
            //SCLAlertView().showWarning("Ответ", subTitle: "правильный ответ: \(quiz?.checkAnswer() ?? "")")
            if Choice1.titleLabel?.text != quiz?.checkAnswer() {
                //Choice1.isEnabled = false
                Choice1.layer.borderColor = UIColor.clear.cgColor
                //Choice1.titleLabel?.textColor = UIColor.clear
                Choice1.setTitle("", for: .normal)
            }
            
            if Choice2.titleLabel?.text != quiz?.checkAnswer() {
                //Choice2.isEnabled = false
                Choice2.layer.borderColor = UIColor.clear.cgColor
                //Choice1.titleLabel?.textColor = UIColor.clear
                Choice2.setTitle("", for: .normal)
            }
            
            if Choice3.titleLabel?.text != quiz?.checkAnswer() {
                //Choice3.isEnabled = false
                Choice3.layer.borderColor = UIColor.clear.cgColor
                //Choice1.titleLabel?.textColor = UIColor.clear
                Choice3.setTitle("", for: .normal)
            }
        }
        
        print(AnswersCounter)
    }
    
}


extension BaseQuizViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    func say() {
        if isTalking == false {
            self.SayQuestionButton.setImage(UIImage(named: "synthesizer selected"), for: .normal)
            let utterance = AVSpeechUtterance(string: "\(quiz?.checkQuestion() ?? "")\(quiz?.checkChoices() ?? [""]) ")
            utterance.voice = AVSpeechSynthesisVoice(language: "ru-RU")
            synthesizer.speak(utterance)
            isTalking = true
        } else {
            synthesizer.stopSpeaking(at: .immediate)
            isTalking = false
            self.SayQuestionButton.setImage(UIImage(named: "synthesizer"), for: .normal)
        }
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
                    CheckChoiceNumber()
                }
            } else if let error = error {
                print("\(error.localizedDescription)")
            }
        })
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                "image": image,
                "background": background
            ]
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("success")
                print(ref)
            }
        }
        
    }
    
    func CurrentQuiz() {
        var currentquiz = UserDefaults.standard.set(quiz?.checkid(), forKey: "currentquiz")
        var currentscore = UserDefaults.standard.set(counter, forKey: "currentscore")
        var currentquestion = UserDefaults.standard.set(quiz?.checkQuestionNumber(), forKey: "currentquestion")
        
    }
    
    func write(id: Int, quizpath: String, category: String) {
        let db = Firestore.firestore()
        
        if quiz?.checkid() == id {
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
                CurrentQuiz()
            case "history":
                LastQuiz(category: "история", image: "history.jpeg", background: "history.background.jpeg")
                CurrentQuiz()
            case "anatomy":
                LastQuiz(category: "анатомия", image: "anatomy.jpeg", background: "anatomy.background.jpeg")
                CurrentQuiz()
            case "sport":
                LastQuiz(category: "спорт", image: "sport.jpeg", background: "sport.background.jpeg")
                CurrentQuiz()
            case "games":
                LastQuiz(category: "игры", image: "games.jpeg", background: "games.background.jpeg")
                CurrentQuiz()
            case "IQ":
                LastQuiz(category: "IQ", image: "IQ.jpeg", background: "IQ.background.jpeg")
                CurrentQuiz()
            case "economy":
                LastQuiz(category: "экономика", image: "economy.jpeg", background: "economy.background.jpeg")
                CurrentQuiz()
            case "geography":
                LastQuiz(category: "география", image: "geography.jpeg", background: "geography.background.jpeg")
                CurrentQuiz()
            case "ecology":
                LastQuiz(category: "экология", image: "ecology.jpeg", background: "ecology.background.jpeg")
                CurrentQuiz()
            case "physics":
                LastQuiz(category: "физика", image: "physics.jpeg", background: "physics.background.jpeg")
                CurrentQuiz()
            case "chemistry":
                LastQuiz(category: "химия", image: "chemistry.jpeg", background: "chemistry.background.jpeg")
                CurrentQuiz()
            case "informatics":
                LastQuiz(category: "информатика", image: "informatics.jpeg", background: "informatics.background.jpeg")
                CurrentQuiz()
            case "literature":
                LastQuiz(category: "литература", image: "literature.jpeg", background: "literature.background.jpeg")
                CurrentQuiz()
            case "roadtraffic":
                LastQuiz(category: "ПДД", image: "drive.jpeg", background: "drive.background.jpeg")
                CurrentQuiz()
            case "Swift":
                LastQuiz(category: "Swift", image: "swift.jpeg", background: "swift.background.jpeg")
                CurrentQuiz()
            case "underwater":
                LastQuiz(category: "подводный мир", image: "underwater.png", background: "underwater.background.jpeg")
                CurrentQuiz()
            case "chess":
                LastQuiz(category: "шахматы", image: "chess.png", background: "chess.background.jpeg")
                CurrentQuiz()
                
            default:
                break
            }
            
        }
    }
    
    
    func level() {
        if Time != nil {
            if quiz?.checklevel() == .easy {
                seconds = 60
                //questionText.textColor = UIColor.systemGreen
                Time.text = ("Осталось: \(String(seconds)) секунд")
            } else if quiz?.checklevel() == . normal {
                seconds = 30
                //questionText.textColor = UIColor.systemYellow
                Time.text = ("Осталось: \(String(seconds)) секунд")
            } else if quiz?.checklevel() == . hard {
                seconds = 15
                //questionText.textColor = UIColor.systemRed
                Time.text = ("Осталось: \(String(seconds)) секунд")
            }
        }
    }
    
    @objc func timerClass() {
        
        if Time != nil {
            seconds -= 1
            Time.text = ("Осталось: \(String(seconds)) секунд")
        }
        
        if self.TimerStatus == false {
            timer.invalidate()
            
            if Time != nil {
                Time.removeFromSuperview()
            }
        }
        
        
        if Time != nil {
            if (seconds <= 5 ) {
                animation.springLabel(label: Time)
                Time.textColor = UIColor.red
            }
            
            if (seconds > 5) {
                Time.textColor = UIColor.systemGreen
            }
            
            if (seconds > 0) && (seconds < 5) {
                Time.text = ("Осталось: \(String(seconds)) секунды")
            }
            
            if (seconds == 1) {
                Time.text = ("Осталось: \(String(seconds)) секунда")
            }
            
            
            if (seconds == 0) {
                
                if quiz?.questionNumber == 19 {
                    PresentTotalScreen()
                }
                
                if AttemptsCounter == 0 && self.AttemptsStatus == true {
                    PresentTotalScreen()
                }
                
                if counter == 0 && self.Attempts != nil {
                    counter = 0
                    AttemptsCounter -= 1
                    Score.text = ("Счет: \(String(counter))")
                    Attempts.text = ("Попыток осталось: \(String(AttemptsCounter))")
                    animation.springLabel(label: Attempts)
                } else if counter > 0 && self.Attempts != nil {
                    AttemptsCounter -= 1
                    Score.text = ("Счет: \(String(counter))")
                    Attempts.text = ("Попыток осталось: \(String(AttemptsCounter))")
                    animation.springLabel(label: Attempts)
                    animation.springLabel(label: Score)
                }
                
                //timer.invalidate()
                
                quiz?.nextQuestion()
                
                //RestartTimer()
                
                Timer.scheduledTimer(timeInterval:0.1, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
            }
        }
    }
    
    func RestartTimer() {
        timer.invalidate()
        level()
        if Time != nil {
            Time.text = String(seconds)
        }
        timerClass()
        startTimer()
    }
    
    func startTimer() {
        //Make sure there arent any others timers running
        timer.invalidate()
        //Create the timer
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(BaseQuizViewController.timerClass), userInfo: nil, repeats: true)
    }
    
    
    func setQuizeModel(quiz: QuizBase) {
        self.quiz = quiz
    }
    
    func quiztheme(id: Int, background: String, music: String) {
        if quiz?.checkid() == id {
            view.backgroundColor = UIColor(patternImage: UIImage(named: background)!)
            player.Sound(resource: music)
            self.checkMusicSetting()
            CurrentMusic(id: id, resource: " \(music)")
        }
        
        if quiz?.checkid() == 10 {
            questionText.textColor = UIColor.black
            Score.textColor = UIColor.black
            Attempts.textColor = UIColor.black
            Choice1.setTitleColor(.black, for: .normal)
            Choice2.setTitleColor(.black, for: .normal)
            Choice3.setTitleColor(.black, for: .normal)
        }
    }
    
    
    private func configureAudioSession() {
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playAndRecord, options: .mixWithOthers)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch { }
    }
    
    func CheckChoiceNumber() {
        
        
        if check2.contains("один") || check2.contains("Один") {
            //check2 = "1"
            check2 = quiz?.checkChoices()[0] ?? ""
            questionText.text = ("Ваш ответ: \(check2)")
        }
        
        if check2.contains("два") || check2.contains("Два") {
            //check2 = "1"
            check2 = quiz?.checkChoices()[1] ?? ""
            questionText.text = ("Ваш ответ: \(check2)")
        }
        
        if check2.contains("три") || check2.contains("Три") {
            //check2 = "1"
            check2 = quiz?.checkChoices()[2] ?? ""
            questionText.text = ("Ваш ответ: \(check2)")
        }
        
        if check2.contains("первый") || check2.contains("Первый") {
            //check2 = "1"
            check2 = quiz?.checkChoices()[0] ?? ""
            questionText.text = ("Ваш ответ: \(check2)")
        }
        
        if check2.contains("второй") || check2.contains("Второй") {
            //check2 = "1"
            check2 = quiz?.checkChoices()[1] ?? ""
            questionText.text = ("Ваш ответ: \(check2)")
        }
        
        if check2.contains("третий") || check2.contains("Третий") {
            //check2 = "1"
            check2 = quiz?.checkChoices()[2] ?? ""
            questionText.text = ("Ваш ответ: \(check2)")
        }
        
        
    }
    
    
    func stop() {
        var timeLeft = 6
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            print("timer fired!")
            
            timeLeft -= 1
            
            
            self.recognizeButton.setTitle(String(timeLeft), for: .normal)
            self.animation.springLabel(label: self.recognizeButton.titleLabel!)
            
            print(timeLeft)
            
            
            if(timeLeft==0){
                self.recognizeButton.setTitle(String(timeLeft), for: .normal)
                
                timer.invalidate()
                self.audioEngine.stop()
                self.request.endAudio()
                self.recognitionTask?.cancel()
                self.audioEngine.inputNode.removeTap(onBus: 0)
                //stop = sender.isSelected
                
                self.recognizeButton.setImage(UIImage(named: "microphone"), for: .normal)
                self.recognizeButton.sendActions(for: .touchUpInside)
            }
            
            
        }
        
        //self.recognizeButton.sendActions(for: .touchUpInside)
    }
    
    
    func StopMusicOption(id: Int, resource: String) {
        if quiz?.checkid() == id {
            if MusicStatus == false {
                player.StopSound(resource: resource)
                OnOffButton.isUserInteractionEnabled = false
                OnOffButton.removeFromSuperview()
            }
        }
    }
    
    func CurrentMusic(id: Int, resource: String) {
        OnOffButton.setTitle(resource, for: .normal)
    }
    
    func stopMusic(id: Int, resource: String) {
        if quiz?.checkid() == id {
            if self.OnOffButton != nil {
                if isPlaying == true {
                    player.StopSound(resource: resource)
                    isPlaying = false
                    OnOffButton.setTitle(" \(resource)", for: .normal)
                    OnOffButton.setImage(UIImage(named: "music button"), for: .normal)
                } else if isPlaying == false || self.MusicStatus == false {
                    print("Music: \(self.MusicStatus)")
                    player.Sound(resource: resource)
                    isPlaying = true
                    OnOffButton.setTitle(" \(resource)", for: .normal)
                    OnOffButton.setImage(UIImage(named: "music button selected"), for: .normal)
                }
            }
        }
    }

    
    
    func checkSpeachSetting() {
        var isSpeachOn = UserDefaults.standard.object(forKey: "onstatusspeach") as? Bool
        
        print(isSpeachOn)
        
        if isSpeachOn == true {
            print("speach now")
        } else if isSpeachOn == false {
            print("speach not now")
            self.SpeachStatus = false
        }
        
        if self.SpeachStatus == false {
            print("speach doesnt working")
            self.SayQuestionButton.isEnabled = false
            self.SayQuestionButton.removeFromSuperview()
        } else {}
    }
    
    func checkHintsSetting() {
        var isHintsOn = UserDefaults.standard.object(forKey: "onstatushints") as? Bool
        
        print(isHintsOn)
        
        if isHintsOn == true {
            print("hints now")
        } else if isHintsOn == false {
            print("hints not now")
            //self.captureSession.stopRunning()
            self.HintsStatus = false
        }
        
        if self.HintsStatus == false {
            print("hints doesnt working")
            self.AnswersButton.isEnabled = false
            self.AnswersButton.removeFromSuperview()
            //timer.invalidate()
        } else {
            //timer.fire()
        }
    }
    
    func checkGestureSetting() {
        
        var isRecordOnn = UserDefaults.standard.object(forKey: "onstatus") as? Bool
        
        if isRecordOnn == true {
            print("record now")
        } else if isRecordOnn == false {
            print("record not now")
            //self.captureSession.stopRunning()
            self.GestureRecording = false
        }
        
        if self.GestureRecording == false {
            //timer.invalidate()
            print("time out")
            self.captureSession.stopRunning()
        }
    }
    
    func checkAudioSetting() {
        var isRecordOnAudio = UserDefaults.standard.object(forKey: "onstatusaudio") as? Bool
        
        print(isRecordOnAudio)
        
        if isRecordOnAudio == true {
            print("record audio now")
        } else if isRecordOnAudio == false {
            print("record audio not now")
            //self.captureSession.stopRunning()
            self.VoiceRecording = false
        }
        
        if self.VoiceRecording == false {
            print("audio doesnt working")
            self.recognizeButton.isEnabled = false
            self.recognizeButton.removeFromSuperview()
            //timer.invalidate()
        } else {
            //timer.fire()
        }
    }
    
    
    func checkMusicSetting() {
        var isMusicOn = UserDefaults.standard.object(forKey: "onstatusmusic") as? Bool
        
        print("Музыка \(isMusicOn)")
        
        if isMusicOn == true {
            print("music now")
        } else if isMusicOn == false {
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
        } else if isTimerOn == false {
            print("timer not now")
            //self.captureSession.stopRunning()
            self.TimerStatus = false
        }
    }
    
    func checkAttemptsSetting() {
        var isAttemptsOn = UserDefaults.standard.object(forKey: "onstatusattempts") as? Bool
        
        print(isAttemptsOn)
        
        if isAttemptsOn == true {
            print("attempts now")
        } else if isAttemptsOn == false {
            print("attempts not now")
            //self.captureSession.stopRunning()
            self.AttemptsStatus = false
        }
        
        if self.AttemptsStatus == false {
            self.Attempts.removeFromSuperview()
        }
    }
    
    @objc func ShowAnswers() {
        SCLAlertView().showInfo("варианты ответов", subTitle: "1)\(quiz?.checkChoices()[0] ?? "") 2)\(quiz?.checkChoices()[1] ?? "") 3)\(quiz?.checkChoices()[2] ?? "")")
    }
    
    func pause() {
        
        self.VoiceRecording = false
        self.GestureRecording = false
        
        //self.captureSession.stopRunning()
        self.synthesizer.stopSpeaking(at: .immediate)
        
        self.CurrentQuiz()
}
    
    func PresentTotalScreen() {
        
        self.VoiceRecording = false
        self.GestureRecording = false
        
        //self.captureSession.stopRunning()
        self.synthesizer.stopSpeaking(at: .immediate)
        
        DispatchQueue.main.async {
            
            self.captureSession.stopRunning()
            print("В данный момент: \(self.captureSession.isRunning)")
            
//            self.stopMusic(id: 1, resource: "space music.mp3")
//            self.stopMusic(id: 2, resource: "history music.mp3")
//            self.stopMusic(id: 3, resource: "history music.mp3")
//            self.stopMusic(id: 4, resource: "sport music.mp3")
//            self.stopMusic(id: 5, resource: "games music.mp3")
//            self.stopMusic(id: 6, resource: "IQ music.mp3")
//            self.stopMusic(id: 7, resource: "economy music.mp3")
//            self.stopMusic(id: 8, resource: "geography music.mp3")
//            self.stopMusic(id: 9, resource: "ecology music.mp3")
//            self.stopMusic(id: 10, resource: "physics music.mp3")
//            self.stopMusic(id: 11, resource: "chemistry music.mp3")
//            self.stopMusic(id: 12, resource: "informatics music.mp3")
//            self.stopMusic(id: 13, resource: "literature music.mp3")
//            self.stopMusic(id: 14, resource: "drive music.mp3")
//            self.stopMusic(id: 15, resource: "Swift music.mp3")
//            self.stopMusic(id: 16, resource: "underwater music.mp3")
//            self.stopMusic(id: 17, resource: "chess music.mp3")
            
            guard let vc = self.storyboard?.instantiateViewController(identifier: "BaseTotalQuizViewController") else {return}
            guard let window = self.view.window else {return}
            window.rootViewController = vc
        }
    }
    
    @objc func updateUI(){
        
        level()
        
        questionText.text = ("Вопрос №\(quiz?.checkQuestionNumber() ?? 0): \(quiz?.checkQuestion() ?? "")")
        
        
        Score.text = "Счет: \(counter)"
        
        
        quiz?.nextQuiz()
        
        Choice1.backgroundColor = UIColor.clear
        Choice2.backgroundColor = UIColor.clear
        Choice3.backgroundColor = UIColor.clear
        
        Choice1.setTitle(quiz?.checkChoices()[0], for: .normal)
        Choice2.setTitle(quiz?.checkChoices()[1], for: .normal)
        Choice3.setTitle(quiz?.checkChoices()[2], for: .normal)
        
        Image.image = UIImage(named: quiz?.checkImage() ?? "")
//        Image.layer.cornerRadius = Image.frame.size.width / 50
//        Image.clipsToBounds = true
//        Image.layer.borderWidth = 1
//        Image.layer.borderColor = UIColor.black.cgColor
        
        Choice1.layer.cornerRadius = Choice1.frame.size.width / 10
        Choice1.clipsToBounds = true
        Choice1.layer.borderWidth = 5
        Choice1.layer.borderColor = UIColor.black.cgColor
        
        Choice2.layer.cornerRadius = Choice2.frame.size.width / 10
        Choice2.clipsToBounds = true
        Choice2.layer.borderWidth = 5
        Choice2.layer.borderColor = UIColor.black.cgColor
        
        Choice3.layer.cornerRadius = Choice3.frame.size.width / 10
        Choice3.clipsToBounds = true
        Choice3.layer.borderWidth = 5
        Choice3.layer.borderColor = UIColor.black.cgColor
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        prepareCamera()
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
    
    
    func showAndSendCommand(command: RemoteCommand) {
        if command == .one {
            DispatchQueue.main.async {
                self.check2 = (self.quiz?.checkChoices()[0])!
                self.questionText.text = self.check2
                self.GestureAnswer()
            }
        } else if command == .two {
            DispatchQueue.main.async {
                self.check2 = (self.quiz?.checkChoices()[1])!
                self.questionText.text = self.check2
                self.GestureAnswer()
            }
        }
    }
    
    
    func isRecordingNow() {
    
        DispatchQueue.main.async {
            
            self.checkGestureSetting()
            
            if self.captureSession.isRunning == true {
                self.RecordVideoLabeL.text = "Rec ●"
                self.RecordVideoLabeL.textColor = UIColor.systemRed
                self.RecordVideoLabeL.font = UIFont(name: "System", size: 20)
                print("is recording")
                
            } else if self.captureSession.isRunning == false {
                
                self.RecordVideoLabeL.text = "Rec ●"
                self.RecordVideoLabeL.textColor = UIColor.systemGreen
                self.RecordVideoLabeL.font = UIFont(name: "System", size: 20)
                print("isn't recording")
                print(self.captureSession.isRunning)
                
                var timeLeft = 4
                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                    print("timer fired!")
                    
                    timeLeft -= 1
                    
                    self.RecordVideoLabeL.text = "Rec ● \(timeLeft)"
                    
                    
                    if self.GestureRecording == false {
                        timeLeft = 0
                    }
                    
                    print(timeLeft)
                    
                    if(timeLeft==0)  {
                        timer.invalidate()
                        self.RecordVideoLabeL.text = "Rec ●"
                    }
                }
                
            }
        }
        
    }
    
    
    
    func GestureAnswer() {
        
        let checkgesture = quiz?.checkAnswer(check2)
        
        
        if checkgesture == true && check2 != "" && counter < 100 {
            
            self.captureSession.stopRunning()
            
            self.isRecordingNow()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.captureSession.startRunning()
                self.isRecordingNow()
            }
            
            if quiz?.questionNumber == 19 {
                PresentTotalScreen()
            }
            
            if AttemptsCounter == 0 && self.AttemptsStatus == true {
                PresentTotalScreen()
            }
            
            if Choice1.titleLabel?.text == check2 {
                Choice1.backgroundColor = UIColor.systemGreen
            }
            
            if Choice2.titleLabel?.text == check2 {
                Choice2.backgroundColor = UIColor.systemGreen
            }
            
            if Choice3.titleLabel?.text == check2 {
                Choice3.backgroundColor = UIColor.systemGreen
            }
            
            counter += 5
            CorrectAnswersCounter += 1
            Score.text = ("Счет: \(CorrectAnswersCounter)")
            
            
            quiz?.nextQuestion()
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
            
            //SCLAlertView().showSuccess("Правильно 👍👍👍!!!", subTitle: check2)
            Timer.scheduledTimer(timeInterval:0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
        }
        
        
        
        if checkgesture == false && check2 != "" && self.Attempts != nil {
            
            self.captureSession.stopRunning()
            
            if AttemptsCounter == 0 && self.AttemptsStatus == true {
                PresentTotalScreen()
            }
            
            isRecordingNow()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.captureSession.startRunning()
                self.isRecordingNow()
            }
            
            if quiz?.questionNumber == 19 {
                PresentTotalScreen()
            }
            
            if Choice1.titleLabel?.text == check2 {
                Choice1.backgroundColor = UIColor.systemRed
            }
            
            if Choice2.titleLabel?.text == check2 {
                Choice2.backgroundColor = UIColor.systemRed
            }
            
            if Choice3.titleLabel?.text == check2 {
                Choice3.backgroundColor = UIColor.systemRed
            }
            
            AttemptsCounter -= 1
            Attempts.text = "Попыток осталось: \(AttemptsCounter)"
            print(AttemptsCounter)
            
            print("Голос \(check2)")
            Score.text = ("Счет: \(String(counter))")
            Attempts.text = "Попыток осталось: \(AttemptsCounter)"
            
            quiz?.nextQuestion()
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
            
            //SCLAlertView().showError("\(check2) не верный ответ 👎👎👎!!!", subTitle: "попробуйте еще раз")
            Timer.scheduledTimer(timeInterval:0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
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
}
