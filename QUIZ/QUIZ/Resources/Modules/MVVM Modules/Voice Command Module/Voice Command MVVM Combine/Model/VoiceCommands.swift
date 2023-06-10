//
//  VoiceCommands.swift
//  QUIZ
//
//  Created by Марк Киричко on 26.05.2023.
//

import Foundation

struct VoiceCommands {
    static let commands = [
        VoiceCommandSection(name: "Категории", commands: [VoiceCommandModel(id: 1, name: "астрономия", icon: "astronomy.png", voiceCommand: "планет", path: "quizastronomy",  sound: "space.wav"), VoiceCommandModel(id: 2, name: "история", icon: "history.jpeg", voiceCommand: "истори", path: "quizhistory", sound: "history.wav"), VoiceCommandModel(id: 3, name: "анатомия", icon: "anatomy.jpeg", voiceCommand: "анатоми", path: "quizanatomy", sound: "anatomy.mp3"), VoiceCommandModel(id: 4, name: "спорт", icon: "sport.jpeg", voiceCommand: "спорт", path: "quizsport", sound: "sport.wav"), VoiceCommandModel(id: 5, name: "игры", icon: "games.jpeg", voiceCommand: "игр", path: "quizgames", sound: "games.mp3"), VoiceCommandModel(id: 6, name: "IQ", icon: "IQ.jpeg", voiceCommand: "интеллект", path: "quiziq", sound: "IQ.mp3"), VoiceCommandModel(id: 7, name: "экономика", icon: "economy.jpeg", voiceCommand: "экономи", path: "quizeconomy", sound: "economics.mp3"), VoiceCommandModel(id: 8, name: "география", icon: "geography.jpeg", voiceCommand: "географи", path: "quizgeography", sound: "geography.mp3"), VoiceCommandModel(id: 9, name: "экология", icon: "ecology.jpeg", voiceCommand: "экологи", path: "quizecology", sound: "ecology.wav"), VoiceCommandModel(id: 10, name: "физика", icon: "physics.jpeg", voiceCommand: "физ", path: "quizphysics", sound: "physics.mp3"), VoiceCommandModel(id: 11, name: "химия", icon: "chemistry.jpeg", voiceCommand: "хим", path: "quizchemistry", sound: "chemistry.mp3"), VoiceCommandModel(id: 12, name: "информатика", icon: "informatics.jpeg", voiceCommand: "информа", path: "quizinformatics", sound: "informatics.mp3"), VoiceCommandModel(id: 13, name: "литература", icon: "literature.jpeg", voiceCommand: "литера", path: "quizliterature", sound: "literature.mp3"), VoiceCommandModel(id: 14, name: "ПДД", icon: "drive.jpeg", voiceCommand: "дорог", path: "quizroadtraffic", sound: "roadtraffic.mp3"), VoiceCommandModel(id: 15, name: "Swift", icon: "swift.jpeg", voiceCommand: "swift", path: "quizswift", sound: "swift.mp3"), VoiceCommandModel(id: 16, name: "подводный мир", icon: "underwater.png", voiceCommand: "мор", path: "quizunderwater", sound: "underwater.wav"), VoiceCommandModel(id: 17, name: "шахматы", icon: "chess.png", voiceCommand: "шахмат", path: "quizchess", sound: "chess.mp3"), VoiceCommandModel(id: 18, name: "хэллоуин", icon: "halloween.png", voiceCommand: "halloween.wav", path: "quizhalloween", sound: "halloween.wav"), VoiceCommandModel(id: 19, name: "новый год", icon: "newyear.png", voiceCommand: "рождеств", path: "quiznewyear", sound: "newyear.mp3")])
    ]
}
