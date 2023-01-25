//
//  SettingsManagerProtocol.swift
//  QUIZ
//
//  Created by Марк Киричко on 08.01.2023.
//

import Foundation

protocol SettingsManagerProtocol {
    func loadProfileInfo(completion: @escaping(ProfileInfoViewModel)->())
    func ResetSettings()
    func ChangeVoicePassword()
}
