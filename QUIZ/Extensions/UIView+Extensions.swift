//
//  UIView.swift
//  QUIZ
//
//  Created by Марк Киричко on 02.01.2023.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {return cornerRadius}
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
