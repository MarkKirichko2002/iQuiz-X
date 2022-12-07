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
    
    @IBOutlet weak var SettingsButton: UIBarButtonItem!
    
    var profileViewModel = ProfileViewModel()
    var disposeBag = DisposeBag()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.async {
            self.ProfileImage.sd_setImage(with: URL(string: UserDefaults.standard.object(forKey: "url") as? String ?? ""))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.LastQuizCategoryIcon.color = .white
        ProfileImage.color = .white
        profileViewModel.LoadUserInfo()
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
        }).disposed(by: disposeBag)
    }
}
