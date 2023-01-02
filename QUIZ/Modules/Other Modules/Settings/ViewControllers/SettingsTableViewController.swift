//
//  SettingsTableViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 03.04.2022.
//

import UIKit
import SCLAlertView
import Firebase

final class SettingsTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CustomViewCellDelegate {
    
    private var urlString = ""
    private let auth = FirebaseManager()
    private let db = Firestore.firestore()
    private let storage = Storage.storage().reference()
    private var saved = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.SetUpCells()
    }
    
    private func didTapButton() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    private func SetUpCells() {
        // биометрия
        self.tableView.register(UINib(nibName: BiometricTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: BiometricTableViewCell.identifier)
        // голосовой пароль
        self.tableView.register(UINib(nibName: VoicePasswordTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: VoicePasswordTableViewCell.identifier)
        // редактировать профиль
        self.tableView.register(UINib(nibName: EditProfileTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: EditProfileTableViewCell.identifier)
        // статистика
        self.tableView.register(UINib(nibName: StatisticTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: StatisticTableViewCell.identifier)
        // фото
        self.tableView.register(UINib(nibName: PhotoTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: PhotoTableViewCell.identifier)
        // распознование жестов
        self.tableView.register(UINib(nibName: VideoRecordTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: VideoRecordTableViewCell.identifier)
        // распознование речи
        self.tableView.register(UINib(nibName: MicrophoneTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: MicrophoneTableViewCell.identifier)
        // подсказки
        self.tableView.register(UINib(nibName: HintsTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: HintsTableViewCell.identifier)
        // синтезатор речи
        self.tableView.register(UINib(nibName: SpeachTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: SpeachTableViewCell.identifier)
        // музыка
        self.tableView.register(UINib(nibName: MusicTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: MusicTableViewCell.identifier)
        // таймер
        self.tableView.register(UINib(nibName: TimerTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: TimerTableViewCell.identifier)
        // попытки
        self.tableView.register(UINib(nibName: AttemptsTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: AttemptsTableViewCell.identifier)
        // удалить аккаунт
        self.tableView.register(UINib(nibName: DeleteTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: DeleteTableViewCell.identifier)
        // выйти из аккаунта
        self.tableView.register(UINib(nibName: ExitTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ExitTableViewCell.identifier)
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
            if let cell = tableView.cellForRow(at: indexPath) as? StatisticTableViewCell {
                cell.didSelect(indexPath: indexPath)
            }
            
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
    
    func didElementClick() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.performSegue(withIdentifier: "ShowStatistic", sender: nil)
        }
    }
    
    func alert() {
        let defaults = UserDefaults.standard
        var name = defaults.object(forKey:"name") as? String
        var email = defaults.object(forKey:"email") as? String
        var password = defaults.object(forKey:"password") as? String
        var credential: AuthCredential
        
        print("нет email")
        
        let alert = UIAlertController(title: "Изменение данных для профиля", message: "Вы точно хотите перезаписать данные?", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.text = ""
            textField.placeholder = "Введите имя"
            
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
            
            self.tableView.reloadData()
            
            name = textField?.text
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
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func alert2() {
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
        
        present(alert, animated: true, completion: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        switch indexPath.row {
            
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "BiometricTableViewCell") as? BiometricTableViewCell
            else { return UITableViewCell() }
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "VoicePasswordTableViewCell") as? VoicePasswordTableViewCell
            else { return UITableViewCell() }
            
            return cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "EditProfileTableViewCell") as? EditProfileTableViewCell
            else { return UITableViewCell() }
            
            return cell
            
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "StatisticTableViewCell") as? StatisticTableViewCell
            else { return UITableViewCell() }
            cell.delegate = self
            
            return cell
            
        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoTableViewCell") as? PhotoTableViewCell
            else { return UITableViewCell() }
            
            
            if self.saved == true {
                print("Сохранено")
                self.auth.load(profileimage: cell.SettingsImage)
            }
            
            return cell
            
            
        case 5:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "VideoRecordTableViewCell") as? VideoRecordTableViewCell
            else { return UITableViewCell() }
            
            return cell
            
        case 6:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MicrophoneTableViewCell") as? MicrophoneTableViewCell
            else { return UITableViewCell() }
            
            return cell
            
        case 7:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HintsTableViewCell") as? HintsTableViewCell
            else { return UITableViewCell() }
            
            return cell
            
        case 8:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SpeachTableViewCell") as? SpeachTableViewCell
            else { return UITableViewCell() }
            
            return cell
            
        case 9:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MusicTableViewCell") as? MusicTableViewCell
            else { return UITableViewCell() }
            
            return cell
            
        case 10:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TimerTableViewCell") as? TimerTableViewCell
            else { return UITableViewCell() }
            
            return cell
            
        case 11:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AttemptsTableViewCell") as? AttemptsTableViewCell
            else { return UITableViewCell() }
            
            return cell
            
        case 12:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DeleteTableViewCell") as? DeleteTableViewCell
            else { return UITableViewCell() }
            
            return cell
            
        case 13:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExitTableViewCell") as? ExitTableViewCell
            else { return UITableViewCell() }
            
            return cell
            
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "StatisticTableViewCell") as? StatisticTableViewCell
            else { return UITableViewCell() }
            
            return cell
        }
    }
}
