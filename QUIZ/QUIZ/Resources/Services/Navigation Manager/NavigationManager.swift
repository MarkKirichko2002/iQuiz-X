//
//  NavigationManager.swift
//  QUIZ
//
//  Created by Марк Киричко on 05.01.2023.
//

import UIKit

class NavigationManager: NavigationManagerProtocol {
    
    // View
    var view: UIView?
    var storyboard: UIStoryboard?
    var vc: UIViewController?
    var button: UIButton?
    var button2: UIButton?
    
    private let animation = AnimationClass()
    private let player = SoundClass()
    var sound = ""
    var category: QuizCategoryModel?
    
    // показать экран логина
    func ShowLoginScreen() {
        let storyboard = UIStoryboard(name: "LoginViewController", bundle: nil)
        guard let vc = storyboard.instantiateViewController(identifier: "LoginViewController") as? LoginViewController else {return}
        guard let window = self.view?.window else {return}
        window.rootViewController = vc
    }
    
    @objc func GoToQuizApp() {
        
        if let button = self.button {
            self.player.PlaySound(resource: "future click sound.wav")
            self.animation.SpringAnimation(view: button)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let controller = storyboard.instantiateViewController(withIdentifier: "QuizTabBarController") as? QuizTabBarController else {return}
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .flipHorizontal
            self.vc?.present(controller, animated: true, completion: nil)
        }
    }
    
    @objc func GoToDailyQuiz() {
        
        if let category = self.category {
            
            if let button2 = self.button2 {
                self.player.PlaySound(resource: category.sound)
                self.animation.SpringAnimation(view: button2)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                let storyboard = UIStoryboard(name: "DailyQuizViewController", bundle: nil)
                guard let vc = storyboard.instantiateViewController(identifier: "DailyQuizViewController") as? DailyQuizViewController else {return}
                vc.category = category
                guard let window = self.view?.window else {return}
                window.rootViewController = vc
            }
        }
    }
}
