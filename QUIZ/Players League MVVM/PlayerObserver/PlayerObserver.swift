//
//  Observable.swift
//  QUIZ
//
//  Created by Марк Киричко on 17.08.2022.
//

import Foundation

// Observable

class PlayerObserver<T> {
    var value: T? {
        didSet {
            listeners.forEach {
                $0(value)
            }
        }
    }
    
    init(_ value: T?) {
        self.value = value
    }
    
    private var listeners: [((T?)-> Void)] = []
    
    func bind(_ listener: @escaping (T?)-> Void) {
        listener(value)
        self.listeners.append(listener)
    }
}
