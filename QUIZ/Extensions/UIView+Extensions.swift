//
//  UIView.swift
//  QUIZ
//
//  Created by Марк Киричко on 02.01.2023.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {return self.cornerRadius}
        set {
            self.layer.cornerRadius = newValue
        }
    }
    func addSubviews(_ views: UIView...) {
        views.forEach ({
           addSubview($0)
        })
    }
}
