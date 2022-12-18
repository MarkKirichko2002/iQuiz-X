//
//  CategoriesViewModel.swift
//  QUIZ
//
//  Created by Марк Киричко on 02.07.2022.
//

import Foundation
import UIKit
import Vision
import Combine
import SnapKit

class CategoriesViewModel {
    
    private var quizes = [QuizPlanets(), QuizHistory(), QuizAnatomy(), QuizSport(), QuizGames(), QuizIQ(), QuizEconomy(), QuizGeography(), QuizEcology(), QuizPhysics(), QuizChemistry(), QuizInformatics(), QuizLiterature(), QuizRoadTraffic(), QuizSwift(), QuizUnderwater(), QuizChess(), QuizHalloween(), QuizNewYear()]
    var view: UIView?
    var storyboard: UIStoryboard?
    private var fbManager = FBManager()
    private var spinner = RoundedImageView()
    private var loadingText = UILabel()
    private var animation = AnimationClass()
    
    @Published var categories = [Quiz]()
    
    var quizcategories = [QuizModel(name: "планеты", image: "planets.jpeg", base: QuizPlanets(), background: "earth.background.jpeg", complete: false, id: 1, score: 0, sound: "space.wav", music: "space music.mp3"), QuizModel(name: "история", image: "history.jpeg", base: QuizHistory(), background: "history.background.jpeg", complete: false, id: 2, score: 0, sound: "history.wav", music: "history music.mp3"), QuizModel(name: "анатомия", image: "anatomy.jpeg", base: QuizAnatomy(), background: "anatomy.background.jpeg", complete: false, id: 3, score: 0, sound: "anatomy.mp3", music: "anatomy music.mp3"), QuizModel(name: "спорт", image: "sport.jpeg", base: QuizSport(), background: "sport.background.jpeg", complete: false, id: 4, score: 0, sound: "sport.wav", music: "sport music.mp3"), QuizModel(name: "игры", image: "games.jpeg", base: QuizGames(), background: "games.background.jpeg", complete: false, id: 5, score: 0, sound: "games.mp3", music: "games music.mp3"), QuizModel(name: "IQ", image: "IQ.jpeg", base: QuizIQ(), background: "IQ.background.jpeg", complete: false, id: 6, score: 0, sound: "IQ.mp3", music: "IQ music.mp3"), QuizModel(name: "экономика", image: "economy.jpeg", base: QuizEconomy(), background: "economy.background.jpeg", complete: false, id: 7, score: 0, sound: "economics.mp3", music: "economy music.mp3"), QuizModel(name: "география", image: "geography.jpeg", base: QuizGeography(), background: "geography.background.jpeg", complete: false, id: 8, score: 0, sound: "geography.mp3", music: "geography music.mp3"), QuizModel(name: "экология", image: "ecology.jpeg", base: QuizEcology(), background: "ecology.background.jpeg", complete: false, id: 9, score: 0, sound: "ecology.wav", music: "ecology music.mp3"), QuizModel(name: "физика", image: "physics.jpeg", base: QuizPhysics(), background: "physics.background.jpeg", complete: false, id: 10, score: 0, sound: "physics.mp3", music: "physics music.mp3"), QuizModel(name: "химия", image: "chemistry.jpeg", base: QuizChemistry(), background: "chemistry.background.jpeg", complete: false, id: 11, score: 0, sound: "chemistry.mp3", music: "chemistry music.mp3"), QuizModel(name: "информатика", image: "informatics.jpeg", base: QuizInformatics(), background: "informatics.background.jpeg", complete: false, id: 12, score: 0, sound: "informatics.mp3", music: "informatics music.mp3"), QuizModel(name: "литература", image: "literature.jpeg", base: QuizLiterature(), background: "literature.background.jpeg", complete: false, id: 13, score: 0, sound: "literature.mp3", music: "literature music.mp3"), QuizModel(name: "ПДД", image: "drive.jpeg", base: QuizRoadTraffic(), background: "drive.background.jpeg", complete: false, id: 14, score: 0, sound: "roadtraffic.mp3", music: "drive music.mp3"), QuizModel(name: "Swift", image: "swift.jpeg", base: QuizSwift(), background:"swift.background.jpeg", complete: false, id: 15, score: 0, sound: "swift.mp3", music: "Swift music.mp3"), QuizModel(name: "подводный мир", image: "underwater.png", base: QuizUnderwater(), background: "underwater.background.jpeg", complete: false, id: 16, score: 0, sound: "underwater.wav", music: "underwater music.mp3"), QuizModel(name: "шахматы", image: "chess.png", base: QuizChess(), background: "chess.background.jpeg", complete: false, id: 17, score: 0, sound: "chess.mp3", music: "chess music.mp3"), QuizModel(name: "хэллоуин", image: "halloween.png", base: QuizHalloween(), background: "halloween.background.jpeg", complete: false, id: 18, score: 0, sound: "halloween.wav", music: "halloween music.mp3"), QuizModel(name: "новый год", image: "newyear.png", base: QuizNewYear(), background: "newyear.background.jpeg", complete: false, id: 19, score: 0, sound: "newyear.mp3", music: "newyear music.mp3")]
    
