//
//  AnimationClassProtocol.swift
//  QUIZ
//
//  Created by Марк Киричко on 08.01.2023.
//

import UIKit

protocol AnimationClassProtocol {
    func SpringAnimation<T: UIView>(view: T)
    func RotateAnimation<T: UIView>(view: T)
    func StartRotateAnimation<T: UIView>(view: T)
    func StopRotateAnimation<T: UIView>(view: T)
    func TabBarItemAnimation(item: UITabBarItem)
}
