//
//  ProfileViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 16.02.2022.
//

import UIKit
import SDWebImage
import RxSwift
import RxCocoa

class ProfileViewController: UIViewController {
    @IBOutlet weak var ProfileImage: RoundedImageView!
    @IBOutlet weak var EmailLabel: UILabel!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var LastQuizCategoryIcon: RoundedImageView!
    @IBOutlet weak var LastQuizCategoryName: UILabel!
    @IBOutlet weak var BestScore: UILabel!
    @IBOutlet weak var CorrectAnswersCountLabel: UILabel!
    @IBOutlet weak var SettingsButton: UIButton!
    
    private var animation = AnimationClass()
    private var profileViewModel = ProfileViewModel()
    private var disposeBag = DisposeBag()
    private var player = SoundClass()
    
    @IBAction func ShowSettings() {
        animation.springButton(button: SettingsButton)
        player.PlaySound(resource: "settings.mp3")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.performSegue(withIdentifier: "showSettings", sender: nil)
        }
    }
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.async {
            self.ProfileImage.sd_setImage(with: URL(string: UserDefaults.standard.object(forKey: "url") as? String ?? ""))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.profileViewModel.view = self.view
        self.HideUI()
        profileViewModel.ShowLoading()
        self.DisplayProfileData()
    }
    
    func HideUI() {
        ProfileImage.isHidden = true
        NameLabel.isHidden = true
        EmailLabel.isHidden = true
        DateLabel.isHidden = true
        LastQuizCategoryIcon.isHidden = true
        LastQuizCategoryName.isHidden = true
        BestScore.isHidden = true
        CorrectAnswersCountLabel.isHidden = true
    }
    
    func ShowUI() {
        ProfileImage.isHidden = false
        NameLabel.isHidden = false
        EmailLabel.isHidden = false
        DateLabel.isHidden = false
        LastQuizCategoryIcon.isHidden = false
        LastQuizCategoryName.isHidden = false
        BestScore.isHidden = false
        CorrectAnswersCountLabel.isHidden = false
    }
    
    private func DisplayProfileData() {
        self.LastQuizCategoryIcon.color = .white
        ProfileImage.color = .white
        profileViewModel.user.subscribe(onNext: { user in
            guard let background = UIImage(named: user.background) else {return}
            // информация о профиле
            self.ProfileImage.sd_setImage(with: URL(string: user.image))
            self.ProfileImage.sound = "IQ.mp3"
            self.NameLabel.text = user.name
            self.EmailLabel.text = user.email
            self.DateLabel.text = user.categoryDate
            // информация о последней викторине
            self.LastQuizCategoryIcon.image = UIImage(named: user.icon)
            self.LastQuizCategoryIcon.sound = user.categorysound
            self.LastQuizCategoryName.text = user.category
            self.BestScore.text = "лучший счет: \(user.score)/100"
            self.CorrectAnswersCountLabel.text = "ответы: \(user.correctAnswers)/20"
            self.view.backgroundColor = UIColor(patternImage: background)
            if user.background != "" {
                self.SettingsButton.setImage(UIImage(named: "settings white"), for: .normal)
            } else {
                self.SettingsButton.setImage(UIImage(named: "settings"), for: .normal)
            }
            self.ShowUI()
        }).disposed(by: disposeBag)
    }
}