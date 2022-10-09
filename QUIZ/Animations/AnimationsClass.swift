//
//  AnimationsClass.swift
//  QUIZ
//
//  Created by Марк Киричко on 16.02.2022.
//

import Foundation
import UIKit

class AnimationClass {
        
    let rotationAnimation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
    
    func springLabel(label: UILabel) {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0
        animation.toValue = 1
        animation.stiffness = 300
        animation.mass = 1
        animation.duration = 0.5
        animation.beginTime = CACurrentMediaTime() + 0
        label.layer.add(animation, forKey: nil)
    }

    func springImage(image: UIImageView) {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0
        animation.toValue = 1
        animation.stiffness = 300
        animation.mass = 1
        animation.duration = 0.5
        animation.beginTime = CACurrentMediaTime() + 0
        image.layer.add(animation, forKey: nil)
    }
    
    func springButton(button: UIButton) {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0
        animation.toValue = 1
        animation.stiffness = 300
        animation.mass = 1
        animation.duration = 0.5
        animation.beginTime = CACurrentMediaTime() + 0
        button.layer.add(animation, forKey: nil)
    }
    
    func StartRotateImage(image: UIImageView) {
        rotationAnimation.toValue = NSNumber(value: .pi * 2.0)
        rotationAnimation.duration = 2.0;
        rotationAnimation.isCumulative = true;
        rotationAnimation.repeatCount = .infinity;
        image.layer.add(rotationAnimation, forKey: "rotationAnimation")
    }
    
    func StopRotateImage(image: UIImageView) {
        image.layer.removeAnimation(forKey: "rotationAnimation")
    }

}
