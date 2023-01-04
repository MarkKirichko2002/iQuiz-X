//
//  CategoriesViewModel.swift
//  QUIZ
//
//  Created by Марк Киричко on 02.07.2022.
//

import Foundation
import UIKit
import Combine
import SnapKit

class CategoriesViewModel {
    
    private var quizes = [QuizPlanets(), QuizHistory(), QuizAnatomy(), QuizSport(), QuizGames(), QuizIQ(), QuizEconomy(), QuizGeography(), QuizEcology(), QuizPhysics(), QuizChemistry(), QuizInformatics(), QuizLiterature(), QuizRoadTraffic(), QuizSwift(), QuizUnderwater(), QuizChess(), QuizHalloween(), QuizNewYear()]
    var view: UIView?
    var storyboard: UIStoryboard?
    private let fbManager = FirebaseManager()
    private let spinner = RoundedImageView()
    private let loadingText = UILabel()
    private let animation = AnimationClass()
    private let textRecognitionManager = TextRecognitionManager()
    @Published var categories = [Quiz]()
    
    var quizcategories = [QuizCategoryModel(name: "астрономия", image: "planets.jpeg", base: QuizPlanets(), voiceCommand: "планет", background: "earth.background.jpeg", complete: false, id: 1, score: 0, sound: "space.wav", music: "space music.mp3"), QuizCategoryModel(name: "история", image: "history.jpeg", base: QuizHistory(), voiceCommand: "истори", background: "history.background.jpeg", complete: false, id: 2, score: 0, sound: "history.wav", music: "history music.mp3"), QuizCategoryModel(name: "анатомия", image: "anatomy.jpeg", base: QuizAnatomy(), voiceCommand:"анатоми", background: "anatomy.background.jpeg", complete: false, id: 3, score: 0, sound: "anatomy.mp3", music: "anatomy music.mp3"), QuizCategoryModel(name: "спорт", image: "sport.jpeg", base: QuizSport(), voiceCommand: "спорт", background: "sport.background.jpeg", complete: false, id: 4, score: 0, sound: "sport.wav", music: "sport music.mp3"), QuizCategoryModel(name: "игры", image: "games.jpeg", base: QuizGames(), voiceCommand: "игр", background: "games.background.jpeg", complete: false, id: 5, score: 0, sound: "games.mp3", music: "games music.mp3"), QuizCategoryModel(name: "IQ", image: "IQ.jpeg", base: QuizIQ(), voiceCommand: "интеллект", background: "IQ.background.jpeg", complete: false, id: 6, score: 0, sound: "IQ.mp3", music: "IQ music.mp3"), QuizCategoryModel(name: "экономика", image: "economy.jpeg", base: QuizEconomy(), voiceCommand: "экономика", background: "economy.background.jpeg", complete: false, id: 7, score: 0, sound: "economics.mp3", music: "economy music.mp3"), QuizCategoryModel(name: "география", image: "geography.jpeg", base: QuizGeography(), voiceCommand: "географи", background: "geography.background.jpeg", complete: false, id: 8, score: 0, sound: "geography.mp3", music: "geography music.mp3"), QuizCategoryModel(name: "экология", image: "ecology.jpeg", base: QuizEcology(), voiceCommand: "экологи", background: "ecology.background.jpeg", complete: false, id: 9, score: 0, sound: "ecology.wav", music: "ecology music.mp3"), QuizCategoryModel(name: "физика", image: "physics.jpeg", base: QuizPhysics(), voiceCommand: "физ", background: "physics.background.jpeg", complete: false, id: 10, score: 0, sound: "physics.mp3", music: "physics music.mp3"), QuizCategoryModel(name: "химия", image: "chemistry.jpeg", base: QuizChemistry(), voiceCommand: "хим", background: "chemistry.background.jpeg", complete: false, id: 11, score: 0, sound: "chemistry.mp3", music: "chemistry music.mp3"), QuizCategoryModel(name: "информатика", image: "informatics.jpeg", base: QuizInformatics(), voiceCommand: "информа", background: "informatics.background.jpeg", complete: false, id: 12, score: 0, sound: "informatics.mp3", music: "informatics music.mp3"), QuizCategoryModel(name: "литература", image: "literature.jpeg", base: QuizLiterature(), voiceCommand: "литера", background: "literature.background.jpeg", complete: false, id: 13, score: 0, sound: "literature.mp3", music: "literature music.mp3"), QuizCategoryModel(name: "ПДД", image: "drive.jpeg", base: QuizRoadTraffic(), voiceCommand: "дорог", background: "drive.background.jpeg", complete: false, id: 14, score: 0, sound: "roadtraffic.mp3", music: "drive music.mp3"), QuizCategoryModel(name: "Swift", image: "swift.jpeg", base: QuizSwift(), voiceCommand: "swift", background:"swift.background.jpeg", complete: false, id: 15, score: 0, sound: "swift.mp3", music: "Swift music.mp3"), QuizCategoryModel(name: "подводный мир", image: "underwater.png", base: QuizUnderwater(), voiceCommand: "мор", background: "underwater.background.jpeg", complete: false, id: 16, score: 0, sound: "underwater.wav", music: "underwater music.mp3"), QuizCategoryModel(name: "шахматы", image: "chess.png", base: QuizChess(), voiceCommand: "шахмат", background: "chess.background.jpeg", complete: false, id: 17, score: 0, sound: "chess.mp3", music: "chess music.mp3"), QuizCategoryModel(name: "хэллоуин", image: "halloween.png", base: QuizHalloween(), voiceCommand: "halloween", background: "halloween.background.jpeg", complete: false, id: 18, score: 0, sound: "halloween.wav", music: "halloween music.mp3"), QuizCategoryModel(name: "новый год", image: "newyear.png", base: QuizNewYear(), voiceCommand: "рождеств", background: "newyear.background.jpeg", complete: false, id: 19, score: 0, sound: "newyear.mp3", music: "newyear music.mp3")]
    
