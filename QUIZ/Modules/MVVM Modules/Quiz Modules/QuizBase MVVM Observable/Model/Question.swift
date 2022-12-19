//
//  Question.swift
//  QUIZ
//
//  Created by Марк Киричко on 26.02.2022.
//

import Foundation
struct Question { //convention to make struct the file name
    let question: String
    let choices: [String]
    let answer: String
    let image: String
    let levelOfdifficulty: levelOfdifficulty
    
    enum levelOfdifficulty {
        case easy
        case normal
        case hard
    }
    
    init(question: String, choices: [String], answer: String, image: String, levelOfdifficulty: levelOfdifficulty) {
        self.question = question
        self.choices = choices
        self.answer = answer
        self.image = image
        self.levelOfdifficulty = levelOfdifficulty
    }
}


