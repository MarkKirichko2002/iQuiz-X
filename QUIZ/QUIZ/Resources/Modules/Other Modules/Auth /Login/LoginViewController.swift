//
//  LoginViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 15.02.2022.
//

import UIKit
import Firebase
import SCLAlertView
import FirebaseFirestore
import LocalAuthentication
import SDWebImage
import AVFoundation
import Speech
import Swinject
import SwinjectStoryboard

final class LoginViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var RegisterButton: UIButton!
    @IBOutlet weak var BiometricAuthButton: UIButton!
    @IBOutlet weak var VoiceButton: UIButton!
    @IBOutlet weak var view2: UIView!
    
    private var token: AuthStateDidChangeListenerHandle!
    let mycontext: LAContext = LAContext()
    var auth = FirebaseManager()
    var UnlockVoiceFailsCounter = 0
    var UnlockBiometricFailsCounter = 0
    
    let synthesizer = AVSpeechSynthesizer()
    var check2 = ""
    var word = ("","")
    var animation = AnimationClass()
    
    var player2:AVAudioPlayer?
    var player = SoundClass()
    
    let audioEngine = AVAudioEngine()
    let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ru_RU"))
    let request = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask: SFSpeechRecognitionTask?
    var BiometricStatus = true
    let speaker = AVSpeechSynthesizer()
    let dialogue = AVSpeechUtterance(string: "доступ разрешен")
    private let speechRecognitionManager = SpeechRecognitionManager()
    
    private let container: Container = {
        let container = Container()
        container.storyboardInitCompleted(QuizSplashScreenController.self) { r, c in
            c.animation = r.resolve(AnimationClassProtocol.self)
        }
        container.register(AnimationClassProtocol.self) { _ in
            return AnimationClass()
        }
        return container
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.CheckBiometricSetting()
        
        if mycontext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            if mycontext.biometryType == .faceID {
                BiometricAuthButton.titleLabel?.text = "Face ID"
            } else if mycontext.biometryType == .touchID {
                BiometricAuthButton.titleLabel?.text = "Touch ID"
            }
            self.navigationItem.hidesBackButton = true
        }
        
        view.backgroundColor = UIColor(patternImage: UIImage(named: "earth.background.jpeg")!)
        view2.backgroundColor = UIColor(patternImage: UIImage(named: "earth.background.jpeg")!)
        scrollView.backgroundColor = UIColor(patternImage: UIImage(named: "earth.background.jpeg")!)
        
        loginButton.layer.cornerRadius = loginButton.frame.size.width / 20
        loginButton.clipsToBounds = true
        
        loginButton.layer.borderWidth = 2
        loginButton.layer.borderColor = UIColor.black.cgColor
        
        RegisterButton.layer.cornerRadius = RegisterButton.frame.size.width / 20
        RegisterButton.clipsToBounds = true
        
        RegisterButton.layer.borderWidth = 2
        RegisterButton.layer.borderColor = UIColor.black.cgColor
        
        loginTextField.layer.cornerRadius = loginTextField.frame.size.width / 20
        loginTextField.clipsToBounds = true
        
        loginTextField.layer.borderWidth = 2
        loginTextField.layer.borderColor = UIColor.black.cgColor
        
        passwordTextField.layer.cornerRadius = passwordTextField.frame.size.width / 20
        passwordTextField.clipsToBounds = true
        
        passwordTextField.layer.borderWidth = 2
        passwordTextField.layer.borderColor = UIColor.black.cgColor
        
        BiometricAuthButton.layer.cornerRadius = BiometricAuthButton.frame.size.width / 20
        BiometricAuthButton.clipsToBounds = true
        
        BiometricAuthButton.layer.borderWidth = 2
        BiometricAuthButton.layer.borderColor = UIColor.black.cgColor
        
        // Жест нажатия
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        // Присваиваем его UIScrollVIew
        scrollView.addGestureRecognizer(hideKeyboardGesture)
        
        let storyboard = SwinjectStoryboard.create(name: "Main", bundle: nil, container: container)
        let vc = storyboard.instantiateViewController(withIdentifier: "QuizSplashScreenController")
        
        token = Auth.auth().addStateDidChangeListener{[weak self] auth, user in
            guard user != nil else {return}
            DispatchQueue.main.async {
                guard let window = self!.view.window else {return}
                window.rootViewController = vc
            }
        }
    }
    
    private func CheckBiometricSetting() {
        
        let isBiometricOn = UserDefaults.standard.object(forKey: "onstatusbiometric") as? Bool
        
        print(isBiometricOn)
        
        if isBiometricOn == true {
            print("biometric now")
        } else if isBiometricOn == false {
            print("biometric not now")
            self.BiometricStatus = false
        }
        
        if self.BiometricStatus == false {
            print("biometric doesnt working")
            self.BiometricAuthButton.isUserInteractionEnabled = false
            self.BiometricAuthButton.setTitle("выключено", for: .normal)
        } else {}
    }
    
    private func loadData() {
        
        let defaults = UserDefaults.standard
        
        var email = defaults.object(forKey:"email") as? String
        
        var password = defaults.object(forKey:"password") as? String
        
        print(email)
        print(password)
       
        var auth = ""
        
        if mycontext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            if mycontext.biometryType == .faceID {
                auth = "Face ID"
            } else if mycontext.biometryType == .touchID {
                auth = "Touch ID"
            }
            self.navigationItem.hidesBackButton = true
        }
        
        if email == nil || email == ""  {
            print("нет email")
            
            let alert = UIAlertController(title: "У вас отсутствуют данные для биометрической аутентификация. Хотите добавить данные для \(auth)", message: "Введите логин и пароль", preferredStyle: .alert)
            
            alert.addTextField { (textField) in
                textField.text = ""
                textField.placeholder = "Введите логин"
                
                alert.addTextField { (textField) in
                    textField.text = ""
                    textField.placeholder = "Введите пароль"
                }
            }
            
            alert.addAction(UIAlertAction(title: "нет", style: .cancel, handler: { (action: UIAlertAction!) in
                print("Handle Cancel Logic here")
            }))
            
            alert.addAction(UIAlertAction(title: "да", style: .default, handler: { [weak alert] (_) in
                let textField = alert?.textFields![0]
                let textField2 = alert?.textFields![1]
                
                email = textField?.text
                password = textField2?.text
                
                let a = defaults.set(email, forKey: "email")
                
                let b = defaults.set(password, forKey: "password")
                
                print(a)
                print(b)
                
            }))
            
            self.present(alert, animated: true, completion: nil)
            
        } else {
            let db = Firestore.firestore()
            let docRef = db.collection("users").document(email ?? "mystery123@gmail.com")
            
            docRef.getDocument { document, error in
                if let error = error as NSError? {
                    print("Error getting document: \(error.localizedDescription)")
                } else {
                    
                    if let document = document {
                        let data = document.data()
                        let image = data?["image"] as? String ?? ""
                        let name = data?["name"] as? String ?? ""
                        
                        if let category = document["lastquiz"] as? [String: Any] {
                            let background = category["background"] as? String
                            self.view.backgroundColor = UIColor(patternImage: UIImage(named: background!)!)
                            self.scrollView.backgroundColor = UIColor(patternImage: UIImage(named: background!)!)
                            self.view2.backgroundColor = UIColor(patternImage: UIImage(named: background!)!)
                        }
                        
                        DispatchQueue.main.async {
                            self.loginTextField.text = email
                            self.passwordTextField.text = password
                            let imageURL = URL(string: image ?? "")
                            self.loginImageView.sd_setImage(with: imageURL)
                            print("Фотка \(image)")
                            self.loginButton.sendActions(for: .touchUpInside)
                            self.titleLabel.text = name
                        }
                    }
                }
            }
        }
    }
    
    // Biometric auth
    @IBAction func useBiometrics(sender: UIButton) {
        
        if mycontext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            mycontext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Пожалуйста авторизируйтесь") { (success, error) in
                
                
                DispatchQueue.main.async {
                    if self.loginTextField.text == "" {
                        
                        if success {
                            self.loadData()
                        } else {
                            self.UnlockBiometricFailsCounter += 1
                            self.loginImageView.image = UIImage(named: "FACE ID.png")
                            self.titleLabel.text = "Лицо не распознано"
                            self.animation.SpringAnimation(view: self.loginImageView)
                        }
                        
                        if self.UnlockBiometricFailsCounter == 3 {
                            self.BiometricAuthButton.isUserInteractionEnabled = false
                            self.BiometricAuthButton.setTitle("не доступно", for: .normal)
                            self.titleLabel.text = "доступ запрещен"
                            self.loginImageView.image = UIImage(named: "lock.png")
                            self.player.PlaySound(resource: "lock_sound.mp3")
                        }
                    }
                }
            }
        }
    }
    
    // Voice Unlock
    
    private func CheckChoiceNumber() {
        
        if check2.contains("один") || check2.contains("Один") {
            check2 = "1"
            titleLabel.text = ("Ваш пароль: \(check2)")
        }
        
        if check2.contains("два") || check2.contains("Два") {
            check2 = "2"
            titleLabel.text = ("Ваш пароль: \(check2)")
        }
        
        if check2.contains("три") || check2.contains("Три") {
            check2 = "3"
            titleLabel.text = ("Ваш пароль: \(check2)")
        }
        
        if check2.contains("первый") || check2.contains("Первый") {
            check2 = "1"
            titleLabel.text = ("Ваш пароль: \(check2)")
        }
        
        if check2.contains("второй") || check2.contains("Второй") {
            check2 = "2"
            titleLabel.text = ("Ваш пароль: \(check2)")
        }
        
        if check2.contains("третий") || check2.contains("Третий") {
            check2 = "3"
            titleLabel.text = ("Ваш пароль: \(check2)")
        }
        
    }
    
    private func stop() {
        var timeLeft = 4
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            print("timer fired!")
            
            timeLeft -= 1
            
            
            self.VoiceButton.setTitle(String(timeLeft), for: .normal)
            self.animation.SpringAnimation(view: self.VoiceButton.titleLabel!)
            
            print(timeLeft)
            
            if(timeLeft==0){
                self.VoiceButton.setTitle(String(timeLeft), for: .normal)
                
                timer.invalidate()
                self.audioEngine.stop()
                self.request.endAudio()
                self.recognitionTask?.cancel()
                self.audioEngine.inputNode.removeTap(onBus: 0)
               
                self.VoiceButton.setImage(UIImage(systemName: "mic.slash"), for: .normal)
                self.VoiceButton.sendActions(for: .touchUpInside)
            }
        }
    }
    
    @IBAction func RecordPassword(_ sender: UIButton) {
        
        speechRecognitionManager.configureAudioSession()
        
        var voicepassword = UserDefaults.standard.object(forKey: "voicepassword") as? String
        
        if !sender.isSelected{
            VoiceButton.setImage(UIImage(named: "microphone selected"), for: .normal)
            titleLabel.text = "Говорите пароль..."
            stop()
            VoiceButton.isUserInteractionEnabled = false
        } else {
            VoiceButton.setImage(UIImage(named: "microphone"), for: .normal)
            titleLabel.text = ("Пароль: \(check2)")
            VoiceButton.isUserInteractionEnabled = true
            
            if voicepassword == nil {
                UserDefaults.standard.set(check2, forKey: "voicepassword")
                print(voicepassword ?? "")
            } else {
                print(voicepassword ?? "")
            }
        }
        
        if VoiceButton.isSelected && check2.contains(voicepassword ?? ""){
            loadData()
            titleLabel.text = "доступ разрешен"
            player.PlaySound(resource: "victory_sound.mp3")
        }
        
        
        if VoiceButton.isSelected && !check2.contains(voicepassword ?? "") && check2 != "" {
            UnlockVoiceFailsCounter += 1
            animation.SpringAnimation(view: loginImageView)
            titleLabel.text = ("Пароль \(check2) неверный")
            self.loginImageView.image = UIImage(named: "voice.png")
            player.PlaySound(resource: "fail2.mp3")
            print(UnlockVoiceFailsCounter)
        }
        
        if VoiceButton.isSelected && check2 == "" {
            UnlockVoiceFailsCounter += 1
            self.loginImageView.image = UIImage(named: "voice.png")
            titleLabel.text = ("Повторите пароль")
            animation.SpringAnimation(view: loginImageView)
            print(UnlockVoiceFailsCounter)
        }
        
        if UnlockVoiceFailsCounter == 3 {
            VoiceButton.isUserInteractionEnabled = false
            VoiceButton.setTitle(" не доступно", for: .normal)
            titleLabel.text = "доступ запрещен"
            loginImageView.image = UIImage(named: "lock.png")
            self.player.PlaySound(resource: "lock_sound.mp3")
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
                    self.VoiceButton.isEnabled = true
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
        }
        
        sender.isSelected = !sender.isSelected
        
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
                    self.titleLabel.text = ("Ваш пароль: \(check2)")
                }
            } else if let error = error {
                print("\(error.localizedDescription)")
            }
        })
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewWillAppear(animated)
        
        // Подписываемся на два уведомления: одно приходит при появлении клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        // Второе — когда она пропадает
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func login(_ sender: Any?) {
        guard let email = loginTextField.text, loginTextField.hasText,
              let password = passwordTextField.text, passwordTextField.hasText
        
        else {
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            
            if let error = error {
                SCLAlertView().showError("Ошибка FireBase", subTitle: error.localizedDescription)
                return
            }
            
            let defaults = UserDefaults.standard
            
            defaults.set(self?.loginTextField.text, forKey: "email")
            
            defaults.set(self?.passwordTextField.text, forKey: "password")
            
        }
        
    }
    
    @IBAction func register() {
        DispatchQueue.main.async {
            guard let vc = self.storyboard?.instantiateViewController(identifier: "RegisterViewController") else {return}
            guard let window = self.view.window else {return}
            window.rootViewController = vc
        }
    }
    
    @objc private func hideKeyboard() {
        self.scrollView.endEditing(true)
    }
    
    // Когда клавиатура появляется
    @objc private func keyboardWasShown(notification: Notification) {
        
        // Получаем размер клавиатуры
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        
        // Добавляем отступ внизу UIScrollView, равный размеру клавиатуры
        self.scrollView.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    // Когда клавиатура исчезает
    @objc private func keyboardWillBeHidden(notification: Notification) {
        // Устанавливаем отступ внизу UIScrollView, равный 0
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
}
