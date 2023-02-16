//
//  QuizCategoriesViewModel.swift
//  QUIZ
//
//  Created by Марк Киричко on 02.07.2022.
//

import Foundation
import UIKit
import Combine
import SnapKit

class QuizCategoriesViewModel {
    
    private let fbManager = FirebaseManager()
    private let spinner = RoundedImageView()
    private let loadingText = UILabel()
    private let animation = AnimationClass()
    private let textRecognitionManager = TextRecognitionManager()
    @Published var categories = [QuizCategoriesSection]()
    var view: UIView?
    var storyboard: UIStoryboard?
    
    var quizcategories = [QuizCategoryModel(id: 1, name: "астрономия", image: "astronomy.png", base:  QuizAstronomy(), quizpath: "quizastronomy", voiceCommand: "планет", date: "", background: "earth.background.jpeg", complete: false, score: 0, sound: "space.wav", music: "space music.mp3"), QuizCategoryModel(id: 2, name: "история", image: "history.jpeg", base: QuizHistory(), quizpath: "quizhistory", voiceCommand: "истори", date: "", background: "history.background.jpeg", complete: false, score: 0, sound: "history.wav", music: "history music.mp3"), QuizCategoryModel(id: 3, name: "анатомия", image: "anatomy.jpeg", base: QuizAnatomy(), quizpath: "quizanatomy", voiceCommand:"анатоми", date: "", background: "anatomy.background.jpeg", complete: false, score: 0, sound: "anatomy.mp3", music: "anatomy music.mp3"), QuizCategoryModel(id: 4, name: "спорт", image: "sport.jpeg", base: QuizSport(), quizpath: "quizsport", voiceCommand: "спорт", date: "", background: "sport.background.jpeg", complete: false, score: 0, sound: "sport.wav", music: "sport music.mp3"), QuizCategoryModel(id: 5, name: "игры", image: "games.jpeg", base: QuizGames(), quizpath: "quizgames", voiceCommand: "игр", date: "", background: "games.background.jpeg", complete: false, score: 0, sound: "games.mp3", music: "games music.mp3"), QuizCategoryModel(id: 6, name: "IQ", image: "IQ.jpeg", base: QuizIQ(), quizpath: "quiziq", voiceCommand: "интеллект", date: "", background: "IQ.background.jpeg", complete: false, score: 0, sound: "IQ.mp3", music: "IQ music.mp3"), QuizCategoryModel(id: 7, name: "экономика", image: "economy.jpeg", base: QuizEconomy(), quizpath: "quizeconomy", voiceCommand: "экономика", date: "", background: "economy.background.jpeg", complete: false, score: 0, sound: "economics.mp3", music: "economy music.mp3"), QuizCategoryModel(id: 8, name: "география", image: "geography.jpeg", base: QuizGeography(), quizpath: "quizgeography", voiceCommand: "географи", date: "", background: "geography.background.jpeg", complete: false, score: 0, sound: "geography.mp3", music: "geography music.mp3"), QuizCategoryModel(id: 9, name: "экология", image: "ecology.jpeg", base: QuizEcology(), quizpath: "quizecology", voiceCommand: "экологи", date: "", background: "ecology.background.jpeg", complete: false, score: 0, sound: "ecology.wav", music: "ecology music.mp3"), QuizCategoryModel(id: 10, name: "физика", image: "physics.jpeg", base: QuizPhysics(), quizpath: "quizphysics", voiceCommand: "физ", date: "", background: "physics.background.jpeg", complete: false, score: 0, sound: "physics.mp3", music: "physics music.mp3"), QuizCategoryModel(id: 11, name: "химия", image: "chemistry.jpeg", base: QuizChemistry(), quizpath: "quizchemistry", voiceCommand: "хим", date: "", background: "chemistry.background.jpeg", complete: false, score: 0, sound: "chemistry.mp3", music: "chemistry music.mp3"), QuizCategoryModel(id: 12, name: "информатика", image: "informatics.jpeg", base: QuizInformatics(), quizpath: "quizinformatics", voiceCommand: "информа", date: "", background: "informatics.background.jpeg", complete: false, score: 0, sound: "informatics.mp3", music: "informatics music.mp3"), QuizCategoryModel(id: 13, name: "литература", image: "literature.jpeg", base: QuizLiterature(), quizpath: "quizliterature", voiceCommand: "литера", date: "", background: "literature.background.jpeg", complete: false, score: 0, sound: "literature.mp3", music: "literature music.mp3"), QuizCategoryModel(id: 14, name: "ПДД", image: "drive.jpeg", base: QuizRoadTraffic(), quizpath: "quizroadtraffic", voiceCommand: "дорог", date: "", background: "drive.background.jpeg", complete: false, score: 0, sound: "roadtraffic.mp3", music: "drive music.mp3"), QuizCategoryModel(id: 15, name: "Swift", image: "swift.jpeg", base: QuizSwift(), quizpath: "quizswift", voiceCommand: "swift", date: "", background:"swift.background.jpeg", complete: false, score: 0, sound: "swift.mp3", music: "Swift music.mp3"), QuizCategoryModel(id: 16, name: "подводный мир", image: "underwater.png", base: QuizUnderwater(), quizpath: "quizunderwater", voiceCommand: "мор", date: "", background: "underwater.background.jpeg", complete: false, score: 0, sound: "underwater.wav", music: "underwater music.mp3"), QuizCategoryModel(id: 17, name: "шахматы", image: "chess.png", base: QuizChess(), quizpath: "quizchess", voiceCommand: "шахмат", date: "", background: "chess.background.jpeg", complete: false, score: 0, sound: "chess.mp3", music: "chess music.mp3"), QuizCategoryModel(id: 18, name: "хэллоуин", image: "halloween.png", base: QuizHalloween(), quizpath: "quizhalloween", voiceCommand: "halloween", date: "", background: "halloween.background.jpeg", complete: false, score: 0, sound: "halloween.wav", music: "halloween music.mp3"), QuizCategoryModel(id: 19, name: "новый год", image: "newyear.png", base: QuizNewYear(), quizpath: "quiznewyear", voiceCommand: "рождеств", date: "", background: "newyear.background.jpeg", complete: false, score: 0, sound: "newyear.mp3", music: "newyear music.mp3")]
    
