//
//  SettingsTableViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 03.04.2022.
//

import UIKit
import SCLAlertView
import Firebase

final class SettingsTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var urlString = ""
    
    var auth = FBAuth()
    
    let db = Firestore.firestore()
    
    private let storage = Storage.storage().reference()
    
    var saved = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func didTapButton() {
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
                
                self.saved = true
                var save = UserDefaults.standard.setValue(self.saved, forKey: "save")
                print(self.saved)
                
                self.urlString = url.absoluteString
                self.auth.write(string: self.urlString)
                print("loading now")
                self.tableView.reloadData()
                
                print("Download URL: \(self.urlString)")
                UserDefaults.standard.set(self.urlString, forKey: "url")
            })
            
            
        })
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 14
    }
    
    
    private func showLoginVC() {
        guard let vc = storyboard?.instantiateViewController(identifier: "LoginViewController") else {return}
        guard let window = self.view.window else {return}
        window.rootViewController = vc
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch(indexPath.row) {
            
        case 0: print("biometric")
            
        case 1: print("voice password")
            alert2()
            
        case 2: alert()
            
        case 3: print("statistic")
            
        case 4: print("photo")
            self.didTapButton()
            
        case 5: print("video recording")
            
        case 6: print("audio recording")
            
        case 7: print("hints")
            
        case 8: print("speach")
            
        case 9: print("music")
            
        case 10: print("timer")
            
        case 11: print("attempts")
            
        case 12: auth.delete()
            auth.SignOutAction()
            self.showLoginVC()
            
        case 13: auth.SignOutAction()
            self.showLoginVC()
            
        default: break
            
        }
    }
    
    
    
    func alert() {
        let defaults = UserDefaults.standard
        var name = defaults.object(forKey:"name") as? String
        var email = defaults.object(forKey:"email") as? String
        var password = defaults.object(forKey:"password") as? String
        var credential: AuthCredential
        
        print("нет email")
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Изменение данных для профиля", message: "Вы точно хотите перезаписать данные?", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.text = ""
            textField.placeholder = "Введите имя"
            
//            alert.addTextField { (textField) in
//                textField.text = ""
//                textField.placeholder = "Введите email"
//            }
            
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
            //let textField3 = alert?.textFields![2]
            
            self.tableView.reloadData()
            
            name = textField?.text
            //email = textField2?.text
            password = textField2?.text
            
            if name != "" && email != "" && password != ""  {
                self.db.collection("users").document((Auth.auth().currentUser?.email)!).updateData([
                    "name": name,
                ]) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        SCLAlertView().showSuccess("Успех!", subTitle: "данные изменены!")
                        defaults.set(name, forKey: "name")
                        defaults.set(email, forKey: "email")
                        defaults.set(password, forKey: "password")
                        
                        Auth.auth().currentUser?.updatePassword(to: password!) { (error) in
                        }
                        
                        print(name ?? "")
                        print(email ?? "")
                        print(password ?? "")
                    }
                }
            } else {
                SCLAlertView().showError("Данные не введены!", subTitle: "введите данные")
            }
            
            
        }))
        
        // 4. Present the alert.
        present(alert, animated: true, completion: nil)
        
    }
    
    func alert2() {
        let defaults = UserDefaults.standard
        var voicepassword = defaults.object(forKey:"voicepassword") as? String
        
        print("нет голосового пароля")
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Изменение данных для голосового пароля", message: "Вы точно хотите перезаписать данные?", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.text = ""
            textField.placeholder = "Введите пароль"
        }
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        
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
        
        // 4. Present the alert.
        present(alert, animated: true, completion: nil)
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0  {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "BiometricTableViewCell") as? BiometricTableViewCell
            else { return UITableViewCell() }
            return cell
            
        } else if indexPath.row == 1  {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "VoicePasswordTableViewCell") as? VoicePasswordTableViewCell
            else { return UITableViewCell() }
            
            return cell
            
        } else if indexPath.row == 2  {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "EditProfileTableViewCell") as? EditProfileTableViewCell
            else { return UITableViewCell() }
            
            return cell
            
        } else if indexPath.row == 3  {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "StatisticTableViewCell") as? StatisticTableViewCell
            else { return UITableViewCell() }
            
            
            return cell
            
        } else if indexPath.row == 4  {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoTableViewCell") as? PhotoTableViewCell
            else { return UITableViewCell() }
            
            
            if self.saved == true {
                print("Сохранено")
                self.auth.load(profileimage: cell.SettingsImage)
            }
            
            return cell
            
        } else if indexPath.row == 5  {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "VideoRecordTableViewCell") as? VideoRecordTableViewCell
            else { return UITableViewCell() }
            
            return cell
            
        }  else if indexPath.row == 6  {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MicrophoneTableViewCell") as? MicrophoneTableViewCell
            else { return UITableViewCell() }
            
            return cell
            
        }   else if indexPath.row == 7  {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HintsTableViewCell") as? HintsTableViewCell
            else { return UITableViewCell() }
            
            return cell
            
        }   else if indexPath.row == 8  {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SpeachTableViewCell") as? SpeachTableViewCell
            else { return UITableViewCell() }
            
            return cell
            
        }   else if indexPath.row == 9  {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MusicTableViewCell") as? MusicTableViewCell
            else { return UITableViewCell() }
            
            return cell
            
        } else if indexPath.row == 10  {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TimerTableViewCell") as? TimerTableViewCell
            else { return UITableViewCell() }
            
            return cell
            
        } else if indexPath.row == 11  {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AttemptsTableViewCell") as? AttemptsTableViewCell
            else { return UITableViewCell() }
            
            return cell
            
        } else if indexPath.row == 12  {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DeleteTableViewCell") as? DeleteTableViewCell
            else { return UITableViewCell() }
            
            return cell
            
        } else if indexPath.row == 13  {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExitTableViewCell") as? ExitTableViewCell
            else { return UITableViewCell() }
            
            return cell
            
        } else {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "StatisticTableViewCell") as? StatisticTableViewCell
            else { return UITableViewCell() }
            
            //cell.configure(groupItems[indexPath.row])
            return cell
            
        }
    }
    
    
}

