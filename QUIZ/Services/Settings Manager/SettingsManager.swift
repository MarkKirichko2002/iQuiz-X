//
//  SettingsManager.swift
//  QUIZ
//
//  Created by Марк Киричко on 05.01.2023.
//

import Foundation
import UIKit
import SCLAlertView

class SettingsManager: SettingsManagerProtocol {
    
    private let name = UserDefaults.standard.object(forKey:"name") as? String ?? "нет имени"
    private let email = UserDefaults.standard.object(forKey:"email") as? String ?? "нет email"
    private let password = UserDefaults.standard.object(forKey:"password") as? String ?? "нет пароля"
    private var profileInfoViewModel: ProfileInfoViewModel?
    var voicepassword = UserDefaults.standard.object(forKey: "voicepassword") as? String ?? "123"
    let profileImage = UserDefaults.standard.value(forKey: "url") as? String ?? "https://cdn-icons-png.flaticon.com/512/3637/3637624.png"
    
    // View
    var view: UIView?
    var vc: UIViewController?
    
    func loadProfileInfo(completion: @escaping(ProfileInfoViewModel)->()) {
        profileInfoViewModel = ProfileInfoViewModel(name: name, email: email, password: password)
        guard let profileInfoViewModel = self.profileInfoViewModel else {return}
        completion(profileInfoViewModel)
    }
    
    func ResetSettings() {
        UserDefaults.standard.set("", forKey: "email")
        UserDefaults.standard.set("", forKey: "password")
        UserDefaults.standard.set(false, forKey: "off")
        UserDefaults.standard.set(false, forKey: "offaudio")
        UserDefaults.standard.set(false, forKey: "offhints")
        UserDefaults.standard.set(false, forKey: "offspeach")
        UserDefaults.standard.set(false, forKey: "offmusic")
        UserDefaults.standard.set(false, forKey: "offtimer")
        UserDefaults.standard.set(false, forKey: "offattempts")
        UserDefaults.standard.set(false, forKey: "onstatus")
        UserDefaults.standard.set(false, forKey: "onstatusaudio")
        UserDefaults.standard.set(false, forKey: "onstatushints")
        UserDefaults.standard.set(false, forKey: "onstatusspeach")
        UserDefaults.standard.set(false, forKey: "onstatusmusic")
    }
    
    func ChangeVoicePassword() {
        
        let defaults = UserDefaults.standard
        var voicepassword = defaults.object(forKey:"voicepassword") as? String
        
        print("нет голосового пароля")
        
        let alert = UIAlertController(title: "Изменение данных для голосового пароля", message: "Вы точно хотите перезаписать данные?", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.text = ""
            textField.placeholder = "Введите пароль"
        }
        
        alert.addAction(UIAlertAction(title: "нет", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        alert.addAction(UIAlertAction(title: "да", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            
            voicepassword = textField?.text
            
            if voicepassword == "" || voicepassword == nil {
                SCLAlertView().showError("Данные не введены!", subTitle: "введите пароль")
                print(voicepassword ?? "")
            } else {
                defaults.set(voicepassword, forKey: "voicepassword")
            }
        }))
        self.vc?.present(alert, animated: true, completion: nil)
    }
}
