//
//  QuizBaseObserver.swift
//  QUIZ
//
//  Created by Марк Киричко on 14.08.2022.
//

import Foundation

class QuizBaseObserver<T> {
    typealias Listener = (T)-> Void
    private var listener: Listener?
    
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
}
