//
//  SplashScreenController.swift
//  QUIZ
//
//  Created by Марк Киричко on 01.06.2022.
//

import Foundation
import UIKit

class SplashScreenController: UIViewController {
    
    @IBOutlet weak var Image: RoundedImageView!
    @IBOutlet weak var Text: UILabel!
    
    var animation = AnimationClass()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Image.borderWidth = 5
        Image.color = .white
        animation.springImage(image: Image)
        Text.textColor = UIColor.white
        view.backgroundColor = UIColor(patternImage: UIImage(named: "newyear.background.jpeg")!)
        SplashScreen()
    }
   
    func SplashScreen() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.Text.text = "Викторина 2023"
            self.animation.springLabel(label: self.Text)
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