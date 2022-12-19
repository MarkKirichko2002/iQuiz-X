//
//  QuizAnatomy.swift
//  QUIZ
//
//  Created by Марк Киричко on 16.02.2022.
//

import Foundation

class QuizAnatomy: QuizBaseViewModel {
    
    override func questions() -> [Question] {
        return [
        Question(question: "Звук какой частоты воспринимается человеческим ухом?", choices: ["От 20 до 20 000 Гц", "От 50 до 50 000 Гц", "От 100 до 100 000 Гц"], answer: "От 20 до 20 000 Гц", image: "anatomy1.jpeg", levelOfdifficulty: .easy),
        Question(question: "Какая часть тела не растет с возрастом?", choices: ["Глаза", "Уши", "Нос"], answer: "Глаза", image: "anatomy2.jpeg", levelOfdifficulty: .normal),
        Question(question: "Сколько костей в теле взрослого человека?", choices: ["206", "270", "521"], answer: "206", image: "anatomy3.jpeg", levelOfdifficulty: .hard),
        Question(question: "На каком расстоянии человеческий глаз способен увидеть пламя свечи?", choices: ["5 км", "25 км", "50 км"], answer: "50 км", image: "anatomy4.jpeg", levelOfdifficulty: .easy),
        Question(question: "Какая часть тела создает неповторимые отпечатки, помимо пальцев?", choices: ["Нос", "Язык", "Волосы"], answer: "Язык", image: "anatomy5.jpeg", levelOfdifficulty: .normal),
        Question(question: "Какой орган потребляет больше всего кислорода?", choices: ["Легкие", "Мозг", "Бронхи"], answer: "Мозг", image: "anatomy6.jpeg", levelOfdifficulty: .hard),
        Question(question: "Какова роль околоносовых пазух?", choices: ["Формируют тембр голоса.", "Выделяют кислород для переноса по всему телу.", "При прохождении воздуха через нос они его согревают."], answer: "Формируют тембр голоса.", image: "anatomy7.jpeg", levelOfdifficulty: .easy),
        Question(question: "Какая самая длинная кость в человеческом теле?", choices: ["Большеберцовая кость.", "Бедренная кость.", "Малоберцовая кость."], answer: "Бедренная кость.", image: "anatomy8.jpeg", levelOfdifficulty: .normal),
        Question(question: "Какова функция радужки?", choices: ["Вывод крови из капилляров.", "Регулирование поступающих внутрь глазного яблока лучей света.", "Радужка отвечает за цветовое восприятие."], answer: "Регулирование поступающих внутрь глазного яблока лучей света.", image: "anatomy9.jpeg", levelOfdifficulty: .hard),
        Question(question: "Спинной мозг - часть какой системы?", choices: ["Позвоночной.", "Когнитивной.", "Нервной."], answer: "Нервной.", image: "anatomy10.jpeg", levelOfdifficulty: .easy),
        Question(question: "Выберите височную долю", choices: ["1", "3", "6"], answer: "6", image: "anatomy11.jpeg", levelOfdifficulty: .easy),
        Question(question: "К какой системе организма относится трахея?", choices: ["Дыхательной", "Нервной", "Циркуляторной"], answer: "Дыхательной", image: "anatomy12.jpeg", levelOfdifficulty: .normal),
        Question(question: "Где левое предсердие?", choices: ["1", "2", "3"], answer: "2", image: "anatomy13.jpeg", levelOfdifficulty: .hard),
        Question(question: "Какая часть мозга является мозжечком?", choices: ["1", "3", "5"], answer: "5", image: "anatomy14.jpeg", levelOfdifficulty: .easy),
        Question(question: "Укажите лобную мышцу", choices: ["1", "2", "3"], answer: "2", image: "anatomy15.jpeg", levelOfdifficulty: .normal),
        Question(question: "Какая кровь является универсальной для донорства?", choices: ["1", "2", "3 или 4"], answer: "1", image: "anatomy16.jpeg", levelOfdifficulty: .hard),
        Question(question: "Каких клеток больше всего в составе человеческой крови?", choices: ["Лейкоциты", "Эритроциты", "Лимфоциты"], answer: "Эритроциты", image: "anatomy17.jpeg", levelOfdifficulty: .easy),
        Question(question: "Можете ли вы найти аорту?", choices: ["1", "2", "3"], answer: "1", image: "anatomy18.jpeg", levelOfdifficulty: .normal),
        Question(question: "Сколько желудочков находится в головном мозге человека?", choices: ["2", "1", "4"], answer: "4", image: "anatomy19.jpeg", levelOfdifficulty: .hard),
        Question(question: "Где заканчивается спинной мозг человека?", choices: ["В крестцовом отделе позвоночника", "В грудном отделе позвоночника", "В поясничном отделе позвоночника"], answer: "В поясничном отделе позвоночника", image: "anatomy20.jpeg", levelOfdifficulty: .easy),
    ]
    
    
    }
}


