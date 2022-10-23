//
//  CategoriesViewModel.swift
//  QUIZ
//
//  Created by Марк Киричко on 02.07.2022.
//

import Foundation
import UIKit

class CategoriesViewModel {
    
    var quizes = [QuizPlanets(), QuizHistory(), QuizAnatomy(), QuizSport(), QuizGames(), QuizIQ(), QuizEconomy(), QuizGeography(), QuizEcology(), QuizPhysics(), QuizChemistry(), QuizInformatics(), QuizLiterature(), QuizRoadTraffic(), QuizSwift(), QuizUnderwater(), QuizChess()]
    
    var categories = [QuizModel(name: "планеты", image: "planets.jpeg", complete: false, id: 1, score: 0), QuizModel(name: "история", image: "history.jpeg", complete: false, id: 2, score: 0), QuizModel(name: "анатомия", image: "anatomy.jpeg", complete: false, id: 3, score: 0), QuizModel(name: "спорт", image: "sport.jpeg", complete: false, id: 4, score: 0), QuizModel(name: "игры", image: "games.jpeg", complete: false, id: 5, score: 0), QuizModel(name: "IQ", image: "IQ.jpeg", complete: false, id: 6, score: 0),
        QuizModel(name: "экономика", image: "economy.jpeg", complete: false, id: 7, score: 0),
        QuizModel(name: "география", image: "geography.jpeg", complete: false, id: 8, score: 0),
        QuizModel(name: "экология", image: "ecology.jpeg", complete: false, id: 9, score: 0),
        QuizModel(name: "физика", image: "physics.jpeg", complete: false, id: 10, score: 0),
        QuizModel(name: "химия", image: "chemistry.jpeg", complete: false, id: 11, score: 0),
        QuizModel(name: "информатика", image: "informatics.jpeg", complete: false, id: 12, score: 0),
        QuizModel(name: "литература", image: "literature.jpeg", complete: false, id: 13, score: 0),
        QuizModel(name: "ПДД", image: "drive.jpeg", complete: false, id: 14, score: 0),
        QuizModel(name: "Swift", image: "swift.jpeg", complete: false, id: 15, score: 0),
        QuizModel(name: "подводный мир", image: "underwater.png", complete: false, id: 16, score: 0),
        QuizModel(name: "шахматы", image: "chess.png", complete: false, id: 17, score: 0),
                      QuizModel(name: "хэллоуин", image: "halloween.png", complete: false, id: 18, score: 0),
        QuizModel(name: "рандом", image: "random.jpeg", complete: false, id: 19, score: 0)]
    
    func goToQuize(quiz: QuizBaseViewModel, category: QuizModel, storyboard: UIStoryboard?, view: UIView) {
        DispatchQueue.main.async {
            guard let vc = storyboard?.instantiateViewController(identifier: "BaseQuizViewController") else {return}
            (vc as? BaseQuizViewController)?.quiz = quiz
            (vc as? BaseQuizViewController)?.category = category
            guard let window = view.window else {return}
            window.rootViewController = vc
        }
    }
    
    func GoToStart(quiz: QuizBaseViewModel, category: QuizModel, storyboard: UIStoryboard?, view: UIView) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            guard let vc = storyboard?.instantiateViewController(identifier: "QuizStartViewController") else {return}
            (vc as? QuizStartViewController)?.base = quiz
            (vc as? QuizStartViewController)?.category = category
            guard let window = view.window else {return}
            window.rootViewController = vc
        }
    }
    
    func PresentRandomQuiz(storyboard: UIStoryboard?, view: UIView) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let randomquizindex = Int.random(in: 0..<self.quizes.count)
            let randomquiz = self.quizes[randomquizindex]
            self.goToQuize(quiz: randomquiz, category: self.categories[randomquizindex], storyboard: storyboard, view: view)
        }
    }
    
}
