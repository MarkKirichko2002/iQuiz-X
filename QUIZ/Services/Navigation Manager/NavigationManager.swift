//
//  NavigationManager.swift
//  QUIZ
//
//  Created by Марк Киричко on 05.01.2023.
//

import Foundation
import UIKit

class NavigationManager {
    
    // View
    var view: UIView?
    var storyboard: UIStoryboard?
    var vc: UIViewController?
    var button: UIButton?
    
    private let animation = AnimationClass()
    private let player = SoundClass()
    
    // показать экран логина
    func ShowLoginScreen() {
        guard let vc = storyboard?.instantiateViewController(identifier: "LoginViewController") else {return}
        guard let window = self.view?.window else {return}
        window.rootViewController = vc
    }
    
    @objc func GoToQuizApp() {
        
        if let button = self.button {
            self.player.PlaySound(resource: "future click sound.wav")
            self.animation.springButton(button: button)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "QuizTabBarController") as? UIViewController else {return}
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .flipHorizontal
            self.vc?.present(controller, animated: true, completion: nil)
        }
    }
}