    func CreateCategories() {
        categories = [QuizCategoriesSection(releaseDate: "февраль 2022", categories: [QuizCategoryModel(id: 1, name: "астрономия", image: "astronomy.png", base:  QuizAstronomy(), quizpath: "quizastronomy", voiceCommand: "планет", date: "", background: "earth.background.jpeg", complete: false, score: 0, sound: "space.wav", music: "space music.mp3"), QuizCategoryModel(id: 2, name: "история", image: "history.jpeg", base: QuizHistory(), quizpath: "quizhistory", voiceCommand: "истори", date: "", background: "history.background.jpeg", complete: false, score: 0, sound: "history.wav", music: "history music.mp3"), QuizCategoryModel(id: 3, name: "анатомия", image: "anatomy.jpeg", base: QuizAnatomy(), quizpath: "quizanatomy", voiceCommand:"анатоми", date: "", background: "anatomy.background.jpeg", complete: false, score: 0, sound: "anatomy.mp3", music: "anatomy music.mp3"), QuizCategoryModel(id: 4, name: "спорт", image: "sport.jpeg", base: QuizSport(), quizpath: "quizsport", voiceCommand: "спорт", date: "", background: "sport.background.jpeg", complete: false, score: 0, sound: "sport.wav", music: "sport music.mp3")]), QuizCategoriesSection(releaseDate: "март 2022", categories: [QuizCategoryModel(id: 5, name: "игры", image: "games.jpeg", base: QuizGames(), quizpath: "quizgames", voiceCommand: "игр", date: "", background: "games.background.jpeg", complete: false, score: 0, sound: "games.mp3", music: "games music.mp3"), QuizCategoryModel(id: 6, name: "IQ", image: "IQ.jpeg", base: QuizIQ(), quizpath: "quiziq", voiceCommand: "интеллект", date: "", background: "IQ.background.jpeg", complete: false, score: 0, sound: "IQ.mp3", music: "IQ music.mp3"), QuizCategoryModel(id: 7, name: "экономика", image: "economy.jpeg", base: QuizEconomy(), quizpath: "quizeconomy", voiceCommand: "экономика", date: "", background: "economy.background.jpeg", complete: false, score: 0, sound: "economics.mp3", music: "economy music.mp3"), QuizCategoryModel(id: 8, name: "география", image: "geography.jpeg", base: QuizGeography(), quizpath: "quizgeography", voiceCommand: "географи", date: "", background: "geography.background.jpeg", complete: false, score: 0, sound: "geography.mp3", music: "geography music.mp3"), QuizCategoryModel(id: 9, name: "экология", image: "ecology.jpeg", base: QuizEcology(), quizpath: "quizecology", voiceCommand: "экологи", date: "", background: "ecology.background.jpeg", complete: false, score: 0, sound: "ecology.wav", music: "ecology music.mp3"), QuizCategoryModel(id: 10, name: "физика", image: "physics.jpeg", base: QuizPhysics(), quizpath: "quizphysics", voiceCommand: "физ", date: "", background: "physics.background.jpeg", complete: false, score: 0, sound: "physics.mp3", music: "physics music.mp3"), QuizCategoryModel(id: 11, name: "химия", image: "chemistry.jpeg", base: QuizChemistry(), quizpath: "quizchemistry", voiceCommand: "хим", date: "", background: "chemistry.background.jpeg", complete: false, score: 0, sound: "chemistry.mp3", music: "chemistry music.mp3"), QuizCategoryModel(id: 12, name: "информатика", image: "informatics.jpeg", base: QuizInformatics(), quizpath: "quizinformatics", voiceCommand: "информа", date: "", background: "informatics.background.jpeg", complete: false, score: 0, sound: "informatics.mp3", music: "informatics music.mp3")]), QuizCategoriesSection(releaseDate: "апрель 2022", categories: [QuizCategoryModel(id: 13, name: "литература", image: "literature.jpeg", base: QuizLiterature(), quizpath: "quizliterature", voiceCommand: "литера", date: "", background: "literature.background.jpeg", complete: false, score: 0, sound: "literature.mp3", music: "literature music.mp3"), QuizCategoryModel(id: 14, name: "ПДД", image: "drive.jpeg", base: QuizRoadTraffic(), quizpath: "quizroadtraffic", voiceCommand: "дорог", date: "", background: "drive.background.jpeg", complete: false, score: 0, sound: "roadtraffic.mp3", music: "drive music.mp3"), QuizCategoryModel(id: 15, name: "Swift", image: "swift.jpeg", base: QuizSwift(), quizpath: "quizswift", voiceCommand: "swift", date: "", background:"swift.background.jpeg", complete: false, score: 0, sound: "swift.mp3", music: "Swift music.mp3")]), QuizCategoriesSection(releaseDate: "июль 2022", categories: [QuizCategoryModel(id: 16, name: "подводный мир", image: "underwater.png", base: QuizUnderwater(), quizpath: "quizunderwater", voiceCommand: "мор", date: "", background: "underwater.background.jpeg", complete: false, score: 0, sound: "underwater.wav", music: "underwater music.mp3"), QuizCategoryModel(id: 17, name: "шахматы", image: "chess.png", base: QuizChess(), quizpath: "quizchess", voiceCommand: "шахмат", date: "", background: "chess.background.jpeg", complete: false, score: 0, sound: "chess.mp3", music: "chess music.mp3")]), QuizCategoriesSection(releaseDate: "октябрь 2022", categories: [QuizCategoryModel(id: 18, name: "хэллоуин", image: "halloween.png", base: QuizHalloween(), quizpath: "quizhalloween", voiceCommand: "halloween", date: "", background: "halloween.background.jpeg", complete: false, score: 0, sound: "halloween.wav", music: "halloween music.mp3")]), QuizCategoriesSection(releaseDate: "декабрь 2022", categories: [QuizCategoryModel(id: 19, name: "новый год", image: "newyear.png", base: QuizNewYear(), quizpath: "quiznewyear", voiceCommand: "рождеств", date: "", background: "newyear.background.jpeg", complete: false, score: 0, sound: "newyear.mp3", music: "newyear music.mp3")])]
        
        self.fbManager.LoadVoiceCommands(command: "астрономия") { command in
            self.categories[0].categories[0].voiceCommand = command.lowercased()
        }
        self.fbManager.LoadVoiceCommands(command: "история") { command in
            self.categories[0].categories[1].voiceCommand = command.lowercased()
        }
        
        self.fbManager.LoadVoiceCommands(command: "анатомия") { command in
            self.categories[0].categories[2].voiceCommand = command.lowercased()
        }
        
        self.fbManager.LoadVoiceCommands(command: "спорт") { command in
            self.categories[0].categories[3].voiceCommand = command.lowercased()
        }
        
        self.fbManager.LoadVoiceCommands(command: "игры") { command in
            self.categories[1].categories[0].voiceCommand = command.lowercased()
        }
        
        self.fbManager.LoadVoiceCommands(command: "IQ") { command in
            self.categories[1].categories[1].voiceCommand = command.lowercased()
        }
        
        self.fbManager.LoadVoiceCommands(command: "экономика") { command in
            self.categories[1].categories[2].voiceCommand = command.lowercased()
        }
        
        self.fbManager.LoadVoiceCommands(command: "география") { command in
            self.categories[1].categories[3].voiceCommand = command.lowercased()
        }
        
        self.fbManager.LoadVoiceCommands(command: "экология") { command in
            self.categories[1].categories[4].voiceCommand = command.lowercased()
        }
        
        self.fbManager.LoadVoiceCommands(command: "физика") { command in
            self.categories[1].categories[5].voiceCommand = command.lowercased()
        }
        
        self.fbManager.LoadVoiceCommands(command: "химия") { command in
            self.categories[1].categories[6].voiceCommand = command.lowercased()
        }
        
        self.fbManager.LoadVoiceCommands(command: "информатика") { command in
            self.categories[1].categories[7].voiceCommand = command.lowercased()
        }
        
        self.fbManager.LoadVoiceCommands(command: "литература") { command in
            self.categories[2].categories[0].voiceCommand = command.lowercased()
        }
        
        self.fbManager.LoadVoiceCommands(command: "ПДД") { command in
            self.categories[2].categories[1].voiceCommand = command.lowercased()
        }
        
        self.fbManager.LoadVoiceCommands(command: "Swift") { command in
            self.categories[2].categories[2].voiceCommand = command.lowercased()
        }
        
        self.fbManager.LoadVoiceCommands(command: "подводный мир") { command in
            self.categories[3].categories[0].voiceCommand = command.lowercased()
        }
        
        self.fbManager.LoadVoiceCommands(command: "шахматы") { command in
            self.categories[3].categories[1].voiceCommand = command.lowercased()
        }
        
        self.fbManager.LoadVoiceCommands(command: "хэллоуин") { command in
            self.categories[4].categories[0].voiceCommand = command.lowercased()
        }
        
        self.fbManager.LoadVoiceCommands(command: "новый год") { command in
            self.categories[5].categories[0].voiceCommand = command.lowercased()
        }
    }
    
