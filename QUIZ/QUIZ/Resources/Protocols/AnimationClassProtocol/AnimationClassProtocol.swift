//
//  AnimationClassProtocol.swift
//  QUIZ
//
//  Created by Марк Киричко on 08.01.2023.
//

import UIKit

protocol AnimationClassProtocol {
    func SpringAnimation<T: UIView>(view: T)
    func StartRotateImage(image: UIImageView)
    func StopRotateImage(image: UIImageView)
    func TabBarItemAnimation(item: UITabBarItem)
}
