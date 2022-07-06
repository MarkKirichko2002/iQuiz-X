//
//  QuizChess.swift
//  QUIZ
//
//  Created by Марк Киричко on 04.07.2022.
//

import Foundation

class QuizChess: QuizBase {
    
    override func ids() -> [QuizModel] {
        return [QuizModel(name: "шахматы", image: "chess.png", complete: false, id: 17, score: 0)]
    }
     
    override func questions() -> [Question] {
        return [
        Question(question: "Поставьте мат в два хода", choices: ["Bf8; Re7", "Be5; Rd8", "Re7; Ke4"], answer: "Bf8; Re7", image: "chess1.jpeg", levelOfdifficulty: .easy),
        Question(question: "Поставьте мат в два хода", choices: ["Nd4; Nf4", "Nd4; Qf4", "Qf4; Qе3"], answer: "Nd4; Qf4", image: "chess2.jpeg", levelOfdifficulty: .normal),
        Question(question: "Поставьте мат в два хода", choices: ["Re3; Qa1", "Qe1; Qa5", "Nа4; Rb2"], answer: "Qe1; Qa5", image: "chess3.jpeg", levelOfdifficulty: .hard),
        Question(question: "Поставьте мат в два хода", choices: ["Nе7; Rf7", "Qh7; Rf7", "Nf6; Qh7"], answer: "Nf6; Qh7", image: "chess4.jpeg", levelOfdifficulty: .easy),
        Question(question: "Поставьте мат в два хода", choices: ["Kb2; Qd5", "Ka1; Qa6", "Ka2; Qa6"], answer: "Ka1; Qa6", image: "chess5.jpeg", levelOfdifficulty: .normal),
        Question(question: "Поставьте мат в два хода", choices: ["g5; Ng4", "Nf3; Kf4", "Qf7; g5"], answer: "g5; Ng4", image: "chess6.jpeg", levelOfdifficulty: .hard),
        Question(question: "Поставьте мат в два хода", choices: ["Qa8; Qd8", "Qс6; Kb3", "Qd1; Kb3"], answer: "Qa8; Qd8", image: "chess7.jpeg", levelOfdifficulty: .easy),
        Question(question: "Поставьте мат в два хода", choices: ["Ne7; Ke2", "Nf2; Rg8", "Bg8; Qd5"], answer: "Bg8; Qd5", image: "chess8.jpeg", levelOfdifficulty: .normal),
        Question(question: "Поставьте мат в два хода", choices: ["Kg4; Re2", "Ke3; Rb1", "Rb1; Kg4"], answer: "Ke3; Rb1", image: "chess9.jpeg", levelOfdifficulty: .hard),
        Question(question: "Поставьте мат в два хода", choices: ["Nc7; Bb5", "Bb5; Nf6", "e7; Nп4"], answer: "Nc7; Bb5", image: "chess10.jpeg", levelOfdifficulty: .easy),
        Question(question: "На чём играют в шахматы?", choices: ["На лавочке", "На шахматной доске", "На кортах"], answer: "На шахматной доске", image: "chess11.jpeg", levelOfdifficulty: .easy),
        Question(question: "Возможен ли ход на поле,занятое своей фигурой?", choices: ["Возможен", "Невозможен", "возможен только в конце игры"], answer: "Невозможен", image: "chess12.jpeg", levelOfdifficulty: .normal),
        Question(question: "На какое расстояние ходит король?", choices: ["На 1 в любые стороны", "На 2 по вертикали и горизонтали", "на любое расстояние по диоганали"], answer: "На 1 в любые стороны", image: "chess13.jpeg", levelOfdifficulty: .hard),
        Question(question: "Какая цель игры?", choices: ["Поставить мат сопернику?", "Поставить шах сопернику?", "Поставить пат сопернику?"], answer: "Поставить мат сопернику?", image: "chess14.jpeg", levelOfdifficulty: .easy),
        Question(question: "Как ходит слон?", choices: ["По горизонтали на любое расстояние", "По вертикали на любое расстояние", "По диагонали на любое расстояние"], answer: "По диагонали на любое расстояние", image: "chess15.jpeg", levelOfdifficulty: .normal),
        Question(question: "Что такое пат?", choices: ["Если игрок при своей очереди хода не имеет возможности сделать ни одного хода по правилам, но король игрока не находится под шахом", "Если игрок при своей очереди хода не имеет возможности сделать ни одного хода по правилам, но король игрока находится под шахом", "Если игрок при своей очереди хода имеет возможности одного ход по правилам, но король игрока не находится под шахом"], answer: "Если игрок при своей очереди хода не имеет возможности сделать ни одного хода по правилам, но король игрока не находится под шахом", image: "chess16.jpeg", levelOfdifficulty: .hard),
        Question(question: "Что такое поддержка в шахматах?", choices: ["фигура защищает другую фигуру", "фигура поддерживает себя", "фигура защищает сама себя"], answer: "фигура защищает другую фигуру", image: "chess17.jpeg", levelOfdifficulty: .easy),
        Question(question: "Сколько пешек в комплекте фигур?(1 игрока)", choices: ["8", "10", "6"], answer: "8", image: "chess18.jpeg", levelOfdifficulty: .normal),
        Question(question: "К какой категории можно отнести шахматы?", choices: ["К логической игре", "К настольно-логической", "К настольной"], answer: "К настольно-логической", image: "chess19.jpeg", levelOfdifficulty: .hard),
        Question(question: "Сколько клеток насчитывается на шахматной доске?", choices: ["48", "64", "56"], answer: "64", image: "chess20.jpeg", levelOfdifficulty: .easy)
    ]
        
    }
}
