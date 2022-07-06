//
//  TodayModel.swift
//  QUIZ
//
//  Created by Марк Киричко on 24.03.2022.
//

import Foundation

struct TodayModel {
    var name: String
    var image: String
    var background: String
}

struct TodayStorage {
    static let shared = TodayStorage()
    
    var todays: [TodayModel]

     init() {
         todays = [TodayModel(name: "погода", image: "weather.png", background: "clear.background.jpeg")]
    }
}


