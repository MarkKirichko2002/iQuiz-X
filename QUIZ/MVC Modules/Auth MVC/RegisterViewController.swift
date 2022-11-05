//
//  RegisterViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 24.02.2022.
//

import UIKit
import Firebase
import SCLAlertView
import FirebaseFirestore
import FirebaseStorage
import LocalAuthentication

class RegisterViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var RegisterButton: UIButton!
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var UploadPhotoButton: UIButton!
    @IBOutlet weak var BackButton: UIButton!
    @IBOutlet weak var view2: UIView!
    
    private var token: AuthStateDidChangeListenerHandle!
    
    private let storage = Storage.storage().reference()
    
    let db = Firestore.firestore()
    
    var urlString = ""
    
    let mycontext: LAContext = LAContext()
    
    
    func ReturnTologin() {
        DispatchQueue.main.async {
            guard let vc = self.storyboard?.instantiateViewController(identifier: "LoginViewController") else {return}
            guard let window = self.view.window else {return}
            window.rootViewController = vc
        }
    }
    
    
    func write() {
        
        let defaults = UserDefaults.standard
        
        let email = defaults.set(self.loginTextField.text, forKey: "email")
        
        let password = defaults.set(self.passwordTextField.text, forKey: "password")
        
        let image = defaults.set(self.urlString, forKey: "url")
        
        
        if NameTextField.text != "" && loginTextField.text != "" && passwordTextField.text != "" {
            db.collection("users").document(self.loginTextField.text!).setData([
                "email": loginTextField.text!,
                "name": NameTextField.text!,
                "password": passwordTextField.text!,
                "image": self.urlString
                
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    SCLAlertView().showSuccess("Успех!", subTitle: "пользователь сохранен!")
//                    var useremail = defaults.object(forKey:"email") as? String
//                    let pass = defaults.object(forKey: "password") as? String
//                    let photo = defaults.object(forKey: "url") as? String
                    
                    defaults.set(self.NameTextField.text!, forKey: "name")
                    defaults.set(self.loginTextField.text!, forKey: "email")
                    defaults.set(self.passwordTextField.text!, forKey: "password")
                    
                    defaults.set(false, forKey: "off")
                    defaults.set(false, forKey: "offaudio")
                    defaults.set(false, forKey: "offhints")
                    defaults.set(false, forKey: "offspeach")
                    defaults.set(false, forKey: "offmusic")
                    defaults.set(false, forKey: "offtimer")
                    defaults.set(false, forKey: "offattempts")
                    
                    defaults.set(false, forKey: "onstatus")
                    defaults.set(false, forKey: "onstatusaudio")
                    defaults.set(false, forKey: "onstatushints")
                    defaults.set(false, forKey: "onstatusspeach")
                    defaults.set(false, forKey: "onstatusmusic")
                    defaults.set(false, forKey: "onstatustimer")
                    defaults.set(false, forKey: "onstatusattempts")
                    
                }
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "earth.background.jpeg")!)
        view2.backgroundColor = UIColor(patternImage: UIImage(named: "earth.background.jpeg")!)
        scrollView.backgroundColor = UIColor(patternImage: UIImage(named: "earth.background.jpeg")!)
        
        RegisterButton.layer.cornerRadius = RegisterButton.frame.size.width / 20
        RegisterButton.clipsToBounds = true
        
        RegisterButton.layer.borderWidth = 2
        RegisterButton.layer.borderColor = UIColor.black.cgColor
        
        NameTextField.layer.cornerRadius = NameTextField.frame.size.width / 20
        NameTextField.clipsToBounds = true
        
        NameTextField.layer.borderWidth = 2
        NameTextField.layer.borderColor = UIColor.black.cgColor
        
        loginTextField.layer.cornerRadius = loginTextField.frame.size.width / 20
        loginTextField.clipsToBounds = true
        
        loginTextField.layer.borderWidth = 2
        loginTextField.layer.borderColor = UIColor.black.cgColor
        
        passwordTextField.layer.cornerRadius = passwordTextField.frame.size.width / 20
        passwordTextField.clipsToBounds = true
        
        passwordTextField.layer.borderWidth = 2
        passwordTextField.layer.borderColor = UIColor.black.cgColor
        
        UploadPhotoButton.layer.cornerRadius = UploadPhotoButton.frame.size.width / 20
        UploadPhotoButton.clipsToBounds = true
        
        UploadPhotoButton.layer.borderWidth = 2
        UploadPhotoButton.layer.borderColor = UIColor.black.cgColor
        
        BackButton.layer.cornerRadius = BackButton.frame.size.width / 20
        BackButton.clipsToBounds = true
        
        BackButton.layer.borderWidth = 2
        BackButton.layer.borderColor = UIColor.black.cgColor
        
        //NameTextField.placeholder = "Введите имя"
        //loginTextField.placeholder = "Введите логин"
        //passwordTextField.placeholder = "Введите пароль"
        
        
        guard let urlString = UserDefaults.standard.value(forKey: "url") as? String,
              let url = URL(string: urlString) else {
                  return
              }
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: {data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                //self.Image.image = image
            }
        })
        
        
        task.resume()
        
        // Жест нажатия
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        // Присваиваем его UIScrollVIew
        scrollView.addGestureRecognizer(hideKeyboardGesture)
        
        token = Auth.auth().addStateDidChangeListener{[weak self] auth, user in
            guard user != nil else {return}
             DispatchQueue.main.async {
                 guard let vc = self?.storyboard?.instantiateViewController(identifier: "SplashScreenController") else {return}
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

    @IBAction func GotoLogScreen() {
        self.ReturnTologin()
    }
    
    @IBAction func didTapButton() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        
        guard let imageData = image.pngData() else {
            return
        }
        
        if self.loginTextField.text != "" {
            storage.child("images/\(self.loginTextField.text ?? "")").putData(imageData,
                                                                            metadata: nil,
                                                                            completion: { _, error in
                                                                                guard error == nil else {
                                                                                print("Failed to upload")
                                                                                    return
                                                                                }
                
                
                self.storage.child("images/\(self.loginTextField.text ?? "")").downloadURL(completion : { url, error in
                    guard let url = url, error == nil else {
                        return
                    }
                    
                    self.urlString = url.absoluteString
                    
                    DispatchQueue.main.async {
                        self.Image.image = image
                    }
                    
                    print("Download URL: \(self.urlString)")
                    UserDefaults.standard.set(self.urlString, forKey: "url")
                })
                
                
            })
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func register() {
        guard let email = loginTextField.text, loginTextField.hasText,
              let password = passwordTextField.text, passwordTextField.hasText
        else {
            SCLAlertView().showError("Данные не введены", subTitle: "данные не введены")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) {[weak self] authResult, error in
            
            if let error = error {
                SCLAlertView().showError("Ошибка FireBase", subTitle: error.localizedDescription)
                return
            }
            
            DispatchQueue.main.async {
                guard let vc = self?.storyboard?.instantiateViewController(identifier: "StartViewController") else {return}
                guard let window = self!.view.window else {return}
                window.rootViewController = vc
           }
            
            self!.write()
        
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


