//
//  QuizCategories.swift
//  QUIZ
//
//  Created by Марк Киричко on 16.05.2023.
//

import Foundation

struct QuizCategories {
    static let categories = [
        QuizCategoryModel(id: 1, name: "астрономия", image: "astronomy.png", AppIcon: "AppIcon 1", base:  QuizAstronomy(), quizpath: "quizastronomy", voiceCommand: "планет", date: "", background: "earth.background.jpeg", complete: false, score: 0, sound: "space.wav", music: "space music.mp3"),
        QuizCategoryModel(id: 2, name: "история", image: "history.jpeg", AppIcon: "AppIcon 2", base: QuizHistory(), quizpath: "quizhistory", voiceCommand: "истори", date: "", background: "history.background.jpeg", complete: false, score: 0, sound: "history.wav", music: "history music.mp3"),
        QuizCategoryModel(id: 3, name: "анатомия", image: "anatomy.jpeg", AppIcon: "AppIcon 3", base: QuizAnatomy(), quizpath: "quizanatomy", voiceCommand:"анатоми", date: "", background: "anatomy.background.jpeg", complete: false, score: 0, sound: "anatomy.mp3", music: "anatomy music.mp3"),
        QuizCategoryModel(id: 4, name: "спорт", image: "sport.jpeg", AppIcon: "AppIcon 4", base: QuizSport(), quizpath: "quizsport", voiceCommand: "спорт", date: "", background: "sport.background.jpeg", complete: false, score: 0, sound: "sport.wav", music: "sport music.mp3"),
        QuizCategoryModel(id: 5, name: "игры", image: "games.jpeg", AppIcon: "AppIcon 5", base: QuizGames(), quizpath: "quizgames", voiceCommand: "игр", date: "", background: "games.background.jpeg", complete: false, score: 0, sound: "games.mp3", music: "games music.mp3"),
        QuizCategoryModel(id: 6, name: "IQ", image: "IQ.jpeg", AppIcon: "AppIcon", base: QuizIQ(), quizpath: "quiziq", voiceCommand: "интеллект", date: "", background: "IQ.background.jpeg", complete: false, score: 0, sound: "IQ.mp3", music: "IQ music.mp3"),
        QuizCategoryModel(id: 7, name: "экономика", image: "economy.jpeg", AppIcon: "AppIcon 7", base: QuizEconomy(), quizpath: "quizeconomy", voiceCommand: "экономика", date: "", background: "economy.background.jpeg", complete: false, score: 0, sound: "economics.mp3", music: "economy music.mp3"),
        QuizCategoryModel(id: 8, name: "география", image: "geography.jpeg", AppIcon: "AppIcon 8", base: QuizGeography(), quizpath: "quizgeography", voiceCommand: "географи", date: "", background: "geography.background.jpeg", complete: false, score: 0, sound: "geography.mp3", music: "geography music.mp3"),
        QuizCategoryModel(id: 9, name: "экология", image: "ecology.jpeg", AppIcon: "AppIcon 9", base: QuizEcology(), quizpath: "quizecology", voiceCommand: "экологи", date: "", background: "ecology.background.jpeg", complete: false, score: 0, sound: "ecology.wav", music: "ecology music.mp3"),
        QuizCategoryModel(id: 10, name: "физика", image: "physics.jpeg", AppIcon: "AppIcon 10", base: QuizPhysics(), quizpath: "quizphysics", voiceCommand: "физ", date: "", background: "physics.background.jpeg", complete: false, score: 0, sound: "physics.mp3", music: "physics music.mp3"),
        QuizCategoryModel(id: 11, name: "химия", image: "chemistry.jpeg", AppIcon: "AppIcon 11", base: QuizChemistry(), quizpath: "quizchemistry", voiceCommand: "хим", date: "", background: "chemistry.background.jpeg", complete: false, score: 0, sound: "chemistry.mp3", music: "chemistry music.mp3"),
        QuizCategoryModel(id: 12, name: "информатика", image: "informatics.jpeg", AppIcon: "AppIcon 12", base: QuizInformatics(), quizpath: "quizinformatics", voiceCommand: "информа", date: "", background: "informatics.background.jpeg", complete: false, score: 0, sound: "informatics.mp3", music: "informatics music.mp3"),
        QuizCategoryModel(id: 13, name: "литература", image: "literature.jpeg", AppIcon: "AppIcon 13", base: QuizLiterature(), quizpath: "quizliterature", voiceCommand: "литера", date: "", background: "literature.background.jpeg", complete: false, score: 0, sound: "literature.mp3", music: "literature music.mp3"),
        QuizCategoryModel(id: 14, name: "ПДД", image: "drive.jpeg", AppIcon: "AppIcon 14", base: QuizRoadTraffic(), quizpath: "quizroadtraffic", voiceCommand: "дорог", date: "", background: "drive.background.jpeg", complete: false, score: 0, sound: "roadtraffic.mp3", music: "drive music.mp3"),
        QuizCategoryModel(id: 15, name: "Swift", image: "swift.jpeg", AppIcon: "AppIcon 15", base: QuizSwift(), quizpath: "quizswift", voiceCommand: "swift", date: "", background:"swift.background.jpeg", complete: false, score: 0, sound: "swift.mp3", music: "Swift music.mp3"),
        QuizCategoryModel(id: 16, name: "подводный мир", image: "underwater.png", AppIcon: "AppIcon 16", base: QuizUnderwater(), quizpath: "quizunderwater", voiceCommand: "мор", date: "", background: "underwater.background.jpeg", complete: false, score: 0, sound: "underwater.wav", music: "underwater music.mp3"),
        QuizCategoryModel(id: 17, name: "шахматы", image: "chess.png", AppIcon: "AppIcon 17", base: QuizChess(), quizpath: "quizchess", voiceCommand: "шахмат", date: "", background: "chess.background.jpeg", complete: false, score: 0, sound: "chess.mp3", music: "chess music.mp3"),
        QuizCategoryModel(id: 18, name: "хэллоуин", image: "halloween.png", AppIcon: "AppIcon 18", base: QuizHalloween(), quizpath: "quizhalloween", voiceCommand: "halloween", date: "", background: "halloween.background.jpeg", complete: false, score: 0, sound: "halloween.wav", music: "halloween music.mp3"),
        QuizCategoryModel(id: 19, name: "новый год", image: "newyear.png", AppIcon: "AppIcon", base: QuizNewYear(), quizpath: "quiznewyear", voiceCommand: "рождеств", date: "", background: "newyear.background.jpeg", complete: false, score: 0, sound: "newyear.mp3", music: "newyear music.mp3")
        ]
}