    func CreateCategories() {
        categories = [Quiz(releaseDate: "февраль 2022", categories: [QuizModel(name: "планеты", image: "planets.jpeg", base: QuizPlanets(), background: "earth.background.jpeg", complete: false, id: 1, score: 0, sound: "space.wav", music: "space music.mp3"), QuizModel(name: "история", image: "history.jpeg", base: QuizHistory(), background: "history.background.jpeg", complete: false, id: 2, score: 0, sound: "history.wav", music: "history music.mp3"), QuizModel(name: "анатомия", image: "anatomy.jpeg", base: QuizAnatomy(), background: "anatomy.background.jpeg", complete: false, id: 3, score: 0, sound: "anatomy.mp3", music: "anatomy music.mp3"), QuizModel(name: "спорт", image: "sport.jpeg", base: QuizSport(), background: "sport.background.jpeg", complete: false, id: 4, score: 0, sound: "sport.wav", music: "sport music.mp3")]), Quiz(releaseDate: "март 2022", categories: [QuizModel(name: "игры", image: "games.jpeg", base: QuizGames(), background: "games.background.jpeg", complete: false, id: 5, score: 0, sound: "games.mp3", music: "games music.mp3"), QuizModel(name: "IQ", image: "IQ.jpeg", base: QuizIQ(), background: "IQ.background.jpeg", complete: false, id: 6, score: 0, sound: "IQ.mp3", music: "IQ music.mp3"), QuizModel(name: "экономика", image: "economy.jpeg", base: QuizEconomy(), background: "economy.background.jpeg", complete: false, id: 7, score: 0, sound: "economics.mp3", music: "economy music.mp3"), QuizModel(name: "география", image: "geography.jpeg", base: QuizGeography(), background: "geography.background.jpeg", complete: false, id: 8, score: 0, sound: "geography.mp3", music: "geography music.mp3"), QuizModel(name: "экология", image: "ecology.jpeg", base: QuizEcology(), background: "ecology.background.jpeg", complete: false, id: 9, score: 0, sound: "ecology.wav", music: "ecology music.mp3"), QuizModel(name: "физика", image: "physics.jpeg", base: QuizPhysics(), background: "physics.background.jpeg", complete: false, id: 10, score: 0, sound: "physics.mp3", music: "physics music.mp3"), QuizModel(name: "химия", image: "chemistry.jpeg", base: QuizChemistry(), background: "chemistry.background.jpeg", complete: false, id: 11, score: 0, sound: "chemistry.mp3", music: "chemistry music.mp3"), QuizModel(name: "информатика", image: "informatics.jpeg", base: QuizInformatics(), background: "informatics.background.jpeg", complete: false, id: 12, score: 0, sound: "informatics.mp3", music: "informatics music.mp3")]), Quiz(releaseDate: "апрель 2022", categories: [QuizModel(name: "литература", image: "literature.jpeg", base: QuizLiterature(), background: "literature.background.jpeg", complete: false, id: 13, score: 0, sound: "literature.mp3", music: "literature music.mp3"), QuizModel(name: "ПДД", image: "drive.jpeg", base: QuizRoadTraffic(), background: "drive.background.jpeg", complete: false, id: 14, score: 0, sound: "roadtraffic.mp3", music: "drive music.mp3"), QuizModel(name: "Swift", image: "swift.jpeg", base: QuizSwift(), background:"swift.background.jpeg", complete: false, id: 15, score: 0, sound: "swift.mp3", music: "Swift music.mp3")]), Quiz(releaseDate: "июль 2022", categories: [QuizModel(name: "подводный мир", image: "underwater.png", base: QuizUnderwater(), background: "underwater.background.jpeg", complete: false, id: 16, score: 0, sound: "underwater.wav", music: "underwater music.mp3"), QuizModel(name: "шахматы", image: "chess.png", base: QuizChess(), background: "chess.background.jpeg", complete: false, id: 17, score: 0, sound: "chess.mp3", music: "chess music.mp3")]), Quiz(releaseDate: "октябрь 2022", categories: [QuizModel(name: "хэллоуин", image: "halloween.png", base: QuizHalloween(), background: "halloween.background.jpeg", complete: false, id: 18, score: 0, sound: "halloween.wav", music: "halloween music.mp3")]), Quiz(releaseDate: "декабрь 2022", categories: [QuizModel(name: "новый год", image: "newyear.png", base: QuizNewYear(), background: "newyear.background.jpeg", complete: false, id: 19, score: 0, sound: "newyear.mp3", music: "newyear music.mp3")])]
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
            self.LoadResults()
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
    
    func LoadResults() {
        CreateCategories()
        for i in 0...5 {
            for value in categories[i].categories {
                configure(value)
            }
        }
    }
    
    func configure(_ category: QuizModel)  {
        
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
    
    func goToQuize(quiz: QuizBaseViewModel, category: QuizModel) {
        DispatchQueue.main.async {
            guard let vc = self.storyboard?.instantiateViewController(identifier: "BaseQuizViewController") else {return}
            (vc as? BaseQuizViewController)?.quiz = quiz
            (vc as? BaseQuizViewController)?.category = category
            guard let window = self.view?.window else {return}
            window.rootViewController = vc
        }
    }
    
    func GoToStart(quiz: QuizBaseViewModel, category: QuizModel) {
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
    
    func recognizeText(image: UIImage?) {
        guard let cgImage = image?.cgImage else {
            return
        }
        
        // Handler
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        
        // Request
        let request = VNRecognizeTextRequest { [weak self] request,error in
            guard let observations = request.results as? [VNRecognizedTextObservation],
                  error == nil else {
                return
            }
            
            let text = observations.compactMap({
                $0.topCandidates(1).first?.string
            }).joined(separator: " ")
            
            switch text {
                
            case _ where text.contains("Планеты"):
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self?.goToQuize(quiz: QuizPlanets(), category: (self?.categories[0].categories[0])!)
                }
                
            case _ where text.contains("История"):
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self?.goToQuize(quiz: QuizHistory(), category: (self?.categories[0].categories[1])!)
                }
                
            case _ where text.contains("Анатомия"):
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self?.goToQuize(quiz: QuizAnatomy(), category: (self?.categories[0].categories[2])!)
                }
                
            case _ where text.contains("Спорт"):
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self?.goToQuize(quiz: QuizSport(), category: (self?.categories[0].categories[3])!)
                }
                
            case _ where text.contains("Игры"):
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self?.goToQuize(quiz: QuizGames(), category: (self?.categories[1].categories[0])!)
                }
                
            case _ where text.contains("IQ"):
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self?.goToQuize(quiz: QuizIQ(), category: (self?.categories[1].categories[1])!)
                }
                
