//
//  AnimationsClass.swift
//  QUIZ
//
//  Created by Марк Киричко on 16.02.2022.
//

import Foundation
import UIKit

class AnimationClass {
    
    var label = UILabel()
    var image = UIImageView()
    
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

    
}
