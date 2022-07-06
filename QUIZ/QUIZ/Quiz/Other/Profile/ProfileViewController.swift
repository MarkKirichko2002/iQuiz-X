//
//  ProfileViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 16.02.2022.
//

import UIKit
import Firebase
import FirebaseStorage
import SDWebImage

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var ProfileImage: UIImageView!
    @IBOutlet weak var EmailLabel: UILabel!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var BestScore: UILabel!
    @IBOutlet weak var SettingsButton: UIBarButtonItem!
    
    var defaults = UserDefaults.standard
    
    var urlString = ""
    
    private let storage = Storage.storage().reference()
    
    let db = Firestore.firestore()
    
    var auth = FBAuth()
    
    var player = SoundClass()
    
    override func viewDidAppear(_ animated: Bool) {
        
        var save = UserDefaults.standard.object(forKey: "save") as? Bool
        
        if save == true {
            auth.load(profileimage: self.ProfileImage)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.auth.LoadUserInfo(username: self.NameLabel, useremail: self.EmailLabel, userimage: self.ProfileImage, highscore: self.BestScore, view: self.view)
        }
        
        Auth.auth().addStateDidChangeListener { auth, user in
            guard let user = user else {return}
            if(user != nil) {
                self.EmailLabel.text = user.email
                print(user.email)
            } else {
                
            }
        }
        
    }
    
    private func showLoginVC() {
        guard let vc = storyboard?.instantiateViewController(identifier: "LoginViewController") else {return}
        guard let window = self.view.window else {return}
        window.rootViewController = vc
    }

}
