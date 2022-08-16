//
//  Event.swift
//  QUIZ
//
//  Created by Марк Киричко on 17.08.2022.
//

import Foundation

class Event<T> {
    let identifier: String
    let result: Result<T, Error>?
    
    init(identifier: String, result: Result<T, Error>) {
        self.identifier = identifier
        self.result = result
    }
}

class NewsFetchEvent: Event<[Article]> {
    
}
