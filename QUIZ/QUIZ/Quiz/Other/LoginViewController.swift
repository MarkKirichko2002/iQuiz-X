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

class LoginViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var RegisterButton: UIButton!
    @IBOutlet weak var BiometricAuthButton: UIButton!
    
    private var token: AuthStateDidChangeListenerHandle!
    
    let mycontext: LAContext = LAContext()
    
    
    func loadData() {
        
        let defaults = UserDefaults.standard
        
        var email = defaults.object(forKey:"email") as? String
        
        var password = defaults.object(forKey:"password") as? String
        
        //let photo = defaults.object(forKey: "url") as? String
        
        print(email)
        print(password)
        //print(photo)
        
        var auth = ""
        
        if mycontext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            if mycontext.biometryType == .faceID {
                auth = "Face ID"
            } else if mycontext.biometryType == .touchID {
               auth = "Touch ID"
            }
            self.navigationItem.hidesBackButton = true
        }
        
        if email == nil  {
            print("нет email")
            //1. Create the alert controller.
            let alert = UIAlertController(title: "У вас отсутствуют данные для биометрической аутентификация. Хотите добавить данные для \(auth)", message: "Введите логин и пароль", preferredStyle: .alert)
            
            //2. Add the text field. You can configure it however you need.
            alert.addTextField { (textField) in
                textField.text = ""
                textField.placeholder = "Введите логин"
                
                alert.addTextField { (textField) in
                    textField.text = ""
                textField.placeholder = "Введите пароль"
                }
            }
            // 3. Grab the value from the text field, and print it when the user clicks OK.
            
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
                
                //email = defaults.set(textField?.text, forKey: "email")
                
                //password = defaults.set(self.textField2.text, forKey: "password")
                
                print(a)
                print(b)
                // print(photo)
                
            }))
            
            // 4. Present the alert.
            self.present(alert, animated: true, completion: nil)
            
        } else {
            
        }
        
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(email ?? "mystery123@gmail.com")
        
        docRef.getDocument { document, error in
            if let error = error as NSError? {
                print("Error getting document: \(error.localizedDescription)")
            }
            else {
                if let document = document {
                    let data = document.data()
                    //let email = data?["email"] as? String ?? ""
                    //let password = data?["password"] as? String ?? ""
                    let image = data?["image"] as? String ?? ""
                    
                    DispatchQueue.main.async {
                        self.loginTextField.text = email
                        self.passwordTextField.text = password
                        let imageURL = URL(string: image ?? "")
                        self.loginImageView.sd_setImage(with: imageURL)
                        print("Фотка \(image)")
                        self.loginButton.sendActions(for: .touchUpInside )
                    }
                }
            }
        }
    }
    
    
    @IBAction func useBiometrics(sender: UIButton) {
        
        if mycontext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            mycontext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Пожалуйста авторизируйтесь") { (success, error) in
                
                
                DispatchQueue.main.async {
                    if self.loginTextField.text == "" {
                        //DispatchQueue.main.async {
                        if success {
                            
                            // Что-то сделать
                            self.loadData()
                            
                            //self.loginButton.flash()
                            //self.loginImageView.flash()
                            
                            //                                DispatchQueue.main.async {
                            //                                    self.loadData()
                            //                                    guard let vc = self.storyboard?.instantiateViewController(identifier: "StartViewController") else {return}
                            //                                    guard let window = self.view.window else {return}
                            //                                    window.rootViewController = vc
                            //                               }
                            
                            
                            //                                    self.token = Auth.auth().addStateDidChangeListener{[weak self] auth, user in
                            //                                        guard user != nil else {return}
                            //                                         DispatchQueue.main.async {
                            //                                             self?.loadData()
                            //                                             guard let vc = self?.storyboard?.instantiateViewController(identifier: "StartViewController") else {return}
                            //                                             guard let window = self!.view.window else {return}
                            //                                             window.rootViewController = vc
                            //                                        }
                            //                                     }
                            
                            
                        } else {
                            
                            
                            guard let error = error else { return }
                            print(error.localizedDescription)
                        }
                        //}
                        
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //RegisterButton.flash()
        //loginButton.flash()
        //BiometricAuthButton.flash()
        
        loginTextField.placeholder = "Введите логин"
        passwordTextField.placeholder = "Введите пароль"
        
        if mycontext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            if mycontext.biometryType == .faceID {
                BiometricAuthButton.setTitle("Face ID", for: .normal)
            } else if mycontext.biometryType == .touchID {
                BiometricAuthButton.setTitle("Touch ID", for: .normal)
            }
            self.navigationItem.hidesBackButton = true
        }
        
        
        loginImageView.image = UIImage(named: "earth.jpeg")
        
        titleLabel.text = "Викторина 2022"
        
        loginButton.layer.cornerRadius = loginButton.frame.size.width / 20
        loginButton.clipsToBounds = true
        
        RegisterButton.layer.cornerRadius = RegisterButton.frame.size.width / 20
        RegisterButton.clipsToBounds = true
        
        loginTextField.layer.cornerRadius = loginTextField.frame.size.width / 20
        loginTextField.clipsToBounds = true
        
        passwordTextField.layer.cornerRadius = passwordTextField.frame.size.width / 20
        passwordTextField.clipsToBounds = true
        
        BiometricAuthButton.layer.cornerRadius = BiometricAuthButton.frame.size.width / 20
        BiometricAuthButton.clipsToBounds = true
        
        // Жест нажатия
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        // Присваиваем его UIScrollVIew
        scrollView.addGestureRecognizer(hideKeyboardGesture)
        
        token = Auth.auth().addStateDidChangeListener{[weak self] auth, user in
            guard user != nil else {return}
            DispatchQueue.main.async {
                guard let vc = self?.storyboard?.instantiateViewController(identifier: "StartViewController") else {return}
                guard let window = self!.view.window else {return}
                window.rootViewController = vc
            }
        }
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
            //SCLAlertView().showError("Данные не введены", subTitle: "введите логин или пароль")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            
            if let error = error {
                SCLAlertView().showError("Ошибка FireBase", subTitle: error.localizedDescription)
                return
            }
            
            //self?.loadData()
            
        }
        
    }
    
    
    @IBAction func register() {
        DispatchQueue.main.async {
            guard let vc = self.storyboard?.instantiateViewController(identifier: "RegisterViewController") else {return}
            guard let window = self.view.window else {return}
            window.rootViewController = vc
        }
    }
    
    
    
    @objc func hideKeyboard() {
        self.scrollView.endEditing(true)
    }
    
    
    // Когда клавиатура появляется
    @objc func keyboardWasShown(notification: Notification) {
        
        // Получаем размер клавиатуры
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        
        // Добавляем отступ внизу UIScrollView, равный размеру клавиатуры
        self.scrollView.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    // Когда клавиатура исчезает
    @objc func keyboardWillBeHidden(notification: Notification) {
        // Устанавливаем отступ внизу UIScrollView, равный 0
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
}

