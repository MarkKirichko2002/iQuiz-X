//
//  VoiceCommandViewModel.swift
//  QUIZ
//
//  Created by Марк Киричко on 03.01.2023.
//

import Foundation
import Combine
import Firebase

class VoiceCommandViewModel {
    
    private let firebaseManager = FirebaseManager()
    private let categoriesViewModel = CategoriesViewModel()
    
    @Published var commands = [VoiceCommandSection(name: "Категории", commands: [VoiceCommandModel(id: 1, name: "астрономия", icon: "astronomy.png", voiceCommand: "планет", sound: "space.wav"), VoiceCommandModel(id: 2, name: "история", icon: "history.jpeg", voiceCommand: "истори", sound: "history.wav"), VoiceCommandModel(id: 3, name: "анатомия", icon: "anatomy.jpeg", voiceCommand: "анатоми", sound: "anatomy.mp3"), VoiceCommandModel(id: 4, name: "спорт", icon: "sport.jpeg", voiceCommand: "спорт", sound: "sport.wav"), VoiceCommandModel(id: 5, name: "игры", icon: "games.jpeg", voiceCommand: "игр", sound: "games.mp3"), VoiceCommandModel(id: 6, name: "IQ", icon: "IQ.jpeg", voiceCommand: "интеллект", sound: "IQ.mp3"), VoiceCommandModel(id: 7, name: "экономика", icon: "economy.jpeg", voiceCommand: "экономи", sound: "economics.mp3"), VoiceCommandModel(id: 8, name: "география", icon: "geography.jpeg", voiceCommand: "географи", sound: "geography.mp3"), VoiceCommandModel(id: 9, name: "экология", icon: "ecology.jpeg", voiceCommand: "экологи", sound: "ecology.wav"), VoiceCommandModel(id: 10, name: "физика", icon: "physics.jpeg", voiceCommand: "физ", sound: "physics.mp3"), VoiceCommandModel(id: 11, name: "химия", icon: "chemistry.jpeg", voiceCommand: "хим", sound: "chemistry.mp3"), VoiceCommandModel(id: 12, name: "информатика", icon: "informatics.jpeg", voiceCommand: "информа", sound: "informatics.mp3"), VoiceCommandModel(id: 13, name: "литература", icon: "literature.jpeg", voiceCommand: "литера", sound: "literature.mp3"), VoiceCommandModel(id: 14, name: "ПДД", icon: "drive.jpeg", voiceCommand: "дорог", sound: "roadtraffic.mp3"), VoiceCommandModel(id: 15, name: "Swift", icon: "swift.jpeg", voiceCommand: "swift", sound: "swift.mp3"), VoiceCommandModel(id: 16, name: "подводный мир", icon: "underwater.png", voiceCommand: "мор", sound: "underwater.wav"), VoiceCommandModel(id: 17, name: "шахматы", icon: "chess.png", voiceCommand: "шахмат", sound: "chess.mp3"), VoiceCommandModel(id: 18, name: "хэллоуин", icon: "halloween.png", voiceCommand: "halloween.wav", sound: "halloween.wav"), VoiceCommandModel(id: 19, name: "новый год", icon: "newyear.png", voiceCommand: "рождеств", sound: "newyear.mp3")]), VoiceCommandSection(name: "Викторина", commands: [VoiceCommandModel(id: 20, name: "показать решение", icon: "hints.png", voiceCommand: "решение", sound: "broken light bulb.mp3"), VoiceCommandModel(id: 21, name: "пропустить вопрос", icon: "skip.png", voiceCommand: "след", sound: ""), VoiceCommandModel(id: 22, name: "завершить викторину", icon: "exit.png", voiceCommand: "выход", sound: "")]), VoiceCommandSection(name: "Навигация", commands: [VoiceCommandModel(id: 23, name: "новости", icon: "newspaper.png", voiceCommand: "новост", sound: "literature.mp3"), VoiceCommandModel(id: 24, name: "викторина", icon: "astronomy.png", voiceCommand: "категори", sound: "IQ.mp3"), VoiceCommandModel(id: 25, name: "лига игроков", icon: "trophy.png", voiceCommand: "лига", sound: "league.mp3"), VoiceCommandModel(id: 26, name: "профиль", icon: "IQ.jpeg", voiceCommand: "проф", sound: "IQ.mp3")])]
    