    func ShowLoading() {
        spinner.image = UIImage(named: "astronomy.png")
        view?.addSubview(spinner)
        loadingText.text = "загрузка результатов..."
        loadingText.font = UIFont.boldSystemFont(ofSize: 22.0)
        view?.addSubview(loadingText)
        makeConstraints()
        animation.StartRotateImage(image: spinner)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.LoadCategoriesResults()
            self.spinner.removeFromSuperview()
            self.loadingText.removeFromSuperview()
        }
    }
    
    private func makeConstraints() {
        spinner.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(250)
            make.height.equalTo(150)
            make.width.equalTo(150)
        }
        
        loadingText.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(spinner.snp.bottom).offset(20)
            make.height.equalTo(60)
            make.width.equalTo(250)
        }
    }
    
    func LoadCategoriesResults() {
        CreateCategories()
        for i in 0...5 {
            for value in categories[i].categories {
                configure(value)
            }
        }
    }
    
    func configure(_ category: QuizCategoryModel)  {
        
        switch category.id {
            
        case 1:
            fbManager.LoadQuizCategoriesData(quizpath: category.quizpath) { result in
                DispatchQueue.main.async {
                    self.categories[0].categories[0].score = result.score
                    self.categories[0].categories[0].complete = result.complete
                    self.categories[0].categories[0].date = result.date
                }
            }
            
            fbManager.LoadLastQuizCategoryData { quizcategory in
                if category.name == quizcategory.categoryName {
                    self.categories[0].categories[0].name = "\(category.name) (недавно)"
                }
            }
            
        case 2:
            fbManager.LoadQuizCategoriesData(quizpath: category.quizpath) { result in
                DispatchQueue.main.async {
                    self.categories[0].categories[1].score = result.score
                    self.categories[0].categories[1].complete = result.complete
                    self.categories[0].categories[1].date = result.date
                }
            }
            
            fbManager.LoadLastQuizCategoryData { quizcategory in
                if category.name == quizcategory.categoryName {
                    self.categories[0].categories[1].name = "\(category.name) (недавно)"
                }
            }
            
        case 3:
            fbManager.LoadQuizCategoriesData(quizpath: category.quizpath) { result in
                DispatchQueue.main.async {
                    self.categories[0].categories[2].score = result.score
                    self.categories[0].categories[2].complete = result.complete
                    self.categories[0].categories[2].date = result.date
                }
            }
            
            fbManager.LoadLastQuizCategoryData { quizcategory in
                if category.name == quizcategory.categoryName {
                    self.categories[0].categories[2].name = "\(category.name) (недавно)"
                }
            }
            
        case 4:
            fbManager.LoadQuizCategoriesData(quizpath: category.quizpath) { result in
                DispatchQueue.main.async {
                    self.categories[0].categories[3].score = result.score
                    self.categories[0].categories[3].complete = result.complete
                    self.categories[0].categories[3].date = result.date
                }
            }
            
            fbManager.LoadLastQuizCategoryData { quizcategory in
                if category.name == quizcategory.categoryName {
                    self.categories[0].categories[3].name = "\(category.name) (недавно)"
                }
            }
            
        case 5:
            fbManager.LoadQuizCategoriesData(quizpath: category.quizpath) { result in
                DispatchQueue.main.async {
                    self.categories[1].categories[0].score = result.score
                    self.categories[1].categories[0].complete = result.complete
                    self.categories[1].categories[0].date = result.date
                }
            }
            
            fbManager.LoadLastQuizCategoryData { quizcategory in
                if category.name == quizcategory.categoryName {
                    self.categories[1].categories[0].name = "\(category.name) (недавно)"
                }
            }
            
        case 6:
            fbManager.LoadQuizCategoriesData(quizpath: category.quizpath) { result in
                DispatchQueue.main.async {
                    self.categories[1].categories[1].score = result.score
                    self.categories[1].categories[1].complete = result.complete
                    self.categories[1].categories[1].date = result.date
                }
            }
            
            fbManager.LoadLastQuizCategoryData { quizcategory in
                if category.name == quizcategory.categoryName {
                    self.categories[1].categories[1].name = "\(category.name) (недавно)"
                }
            }
            
        case 7:
            fbManager.LoadQuizCategoriesData(quizpath: category.quizpath) { result in
                DispatchQueue.main.async {
                    self.categories[1].categories[2].score = result.score
                    self.categories[1].categories[2].complete = result.complete
                    self.categories[1].categories[2].date = result.date
                }
            }
            
            fbManager.LoadLastQuizCategoryData { quizcategory in
                if category.name == quizcategory.categoryName {
                    self.categories[1].categories[2].name = "\(category.name) (недавно)"
                }
            }
            
        case 8:
            fbManager.LoadQuizCategoriesData(quizpath: category.quizpath) { result in
                DispatchQueue.main.async {
                    self.categories[1].categories[3].score = result.score
                    self.categories[1].categories[3].complete = result.complete
                    self.categories[1].categories[3].date = result.date
                }
            }
            
            fbManager.LoadLastQuizCategoryData { quizcategory in
                if category.name == quizcategory.categoryName {
                    self.categories[1].categories[3].name = "\(category.name) (недавно)"
                }
            }
            
        case 9:
            fbManager.LoadQuizCategoriesData(quizpath: category.quizpath) { result in
                DispatchQueue.main.async {
                    self.categories[1].categories[4].score = result.score
                    self.categories[1].categories[4].complete = result.complete
                    self.categories[1].categories[4].date = result.date
                }
            }
            
            fbManager.LoadLastQuizCategoryData { quizcategory in
                if category.name == quizcategory.categoryName {
                    self.categories[1].categories[4].name = "\(category.name) (недавно)"
                }
            }
            
        case 10:
            fbManager.LoadQuizCategoriesData(quizpath: category.quizpath) { result in
                DispatchQueue.main.async {
                    self.categories[1].categories[5].score = result.score
                    self.categories[1].categories[5].complete = result.complete
                    self.categories[1].categories[5].date = result.date
                }
            }
            
            fbManager.LoadLastQuizCategoryData { quizcategory in
                if category.name == quizcategory.categoryName {
                    self.categories[1].categories[5].name = "\(category.name) (недавно)"
                }
            }
            
        case 11:
            fbManager.LoadQuizCategoriesData(quizpath: category.quizpath) { result in
                DispatchQueue.main.async {
                    self.categories[1].categories[6].score = result.score
                    self.categories[1].categories[6].complete = result.complete
                    self.categories[1].categories[6].date = result.date
                }
            }
            
            fbManager.LoadLastQuizCategoryData { quizcategory in
                if category.name == quizcategory.categoryName {
                    self.categories[1].categories[6].name = "\(category.name) (недавно)"
                }
            }
            
        case 12:
            fbManager.LoadQuizCategoriesData(quizpath: category.quizpath) { result in
                DispatchQueue.main.async {
                    self.categories[1].categories[7].score = result.score
                    self.categories[1].categories[7].complete = result.complete
                    self.categories[1].categories[7].date = result.date
                }
            }
            
            fbManager.LoadLastQuizCategoryData { quizcategory in
                if category.name == quizcategory.categoryName {
                    self.categories[1].categories[7].name = "\(category.name) (недавно)"
                }
            }
            
        case 13:
            fbManager.LoadQuizCategoriesData(quizpath: category.quizpath) { result in
                DispatchQueue.main.async {
                    self.categories[2].categories[0].score = result.score
                    self.categories[2].categories[0].complete = result.complete
                    self.categories[2].categories[0].date = result.date
                }
            }
            
            fbManager.LoadLastQuizCategoryData { quizcategory in
                if category.name == quizcategory.categoryName {
                    self.categories[2].categories[0].name = "\(category.name) (недавно)"
                }
            }
            
        case 14:
            fbManager.LoadQuizCategoriesData(quizpath: category.quizpath) { result in
                DispatchQueue.main.async {
                    self.categories[2].categories[1].score = result.score
                    self.categories[2].categories[1].complete = result.complete
                    self.categories[2].categories[1].date = result.date
                }
            }
            
            fbManager.LoadLastQuizCategoryData { quizcategory in
                if category.name == quizcategory.categoryName {
                    self.categories[2].categories[1].name = "\(category.name) (недавно)"
                }
            }
            
        case 15:
            fbManager.LoadQuizCategoriesData(quizpath: category.quizpath) { result in
                DispatchQueue.main.async {
                    self.categories[2].categories[2].score = result.score
                    self.categories[2].categories[2].complete = result.complete
                    self.categories[2].categories[2].date = result.date
                }
            }
            
            fbManager.LoadLastQuizCategoryData { quizcategory in
                if category.name == quizcategory.categoryName {
                    self.categories[2].categories[2].name = "\(category.name) (недавно)"
                }
            }
            
        case 16:
            fbManager.LoadQuizCategoriesData(quizpath: category.quizpath) { result in
                DispatchQueue.main.async {
                    self.categories[3].categories[0].score = result.score
                    self.categories[3].categories[0].complete = result.complete
                    self.categories[3].categories[0].date = result.date
                }
            }
            
            fbManager.LoadLastQuizCategoryData { quizcategory in
                if category.name == quizcategory.categoryName {
                    self.categories[3].categories[0].name = "\(category.name) (недавно)"
                }
            }
            
        case 17:
            fbManager.LoadQuizCategoriesData(quizpath: category.quizpath) { result in
                DispatchQueue.main.async {
                    self.categories[3].categories[1].score = result.score
                    self.categories[3].categories[1].complete = result.complete
                    self.categories[3].categories[1].date = result.date
                }
            }
            
            fbManager.LoadLastQuizCategoryData { quizcategory in
                if category.name == quizcategory.categoryName {
                    self.categories[3].categories[1].name = "\(category.name) (недавно)"
                }
            }
            
        case 18:
            fbManager.LoadQuizCategoriesData(quizpath: category.quizpath) { result in
                DispatchQueue.main.async {
                    self.categories[4].categories[0].score = result.score
                    self.categories[4].categories[0].complete = result.complete
                    self.categories[4].categories[0].date = result.date
                }
            }
            
            fbManager.LoadLastQuizCategoryData { quizcategory in
                if category.name == quizcategory.categoryName {
                    self.categories[4].categories[0].name = "\(category.name) (недавно)"
                }
            }
            
        case 19:
            fbManager.LoadQuizCategoriesData(quizpath: category.quizpath) { result in
                DispatchQueue.main.async {
                    self.categories[5].categories[0].score = result.score
                    self.categories[5].categories[0].complete = result.complete
                    self.categories[5].categories[0].date = result.date
                }
            }
            
            fbManager.LoadLastQuizCategoryData { quizcategory in
                if category.name == quizcategory.categoryName {
                    self.categories[5].categories[0].name = "\(category.name) (недавно)"
                }
            }
            
        default:
            break
        }
    }
    
    func GoToQuiz(quiz: QuizBaseViewModel, category: QuizCategoryModel) {
        DispatchQueue.main.async {
            guard let vc = self.storyboard?.instantiateViewController(identifier: "QuizBaseViewController") else {return}
            (vc as? QuizBaseViewController)?.quiz = quiz
            (vc as? QuizBaseViewController)?.category = category
            guard let window = self.view?.window else {return}
            window.rootViewController = vc
        }
    }
    
    func GoToStart(quiz: QuizBaseViewModel, category: QuizCategoryModel) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            guard let vc = self.storyboard?.instantiateViewController(identifier: "QuizStartViewController") else {return}
            (vc as? QuizStartViewController)?.category = category
            guard let window = self.view?.window else {return}
            window.rootViewController = vc
        }
    }
    
    func PresentRandomQuiz() {
        DispatchQueue.main.async {
            let randomquizindex = Int.random(in: 0..<self.quizcategories.count)
            let randomquiz = self.quizcategories[randomquizindex]
            self.GoToStart(quiz: randomquiz.base, category: randomquiz)
        }
    }
    
    func CheckText(image: UIImage) {
        textRecognitionManager.recognizeText(image: image) { text in
            for i in 0...5 {
                for value in self.categories[i].categories {
                    if text.lowercased().contains(value.name) {
                        self.GoToStart(quiz: value.base, category: value)
                    }
                }
            }
        }
    }
}
