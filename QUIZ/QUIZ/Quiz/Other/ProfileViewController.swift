//
//  ProfileViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 16.02.2022.
//

import UIKit
import Firebase
import FirebaseStorage

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var ProfileImage: UIImageView!
    @IBOutlet weak var EmailLabel: UILabel!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var SignOutButton: UIButton!
    @IBOutlet weak var StatisticButton: UIButton!
    @IBOutlet weak var BestScore: UILabel!
    @IBOutlet weak var UploadPhotoButton: UIButton!
    
    var images: [Player] = []
    
    var urlString = ""
    
    private let storage = Storage.storage().reference()
    
    let db = Firestore.firestore()
    
    
    func write() {
        db.collection("users").document(Auth.auth().currentUser?.email ?? "").updateData([
            "image": self.urlString
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
              print("photo saved")
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        //ProfileImage.flash()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ProfileImage.flash()
        
        //StatisticButton.flash()
        //ProfileImage.flash()
        
        
        StatisticButton.layer.cornerRadius = SignOutButton.frame.size.width / 5
        StatisticButton.clipsToBounds = true
        
        StatisticButton.layer.borderWidth = 2
        StatisticButton.layer.borderColor = UIColor.black.cgColor
        
        SignOutButton.layer.cornerRadius = SignOutButton.frame.size.width / 5
        SignOutButton.clipsToBounds = true
        
        SignOutButton.layer.borderWidth = 2
        SignOutButton.layer.borderColor = UIColor.black.cgColor
        
        UploadPhotoButton.layer.cornerRadius = UploadPhotoButton.frame.size.width / 10
        UploadPhotoButton.clipsToBounds = true
        
        UploadPhotoButton.layer.borderWidth = 2
        UploadPhotoButton.layer.borderColor = UIColor.black.cgColor
        
        loadScore()
        
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
                //self.ProfileImage.image = image

            }
        })
        
        task.resume()
        
        //ProfileImage.image = UIImage(named: "IQ.jpeg")
        
        Auth.auth().addStateDidChangeListener { auth, user in
            guard let user = user else {return}
            if(user != nil) {
                self.EmailLabel.text = user.email
                print(user.email)
            } else {
                
            }
        }

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
        
        
        storage.child("images/\(Auth.auth().currentUser?.email ?? "")").putData(imageData,
                                                                        metadata: nil,
                                                                        completion: { _, error in
                                                                            guard error == nil else {
                                                                            print("Failed to upload")
                                                                                return
                                                                            }
            
            
            self.storage.child("images/\(Auth.auth().currentUser?.email ?? "")").downloadURL(completion : { url, error in
                guard let url = url, error == nil else {
                    return
                }
                
                
                
                self.urlString = url.absoluteString
                
                DispatchQueue.main.async {
                    self.ProfileImage.image = image
                }
                
                self.write()
                
                print("Download URL: \(self.urlString)")
                UserDefaults.standard.set(self.urlString, forKey: "url")
            })
            
            
        })
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func loadScore() {
        let docRef = db.collection("users").document((Auth.auth().currentUser?.email) ?? "")
    
        docRef.getDocument { document, error in
            if let error = error as NSError? {
                print("Error getting document: \(error.localizedDescription)")
            }
            else {
                if let document = document {
                    let data = document.data()
                    let name = data?["name"] as? String ?? ""
                    let bestscore = data?["bestscore"] as? Int ?? 0
                    let email = data?["email"] as? String
                    let image = data?["image"] as? String
                    self.NameLabel.text = name
                    self.NameLabel.font = UIFont.boldSystemFont(ofSize: 20)
                    self.EmailLabel.text = email
                    self.EmailLabel.font = UIFont.boldSystemFont(ofSize: 20)
                    self.BestScore.font = UIFont.boldSystemFont(ofSize: 20)
                    self.BestScore.text = ("Лучший счет: \(bestscore) баллов")
                    
                   DispatchQueue.main.async {
                    let imageURL = URL(string: image ?? "IQ.jpeg")
                    self.ProfileImage.sd_setImage(with: imageURL)
                    print("Фотка \(image)")
                   }
                    if let category = document["lastquiz"] as? [String: Any] {
                        let background = category["background"] as? String
                        let image = category["image"] as? String
                        let bestscore = category["bestscore"] as? Int ?? 228
                        let category = category["category"] as? String ?? "lol"
                        self.BestScore.text = "Лучший счет: \(bestscore) баллов (\(category))"
                            print(category)
                        self.BestScore.textColor = UIColor.white
                        self.NameLabel.textColor = UIColor.white
                        self.EmailLabel.textColor = UIColor.white
                        self.view.backgroundColor = UIColor(patternImage: UIImage(named: background!)!)
                        self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.darkGray]
                        
                        if bestscore == 100 {
                            self.ProfileImage.flash()
                        }
                    }
                    
//                    if let category = document["image"] as? [String: Any] {
//                        let photo = category["photo"] as? String
//                        let imageURL = URL(string: photo ?? "")
//                        self.ProfileImage.sd_setImage(with: imageURL)
//                        print("Фотка\(photo)")
//
//                    }
                }
            }
        }
    }
    
    
    private func showLoginVC() {
        guard let vc = storyboard?.instantiateViewController(identifier: "LoginViewController") else {return}
        guard let window = self.view.window else {return}
        window.rootViewController = vc
    }
    
    
    @IBAction func SignOutAction(_ sender: Any) {
        
        try?Auth.auth().signOut()
        showLoginVC()
    }
    
}
