//
//  QuizSplashScreenController.swift
//  QUIZ
//
//  Created by Марк Киричко on 01.06.2022.
//

import UIKit

final class QuizSplashScreenController: UIViewController {
    
    private let animation = AnimationClass()
    
    private let QuizIcon: RoundedImageView = {
        let icon = RoundedImageView()
        icon.image = UIImage(named: "astronomy")
        icon.borderWidth = 5
        icon.color = UIColor.white
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    private let QuizTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = .systemFont(ofSize: 33, weight: .black)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let AnniversaryLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = .systemFont(ofSize: 30, weight: .black)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews(QuizIcon, QuizTitleLabel, AnniversaryLabel)
        view.backgroundColor = UIColor(patternImage: UIImage(named: "earth.background.jpeg")!)
        SetUpConstraints()
        ShowSplashScreen()
    }
    
    private func SetUpConstraints() {
        NSLayoutConstraint.activate([
            
            QuizIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            QuizIcon.widthAnchor.constraint(equalToConstant: 200),
            QuizIcon.heightAnchor.constraint(equalToConstant: 200),
            
            QuizTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            QuizTitleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            QuizTitleLabel.heightAnchor.constraint(equalToConstant: 30),
            QuizTitleLabel.topAnchor.constraint(equalTo: QuizIcon.bottomAnchor, constant: 40),
            
            AnniversaryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            AnniversaryLabel.heightAnchor.constraint(equalToConstant: 30),
            AnniversaryLabel.topAnchor.constraint(equalTo: QuizTitleLabel.bottomAnchor, constant: 40),
            
        ])
    }
   
    private func ShowSplashScreen() {
        
        animation.SpringAnimation(view: QuizIcon)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.QuizTitleLabel.text = "iQuiz X"
            self.animation.SpringAnimation(view: self.QuizTitleLabel)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.AnniversaryLabel.text = "1 год 🎉!!!"
            self.animation.SpringAnimation(view: self.AnniversaryLabel)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            if let controller = self.storyboard?.instantiateViewController(withIdentifier: "StartViewController") as? StartViewController {
                controller.modalTransitionStyle = .crossDissolve
                controller.modalPresentationStyle = .currentContext
                self.present(controller, animated: false, completion: nil)
            }
        }
    }
}
