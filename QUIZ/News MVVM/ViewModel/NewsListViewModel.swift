//
//  NewsAPI.swift
//  QUIZ
//
//  Created by Марк Киричко on 29.06.2022.
//

import Foundation
import Alamofire
import DynamicJSON

// Observable

class Observable<T> {
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


struct NewsListViewModel {
    var news: Observable<[NewsTableViewCellViewModel]> = Observable([])
}


