//
//  QuizIQ.swift
//  QUIZ
//
//  Created by Марк Киричко on 19.02.2022.
//

import Foundation

class QuizIQ: QuizBase {
    
    override func ids() -> [QuizModel] {
        return [QuizModel(name: "IQ", image: "anatomy.jpeg", complete: false, id: 6, score: 0)]
    }
    
    override func questions() -> [Question] {
        return [
        Question(question: "Какие буквы должны стоять, вместо вопросительных знаков?", choices: ["ЕН", "ДМ", "ГН"], answer: "ДМ", image: "IQ1.jpeg", levelOfdifficulty: .easy),
        Question(question: "Какие буквы следующие: Г Т Ё Р И О ?", choices: ["КО", "ЛМ", "ЛН"], answer: "ЛМ", image: "IQ2.jpeg", levelOfdifficulty: .normal),
        Question(question: "Какой рисунок является лишним?", choices: ["4", "5", "7"], answer: "7", image: "IQ3.jpeg", levelOfdifficulty: .hard),
        Question(question: "Какое число должно быть, вместо вопросительного знака?", choices: ["94", "118", "108"], answer: "118", image: "IQ4.jpeg", levelOfdifficulty: .easy),
        Question(question: "Какое число должно быть, вместо вопросительного знака?", choices: ["11", "17", "12"], answer: "17", image: "IQ5.jpeg", levelOfdifficulty: .normal),
        Question(question: "Какая буква следующая: Ц Ф Т Р О ?", choices: ["О", "М", "Н"], answer: "М", image: "IQ6.jpeg", levelOfdifficulty: .hard),
        Question(question: "Какое число должно быть, вместо вопросительного знака?", choices: ["20", "21", "19"], answer: "19", image: "IQ7.jpeg", levelOfdifficulty: .easy),
        Question(question: "Какие числа следующие: 2 8 6 24 18 ?", choices: ["4836", "5842", "7254"], answer: "7254", image: "IQ8.jpeg", levelOfdifficulty: .normal),
        Question(question: "Какой рисунок должен быть, вместо вопросительного знака?", choices: ["4", "5", "6"], answer: "6", image: "IQ9.jpeg", levelOfdifficulty: .hard),
        Question(question: "Какое число следующее: 14 21 28 35 42 ?", choices: ["46", "48", "49"], answer: "49", image: "IQ10.jpeg", levelOfdifficulty: .easy),
        Question(question: "Какие числа следующие: 3, 6, 9, 18, 27, ?, ?", choices: ["53, 80", "52, 83", "54, 81"], answer: "54, 81", image: "IQ11.jpeg", levelOfdifficulty: .easy),
        Question(question: "Каким числом следует заменить знак вопроса?", choices: ["6", "44", "25"], answer: "44", image: "IQ12.jpeg", levelOfdifficulty: .normal),
        Question(question: "В кругах помещены группы букв, из какой группы нельзя составить слово?", choices: ["Б", "В", "Г"], answer: "Г", image: "IQ13.jpeg", levelOfdifficulty: .hard),
        Question(question: "Какая из пяти фигур является лишней?", choices: ["1", "2", "4"], answer: "4", image: "IQ14.jpeg", levelOfdifficulty: .easy),
        Question(question: "Отгадайте слово из 9 букв, которые перемешаны в квадрате. Слово получилось? Тогда вторая буква будет:", choices: ["а", "м", "н"], answer: "а", image: "IQ15.jpeg", levelOfdifficulty: .normal),
        Question(question: "Укажите недостающий круг.", choices: ["А", "Б", "В"], answer: "Б", image: "IQ16.jpeg", levelOfdifficulty: .hard),
        Question(question: "Какое слово надо вставить в скобки вместо многоточия? 17, 13, (ПЛАН) 1, 15;22, 1 ( . . . . )12, 20.", choices: ["ПОРТ", "ФАКТ", "КРОТ"], answer: "ФАКТ", image: "IQ17.jpeg", levelOfdifficulty: .easy),
        Question(question: "Каким числом следует заменить знак вопроса: 23, 27, 31, 35, ? .", choices: ["27", "36", "39"], answer: "39", image: "IQ18.jpeg", levelOfdifficulty: .normal),
        Question(question: "Укажите недостающее число и букву.", choices: ["5иШ", "1иЫ", "1иУ"], answer: "5иШ", image: "IQ19.jpeg", levelOfdifficulty: .hard),
        Question(question: "Какое число нужно поставить вместо знака вопроса?", choices: ["4", "5", "6"], answer: "6", image: "IQ20.jpeg", levelOfdifficulty: .easy)
    ]
    
    }
}





