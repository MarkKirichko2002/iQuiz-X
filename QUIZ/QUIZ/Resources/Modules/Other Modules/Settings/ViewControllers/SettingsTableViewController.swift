//
//  SettingsTableViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 03.04.2022.
//

import UIKit
import SCLAlertView
import Firebase

final class SettingsTableViewController: UITableViewController, CustomViewCellDelegate {
    
    private var urlString = ""
    private let firebaseManager = FirebaseManager()
    private let db = Firestore.firestore()
    private let storage = Storage.storage().reference()
    private var saved = false
    private let settingsManager = SettingsManager()
    private let navigationManager = NavigationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // настройки
        settingsManager.view = self.view
        settingsManager.vc = self
        // навигация
        navigationManager.view = self.view
        navigationManager.storyboard = self.storyboard
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
        self.tableView.register(UINib(nibName: VoiceCommandSettingTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: VoiceCommandSettingTableViewCell.identifier)
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            
        case 0:
            return 2
            
        case 1:
            return 3
            
        case 2:
            return 8
            
        case 3:
            return 2
            
        default:
            return 0
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.section {
            
        case 0:
            
            if indexPath.row == 0 {
                print("biometric")
            } else if indexPath.row == 1 {
                print("voice password")
                settingsManager.ChangeVoicePassword()
            }
            
        case 1:
            
            if indexPath.row == 0 {
                print("photo")
                self.didTapButton()
            } else if indexPath.row == 1 {
                ChangeProfileData()
            } else if indexPath.row == 2 {
                print("statistic")
                if let cell = tableView.cellForRow(at: indexPath) as? StatisticTableViewCell {
                       cell.didSelect(indexPath: indexPath)
                }
            }
            
        case 2:
            
            if indexPath.row == 0 {
                print("voice command")
                let vc = VoiceCommandsTableViewController()
                self.present(vc, animated: true)
            }else if indexPath.row == 1 {
                print("audio recording")
            } else if indexPath.row == 2 {
                print("video recording")
            } else if indexPath.row == 3 {
                print("hints")
            } else if indexPath.row == 4 {
                print("speach")
            } else if indexPath.row == 5 {
                print("music")
            } else if indexPath.row == 6 {
                print("timer")
            } else if indexPath.row == 7 {
                print("attempts")
            }
            
        case 3:
            
            if indexPath.row == 0 {
                firebaseManager.DeleteAccount()
                firebaseManager.SignOutAction()
                navigationManager.ShowLoginScreen()
            } else if indexPath.row == 1 {
                firebaseManager.SignOutAction()
                navigationManager.ShowLoginScreen()
            }
            
        default:
            break
            
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
       if let headerView = view as? UITableViewHeaderFooterView {
           headerView.contentView.backgroundColor = .black
           headerView.textLabel?.textColor = .white
       }
   }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
       let lbl = UILabel(frame: CGRect(x: 15, y: 0, width: view.frame.width - 15, height: 40))
       lbl.font = UIFont.systemFont(ofSize: 25)
        
        switch section {
            
        case 0:
            lbl.text = "Авторизация"
            
        case 1:
            lbl.text = "Профиль"
            
        case 2:
            lbl.text = "Викторина"
            
        case 3:
            lbl.text = "Аккаунт"
            
        default:
            lbl.text = ""
            
        }
       view.addSubview(lbl)
       return view
   }
   
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       return 40
   }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
            
        case 0:
            
            if indexPath.row == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "BiometricTableViewCell") as? BiometricTableViewCell
                else { return UITableViewCell() }
                return cell
            } else if indexPath.row == 1 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "VoicePasswordTableViewCell") as? VoicePasswordTableViewCell
                else { return UITableViewCell() }
                return cell
            }
            
        case 1:
            
            if indexPath.row == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoTableViewCell") as? PhotoTableViewCell
                else { return UITableViewCell() }
                
                if self.saved == true {
                    print("Сохранено")
                    
                }
                
                return cell
                
            } else if indexPath.row == 1 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "EditProfileTableViewCell") as? EditProfileTableViewCell
                else { return UITableViewCell() }
                return cell
                
            } else if indexPath.row == 2 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "StatisticTableViewCell") as? StatisticTableViewCell
                else { return UITableViewCell() }
                cell.delegate = self
                return cell
            }
            
        case 2:
            
            if indexPath.row == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "VoiceCommandSettingTableViewCell") as? VoiceCommandSettingTableViewCell
                else { return UITableViewCell() }
                
                return cell
            } else if indexPath.row == 1 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "MicrophoneTableViewCell") as? MicrophoneTableViewCell
                else { return UITableViewCell() }
                
                return cell
            } else if indexPath.row == 2 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "VideoRecordTableViewCell") as? VideoRecordTableViewCell
                else { return UITableViewCell() }
                
                return cell
            } else if indexPath.row == 3 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "HintsTableViewCell") as? HintsTableViewCell
                else { return UITableViewCell() }
                
                return cell
            } else if indexPath.row == 4 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "SpeachTableViewCell") as? SpeachTableViewCell
                else { return UITableViewCell() }
                
                return cell
            } else if indexPath.row == 5 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "MusicTableViewCell") as? MusicTableViewCell
                else { return UITableViewCell() }

                return cell
            } else if indexPath.row == 6 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "TimerTableViewCell") as? TimerTableViewCell
                else { return UITableViewCell() }

                return cell
            } else if indexPath.row == 7 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "AttemptsTableViewCell") as? AttemptsTableViewCell
                else { return UITableViewCell() }

                return cell
            }
            
        case 3:
            if indexPath.row == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "DeleteTableViewCell") as? DeleteTableViewCell
                else { return UITableViewCell() }

                return cell
            } else if indexPath.row == 1 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExitTableViewCell") as? ExitTableViewCell
                else { return UITableViewCell() }

                return cell
            }
            
        default:
            return UITableViewCell()
            
        }
        return UITableViewCell()
    }
    
    func didElementClick() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.performSegue(withIdentifier: "ShowStatistic", sender: nil)
        }
    }
    
    func ChangeProfileData() {
        let defaults = UserDefaults.standard
        let email = defaults.object(forKey:"email") as? String ?? ""
        
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
            
            guard let name = textField?.text else {return}
            guard let password = textField2?.text else {return}
            
            if name != "" && email != "" && password != ""  {
                self.db.collection("users").document((Auth.auth().currentUser?.email)!).updateData([
                    "name": name,
                    "email": email,
                    "password": password
                ]) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        SCLAlertView().showSuccess("Успех!", subTitle: "данные изменены!")
                        defaults.set(name, forKey: "name")
                        defaults.set(email, forKey: "email")
                        defaults.set(password, forKey: "password")
                        
                        Auth.auth().currentUser?.updatePassword(to: password) { (error) in
                        }
                        
                        print(name)
                        print(email)
                        print(password)
                    }
                }
            } else {
                SCLAlertView().showError("Данные не введены!", subTitle: "введите данные")
            }
            
        }))
        
        present(alert, animated: true, completion: nil)
        
    }
}

extension SettingsTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
                self.firebaseManager.UpdateProfilePhoto(string: self.urlString)
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
}
