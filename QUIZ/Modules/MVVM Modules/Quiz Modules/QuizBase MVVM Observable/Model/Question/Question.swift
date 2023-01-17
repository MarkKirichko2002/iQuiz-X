//
//  Question.swift
//  QUIZ
//
//  Created by Марк Киричко on 26.02.2022.
//

import Foundation

struct Question {
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
}
