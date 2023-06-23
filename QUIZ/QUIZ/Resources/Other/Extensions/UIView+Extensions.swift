//
//  UIView.swift
//  QUIZ
//
//  Created by Марк Киричко on 02.01.2023.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        views.forEach ({
           addSubview($0)
        })
    }
}
