//
//  VoiceCommandViewModel.swift
//  QUIZ
//
//  Created by Марк Киричко on 03.01.2023.
//

import Foundation
import Combine

class VoiceCommandViewModel {
    
    private let firebaseManager = FirebaseManager()
   
    @Published var commands = VoiceCommands.commands
    
    // обновить голосовую команду
    func UpdateVoiceCommand(id: Int, voicecommand: VoiceCommandModel, text: String) {
        self.firebaseManager.SaveCustomVoiceCommand(id: id, voicecommand: voicecommand, text: text)
    }
    
    // получить голосовые команды
    func GetVoiceCommands() {
       for value in commands[0].commands {
            self.configure(command: value)
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
