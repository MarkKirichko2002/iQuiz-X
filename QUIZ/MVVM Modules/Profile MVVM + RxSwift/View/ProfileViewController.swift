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
    @IBOutlet weak var BestScore: UILabel!
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
        ProfileImage.color = .white
        profileViewModel.LoadUserInfo()
        profileViewModel.user.subscribe(onNext: { user in
            guard let background = UIImage(named: user.background) else {return}
            self.ProfileImage.sd_setImage(with: URL(string: user.image))
            self.ProfileImage.sound = user.categorysound
            self.NameLabel.text = user.name
            self.EmailLabel.text = user.email
            self.BestScore.text = "Лучший счет: \(user.score)/100 (\(user.category))"
            self.view.backgroundColor = UIColor(patternImage: background)
        }).disposed(by: disposeBag)
    }
    
    private func showLoginVC() {
        guard let vc = storyboard?.instantiateViewController(identifier: "LoginViewController") else {return}
        guard let window = self.view.window else {return}
        window.rootViewController = vc
    }

}
