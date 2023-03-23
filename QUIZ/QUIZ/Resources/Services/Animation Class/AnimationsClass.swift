//
//  AnimationsClass.swift
//  QUIZ
//
//  Created by Марк Киричко on 16.02.2022.
//

import UIKit

class AnimationClass: AnimationClassProtocol {
    
    private let rotationAnimation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
    
    // пружинная анимация
    func SpringAnimation<T: UIView>(view: T) {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0
        animation.toValue = 1
        animation.stiffness = 300
        animation.mass = 1
        animation.duration = 0.5
        animation.beginTime = CACurrentMediaTime() + 0
        view.layer.add(animation, forKey: nil)
    }
    
    // анимация вращения
    func RotateAnimation<T: UIView>(view: T) {
        rotationAnimation.toValue = NSNumber(value: 180)
        view.layer.add(rotationAnimation, forKey: "rotationAnimation")
    }
    
    // начать анимацию вращения
    func StartRotateAnimation<T: UIView>(view: T) {
        rotationAnimation.toValue = NSNumber(value: .pi * 2.0)
        rotationAnimation.duration = 2.0;
        rotationAnimation.isCumulative = true;
        rotationAnimation.repeatCount = .infinity;
        view.layer.add(rotationAnimation, forKey: "rotationAnimation")
    }
    
    // завершить анимацию вращения
    func StopRotateAnimation<T: UIView>(view: T) {
        view.layer.removeAnimation(forKey: "rotationAnimation")
    }
   
    // анимация TabBarItem
    func TabBarItemAnimation(item: UITabBarItem) {
        guard let barItemView = item.value(forKey: "view") as? UIView else { return }
        
        let timeInterval: TimeInterval = 0.3
        let propertyAnimator = UIViewPropertyAnimator(duration: timeInterval, dampingRatio: 1.5) {
            barItemView.transform = CGAffineTransform.identity.scaledBy(x: 1.5, y: 1.5)
        }
        propertyAnimator.addAnimations({ barItemView.transform = .identity }, delayFactor: CGFloat(timeInterval))
        propertyAnimator.startAnimation()
    }
}
