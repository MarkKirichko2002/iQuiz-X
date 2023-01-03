//
//  VoiceCommandModel.swift
//  QUIZ
//
//  Created by Марк Киричко on 03.01.2023.
//

import Foundation

struct VoiceCommandSection {
    let name: String
    var commands: [VoiceCommandModel]
}

struct VoiceCommandModel: Codable {
    let id: Int
    let name: String
    let icon: String
    var voiceCommand: String
    let sound: String
}
