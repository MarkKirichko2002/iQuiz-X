//
//  AnimationClassProtocol.swift
//  QUIZ
//
//  Created by Марк Киричко on 08.01.2023.
//

import UIKit

protocol AnimationClassProtocol {
    func springLabel(label: UILabel)
    func springImage(image: UIImageView)
    func springButton(button: UIButton)
    func StartRotateImage(image: UIImageView)
    func StopRotateImage(image: UIImageView)
    func TabBarItemAnimation(item: UITabBarItem)
}