    func CreateCategories() {
        categories = [Quiz(releaseDate: "февраль 2022", categories: [QuizCategoryModel(name: "астрономия", image: "planets.jpeg", base: QuizPlanets(), voiceCommand: "планет", background: "earth.background.jpeg", complete: false, id: 1, score: 0, sound: "space.wav", music: "space music.mp3"), QuizCategoryModel(name: "история", image: "history.jpeg", base: QuizHistory(), voiceCommand: "истори", background: "history.background.jpeg", complete: false, id: 2, score: 0, sound: "history.wav", music: "history music.mp3"), QuizCategoryModel(name: "анатомия", image: "anatomy.jpeg", base: QuizAnatomy(), voiceCommand:"анатоми", background: "anatomy.background.jpeg", complete: false, id: 3, score: 0, sound: "anatomy.mp3", music: "anatomy music.mp3"), QuizCategoryModel(name: "спорт", image: "sport.jpeg", base: QuizSport(), voiceCommand: "спорт", background: "sport.background.jpeg", complete: false, id: 4, score: 0, sound: "sport.wav", music: "sport music.mp3")]), Quiz(releaseDate: "март 2022", categories: [QuizCategoryModel(name: "игры", image: "games.jpeg", base: QuizGames(), voiceCommand: "игр", background: "games.background.jpeg", complete: false, id: 5, score: 0, sound: "games.mp3", music: "games music.mp3"), QuizCategoryModel(name: "IQ", image: "IQ.jpeg", base: QuizIQ(), voiceCommand: "интеллект", background: "IQ.background.jpeg", complete: false, id: 6, score: 0, sound: "IQ.mp3", music: "IQ music.mp3"), QuizCategoryModel(name: "экономика", image: "economy.jpeg", base: QuizEconomy(), voiceCommand: "эконом", background: "economy.background.jpeg", complete: false, id: 7, score: 0, sound: "economics.mp3", music: "economy music.mp3"), QuizCategoryModel(name: "география", image: "geography.jpeg", base: QuizGeography(), voiceCommand: "географи", background: "geography.background.jpeg", complete: false, id: 8, score: 0, sound: "geography.mp3", music: "geography music.mp3"), QuizCategoryModel(name: "экология", image: "ecology.jpeg", base: QuizEcology(), voiceCommand: "экологи", background: "ecology.background.jpeg", complete: false, id: 9, score: 0, sound: "ecology.wav", music: "ecology music.mp3"), QuizCategoryModel(name: "физика", image: "physics.jpeg", base: QuizPhysics(), voiceCommand: "физ", background: "physics.background.jpeg", complete: false, id: 10, score: 0, sound: "physics.mp3", music: "physics music.mp3"), QuizCategoryModel(name: "химия", image: "chemistry.jpeg", base: QuizChemistry(), voiceCommand: "хим", background: "chemistry.background.jpeg", complete: false, id: 11, score: 0, sound: "chemistry.mp3", music: "chemistry music.mp3"), QuizCategoryModel(name: "информатика", image: "informatics.jpeg", base: QuizInformatics(), voiceCommand: "информа", background: "informatics.background.jpeg", complete: false, id: 12, score: 0, sound: "informatics.mp3", music: "informatics music.mp3")]), Quiz(releaseDate: "апрель 2022", categories: [QuizCategoryModel(name: "литература", image: "literature.jpeg", base: QuizLiterature(), voiceCommand: "литера", background: "literature.background.jpeg", complete: false, id: 13, score: 0, sound: "literature.mp3", music: "literature music.mp3"), QuizCategoryModel(name: "ПДД", image: "drive.jpeg", base: QuizRoadTraffic(), voiceCommand: "дорог", background: "drive.background.jpeg", complete: false, id: 14, score: 0, sound: "roadtraffic.mp3", music: "drive music.mp3"), QuizCategoryModel(name: "Swift", image: "swift.jpeg", base: QuizSwift(), voiceCommand: "swift", background:"swift.background.jpeg", complete: false, id: 15, score: 0, sound: "swift.mp3", music: "Swift music.mp3")]), Quiz(releaseDate: "июль 2022", categories: [QuizCategoryModel(name: "подводный мир", image: "underwater.png", base: QuizUnderwater(), voiceCommand: "мор", background: "underwater.background.jpeg", complete: false, id: 16, score: 0, sound: "underwater.wav", music: "underwater music.mp3"), QuizCategoryModel(name: "шахматы", image: "chess.png", base: QuizChess(), voiceCommand: "шахмат", background: "chess.background.jpeg", complete: false, id: 17, score: 0, sound: "chess.mp3", music: "chess music.mp3")]), Quiz(releaseDate: "октябрь 2022", categories: [QuizCategoryModel(name: "хэллоуин", image: "halloween.png", base: QuizHalloween(), voiceCommand: "halloween", background: "halloween.background.jpeg", complete: false, id: 18, score: 0, sound: "halloween.wav", music: "halloween music.mp3")]), Quiz(releaseDate: "декабрь 2022", categories: [QuizCategoryModel(name: "новый год", image: "newyear.png", base: QuizNewYear(), voiceCommand: "рождеств", background: "newyear.background.jpeg", complete: false, id: 19, score: 0, sound: "newyear.mp3", music: "newyear music.mp3")])]
        
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
        spinner.image = UIImage(named: "newyear.png")
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
            fbManager.LoadQuizCategoriesData(quizpath: "quizplanets") { result in
                DispatchQueue.main.async {
                    self.categories[0].categories[0].score = result.score
                    self.categories[0].categories[0].complete = result.complete
                }
            }
            
        case 2:
            fbManager.LoadQuizCategoriesData(quizpath: "quizhistory") { result in
                DispatchQueue.main.async {
                    self.categories[0].categories[1].score = result.score
                    self.categories[0].categories[1].complete = result.complete
                }
            }
            
        case 3:
            fbManager.LoadQuizCategoriesData(quizpath: "quizanatomy") { result in
                DispatchQueue.main.async {
                    self.categories[0].categories[2].score = result.score
                    self.categories[0].categories[2].complete = result.complete
                }
            }
            
            
        case 4:
            fbManager.LoadQuizCategoriesData(quizpath: "quizsport") { result in
                DispatchQueue.main.async {
                    self.categories[0].categories[3].score = result.score
                    self.categories[0].categories[3].complete = result.complete
                }
            }
            
        case 5:
            fbManager.LoadQuizCategoriesData(quizpath: "quizgames") { result in
                DispatchQueue.main.async {
                    self.categories[1].categories[0].score = result.score
                    self.categories[1].categories[0].complete = result.complete
                }
            }
            
        case 6:
            fbManager.LoadQuizCategoriesData(quizpath: "quiziq") { result in
                DispatchQueue.main.async {
                    self.categories[1].categories[1].score = result.score
                    self.categories[1].categories[1].complete = result.complete
                }
            }
            
        case 7:
            fbManager.LoadQuizCategoriesData(quizpath: "quizeconomy") { result in
                DispatchQueue.main.async {
                    self.categories[1].categories[2].score = result.score
                    self.categories[1].categories[2].complete = result.complete
                }
            }
            
        case 8:
            fbManager.LoadQuizCategoriesData(quizpath: "quizgeography") { result in
                DispatchQueue.main.async {
                    self.categories[1].categories[3].score = result.score
                    self.categories[1].categories[3].complete = result.complete
                }
            }
            
        case 9:
            fbManager.LoadQuizCategoriesData(quizpath: "quizecology") { result in
                DispatchQueue.main.async {
                    self.categories[1].categories[4].score = result.score
                    self.categories[1].categories[4].complete = result.complete
                }
            }
            
        case 10:
            fbManager.LoadQuizCategoriesData(quizpath: "quizphysics") { result in
                DispatchQueue.main.async {
                    self.categories[1].categories[5].score = result.score
                    self.categories[1].categories[5].complete = result.complete
                }
            }
            
        case 11:
            fbManager.LoadQuizCategoriesData(quizpath: "quizchemistry") { result in
                DispatchQueue.main.async {
                    self.categories[1].categories[6].score = result.score
                    self.categories[1].categories[6].complete = result.complete
                }
            }
            
        case 12:
            fbManager.LoadQuizCategoriesData(quizpath: "quizinformatics") { result in
                DispatchQueue.main.async {
                    self.categories[1].categories[7].score = result.score
                    self.categories[1].categories[7].complete = result.complete
                }
            }
            
        case 13:
            fbManager.LoadQuizCategoriesData(quizpath: "quizliterature") { result in
                DispatchQueue.main.async {
                    self.categories[2].categories[0].score = result.score
                    self.categories[2].categories[0].complete = result.complete
                }
            }
            
        case 14:
            fbManager.LoadQuizCategoriesData(quizpath: "quizroadtraffic") { result in
                DispatchQueue.main.async {
                    self.categories[2].categories[1].score = result.score
                    self.categories[2].categories[1].complete = result.complete
                }
            }
            
        case 15:
            fbManager.LoadQuizCategoriesData(quizpath: "quizswift") { result in
                DispatchQueue.main.async {
                    self.categories[2].categories[2].score = result.score
                    self.categories[2].categories[2].complete = result.complete
                }
            }
            
        case 16:
            fbManager.LoadQuizCategoriesData(quizpath: "quizunderwater") { result in
                DispatchQueue.main.async {
                    self.categories[3].categories[0].score = result.score
                    self.categories[3].categories[0].complete = result.complete
                }
            }
            
        case 17:
            fbManager.LoadQuizCategoriesData(quizpath: "quizchess") { result in
                DispatchQueue.main.async {
                    self.categories[3].categories[1].score = result.score
                    self.categories[3].categories[1].complete = result.complete
                }
            }
            
        case 18:
            fbManager.LoadQuizCategoriesData(quizpath: "quizhalloween") { result in
                DispatchQueue.main.async {
                    self.categories[4].categories[0].score = result.score
                    self.categories[4].categories[0].complete = result.complete
                }
            }
            
        case 19:
            fbManager.LoadQuizCategoriesData(quizpath: "quiznewyear") { result in
                DispatchQueue.main.async {
                    self.categories[5].categories[0].score = result.score
                    self.categories[5].categories[0].complete = result.complete
                }
            }
            
        default:
            break
        }
        
    }
    
    func goToQuize(quiz: QuizBaseViewModel, category: QuizCategoryModel) {
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
            (vc as? QuizStartViewController)?.base = quiz
            (vc as? QuizStartViewController)?.category = category
            guard let window = self.view?.window else {return}
            window.rootViewController = vc
        }
    }
    
    func PresentRandomQuiz() {
        DispatchQueue.main.async {
            let randomquizindex = Int.random(in: 0..<self.quizes.count)
            let randomquiz = self.quizes[randomquizindex]
            self.GoToStart(quiz: randomquiz, category: self.quizcategories[randomquizindex])
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