    // обновить голосовую команду
    func UpdateVoiceCommand(id: Int, voicecommand: VoiceCommandModel, text: String) {
        self.firebaseManager.SaveCustomVoiceCommand(id: id, voicecommand: voicecommand, text: text)
    }
    
    // получить голосовые команды
    func GetVoiceCommands() {
        for i in 0...2 {
            for value in commands[i].commands {
                self.configure(command: value)
            }
        }
    }
    
    func configure(command: VoiceCommandModel) {
        switch command.id {
            
        case 1:
            self.firebaseManager.LoadVoiceCommands(command: command.name) { command in
                self.commands[0].commands[0].voiceCommand = command.lowercased()
            }
            
        case 2:
            self.firebaseManager.LoadVoiceCommands(command: command.name) { command in
                self.commands[0].commands[1].voiceCommand = command.lowercased()
            }
            
        case 3:
            self.firebaseManager.LoadVoiceCommands(command: command.name) { command in
                self.commands[0].commands[2].voiceCommand = command.lowercased()
            }
            
        case 4:
            self.firebaseManager.LoadVoiceCommands(command: command.name) { command in
                self.commands[0].commands[3].voiceCommand = command.lowercased()
            }
            
        case 5:
            self.firebaseManager.LoadVoiceCommands(command: command.name) { command in
                self.commands[0].commands[4].voiceCommand = command.lowercased()
            }
            
        case 6:
            self.firebaseManager.LoadVoiceCommands(command: command.name) { command in
                self.commands[0].commands[5].voiceCommand = command.lowercased()
            }
            
        case 7:
            self.firebaseManager.LoadVoiceCommands(command: command.name) { command in
                self.commands[0].commands[6].voiceCommand = command.lowercased()
            }
            
        case 8:
            self.firebaseManager.LoadVoiceCommands(command: command.name) { command in
                self.commands[0].commands[7].voiceCommand = command.lowercased()
            }
            
        case 9:
            self.firebaseManager.LoadVoiceCommands(command: command.name) { command in
                self.commands[0].commands[8].voiceCommand = command.lowercased()
            }
            
        case 10:
            self.firebaseManager.LoadVoiceCommands(command: command.name) { command in
                self.commands[0].commands[9].voiceCommand = command.lowercased()
            }
            
        case 11:
            self.firebaseManager.LoadVoiceCommands(command: command.name) { command in
                self.commands[0].commands[10].voiceCommand = command.lowercased()
            }
            
        case 12:
            self.firebaseManager.LoadVoiceCommands(command: command.name) { command in
                self.commands[0].commands[11].voiceCommand = command.lowercased()
            }
            
        case 13:
            self.firebaseManager.LoadVoiceCommands(command: command.name) { command in
                self.commands[0].commands[12].voiceCommand = command.lowercased()
            }
            
        case 14:
            self.firebaseManager.LoadVoiceCommands(command: command.name) { command in
                self.commands[0].commands[13].voiceCommand = command.lowercased()
            }
            
        case 15:
            self.firebaseManager.LoadVoiceCommands(command: command.name) { command in
                self.commands[0].commands[14].voiceCommand = command.lowercased()
            }
            
        case 16:
            self.firebaseManager.LoadVoiceCommands(command: command.name) { command in
                self.commands[0].commands[15].voiceCommand = command.lowercased()
            }
            
        case 17:
            self.firebaseManager.LoadVoiceCommands(command: command.name) { command in
                self.commands[0].commands[16].voiceCommand = command.lowercased()
            }
            
        case 18:
            self.firebaseManager.LoadVoiceCommands(command: command.name) { command in
                self.commands[0].commands[17].voiceCommand = command.lowercased()
            }
            
        case 19:
            self.firebaseManager.LoadVoiceCommands(command: command.name) { command in
                self.commands[0].commands[18].voiceCommand = command.lowercased()
            }
            
        default:
            break
        }
    }
}