            case _ where text.contains("Экономика"):
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self?.goToQuize(quiz: QuizEconomy(), category: (self?.categories[1].categories[2])!)
                }
                
            case _ where text.contains("География"):
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self?.goToQuize(quiz: QuizGeography(), category: (self?.categories[1].categories[3])!)
                }
                
            case _ where text.contains("Экология"):
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self?.goToQuize(quiz: QuizEcology(), category: (self?.categories[1].categories[4])!)
                }
                
            case _ where text.contains("Физика"):
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self?.goToQuize(quiz: QuizPhysics(), category: (self?.categories[1].categories[5])!)
                }
                
            case _ where text.contains("Химия"):
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self?.goToQuize(quiz: QuizChemistry(), category: (self?.categories[1].categories[6])!)
                }
                
            case _ where text.contains("Информатика"):
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self?.goToQuize(quiz: QuizInformatics(), category: (self?.categories[1].categories[7])!)
                }
                
            case _ where text.contains("Литература"):
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self?.goToQuize(quiz: QuizLiterature(), category: (self?.categories[2].categories[0])!)
                }
                
            case _ where text.contains("ПДД"):
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self?.goToQuize(quiz: QuizRoadTraffic(), category: (self?.categories[2].categories[1])!)
                }
                
            case _ where text.contains("Swift"):
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self?.goToQuize(quiz: QuizSwift(), category: (self?.categories[2].categories[2])!)
                }
                
            case _ where text.contains("Подводный мир"):
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self?.goToQuize(quiz: QuizUnderwater(), category: (self?.categories[3].categories[0])!)
                }
                
            case _ where text.contains("Шахматы"):
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self?.goToQuize(quiz: QuizChess(), category: (self?.categories[3].categories[1])!)
                }
                
            case _ where text.contains("Хэллоуин"):
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self?.goToQuize(quiz: QuizHalloween(), category: (self?.categories[4].categories[0])!)
                }
                
            case _ where text.contains("Рождество"):
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self?.goToQuize(quiz: QuizHalloween(), category: (self?.categories[5].categories[0])!)
                }
                
            case _ where text.contains("19"):
                self?.PresentRandomQuiz()
                
            default:
                break
                
            }
        }
        
        do {
            try handler.perform([request])
        } catch {
            print(error)
        }
    }
}
