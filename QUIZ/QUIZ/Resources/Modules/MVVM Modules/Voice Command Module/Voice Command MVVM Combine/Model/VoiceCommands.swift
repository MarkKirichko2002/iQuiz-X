//
//  VoiceCommands.swift
//  QUIZ
//
//  Created by Марк Киричко on 26.05.2023.
//

import Foundation

struct VoiceCommands {
    static let commands = [
        VoiceCommandSection(name: "Категории", commands: [VoiceCommandModel(id: 1, name: "астрономия", icon: "astronomy.png", voiceCommand: "планет", sound: "space.wav"), VoiceCommandModel(id: 2, name: "история", icon: "history.jpeg", voiceCommand: "истори", sound: "history.wav"), VoiceCommandModel(id: 3, name: "анатомия", icon: "anatomy.jpeg", voiceCommand: "анатоми", sound: "anatomy.mp3"), VoiceCommandModel(id: 4, name: "спорт", icon: "sport.jpeg", voiceCommand: "спорт", sound: "sport.wav"), VoiceCommandModel(id: 5, name: "игры", icon: "games.jpeg", voiceCommand: "игр", sound: "games.mp3"), VoiceCommandModel(id: 6, name: "IQ", icon: "IQ.jpeg", voiceCommand: "интеллект", sound: "IQ.mp3"), VoiceCommandModel(id: 7, name: "экономика", icon: "economy.jpeg", voiceCommand: "экономи", sound: "economics.mp3"), VoiceCommandModel(id: 8, name: "география", icon: "geography.jpeg", voiceCommand: "географи", sound: "geography.mp3"), VoiceCommandModel(id: 9, name: "экология", icon: "ecology.jpeg", voiceCommand: "экологи", sound: "ecology.wav"), VoiceCommandModel(id: 10, name: "физика", icon: "physics.jpeg", voiceCommand: "физ", sound: "physics.mp3"), VoiceCommandModel(id: 11, name: "химия", icon: "chemistry.jpeg", voiceCommand: "хим", sound: "chemistry.mp3"), VoiceCommandModel(id: 12, name: "информатика", icon: "informatics.jpeg", voiceCommand: "информа", sound: "informatics.mp3"), VoiceCommandModel(id: 13, name: "литература", icon: "literature.jpeg", voiceCommand: "литера", sound: "literature.mp3"), VoiceCommandModel(id: 14, name: "ПДД", icon: "drive.jpeg", voiceCommand: "дорог", sound: "roadtraffic.mp3"), VoiceCommandModel(id: 15, name: "Swift", icon: "swift.jpeg", voiceCommand: "swift", sound: "swift.mp3"), VoiceCommandModel(id: 16, name: "подводный мир", icon: "underwater.png", voiceCommand: "мор", sound: "underwater.wav"), VoiceCommandModel(id: 17, name: "шахматы", icon: "chess.png", voiceCommand: "шахмат", sound: "chess.mp3"), VoiceCommandModel(id: 18, name: "хэллоуин", icon: "halloween.png", voiceCommand: "halloween.wav", sound: "halloween.wav"), VoiceCommandModel(id: 19, name: "новый год", icon: "newyear.png", voiceCommand: "рождеств", sound: "newyear.mp3")])
    ]
}
