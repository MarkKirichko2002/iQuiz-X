//
//  FirebaseManagerProtocol.swift
//  QUIZ
//
//  Created by Марк Киричко on 08.01.2023.
//

import Foundation

protocol FirebaseManagerProtocol {
    func LoadQuizCategoriesData(quizpath: String, completion: @escaping(QuizCategoryViewModel)->())
    func LoadQuizTasksData(quizpath: String, completion: @escaping(QuizTaskViewModel)->())
    func LoadLastQuizCategoryData(completion: @escaping(QuizResult)->())
    func LoadPlayers(completion: @escaping([Player])->())
    func LoadProfileInfo(completion: @escaping(Profile)->())
    func SaveCustomVoiceCommand(id: Int, voicecommand: VoiceCommandModel, text: String)
    func LoadVoiceCommands(command: String, completion: @escaping(String)->())
    func UpdateProfilePhoto(string: String)
    func DeleteAccount()
    func SignOutAction()
}
