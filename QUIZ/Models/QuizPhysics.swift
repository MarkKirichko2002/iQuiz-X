//
//  QuizPhysics.swift
//  QUIZ
//
//  Created by Марк Киричко on 08.03.2022.
//

import Foundation

class QuizPhysics: QuizBase {
    
    override func ids() -> [QuizModel] {
        return [QuizModel(name: "физика", image: "physics.jpeg", complete: false, id: 10, score: 0)]
    }
     
    override func questions() -> [Question] {
        return [
        Question(question: "Кран поднимает вертикально вверх на высоту 5 м груз весом 1000 Н за 10 с. Какую механическую мощность развивает подъёмный кран во время этого подъёма?", choices: ["500 Вт", "1000 Вт", "5000 Вт"], answer: "500 Вт", image: "physics1.jpeg", levelOfdifficulty: .easy),
        Question(question: "Тело объёмом 20 см3 состоит из вещества плотностью 7,3 г/см3. Какова масса тела?", choices: ["2,74 кг", "146 г.", "2,74 г."], answer: "146 г.", image: "physics2.jpeg", levelOfdifficulty: .normal),
        Question(question: "Тело сохраняет свои объём и форму. В каком агрегативном состоянии находится вещество, из которого состоит тело?", choices: ["Может находиться в любом состоянии", "В жидком", "В твёрдом"], answer: "В твёрдом", image: "physics3.jpeg", levelOfdifficulty: .hard),
        Question(question: "Тело весом 15 Н полностью погружено в жидкость. Вес вытесненной жидкости 10 Н. Какова сила Архимеда, действующая на тело?", choices: ["20 Н", "10 Н", "5 Н"], answer: "10 Н", image: "physics4.jpeg", levelOfdifficulty: .easy),
        Question(question: "Какое давление на пол оказывает ковёр весом 150 Н и площадью 6 м2?", choices: ["900 Па", "90 Па", "25 Па"], answer: "25 Па", image: "physics5.jpeg", levelOfdifficulty: .normal),
        Question(question: "В каком состоянии вещества скорость беспорядочного движения молекул уменьшается с понижением температуры?", choices: ["В газообразном и жидком", "Только в газообразном", "Во всех состояниях"], answer: "Во всех состояниях", image: "physics6.jpeg", levelOfdifficulty: .hard),
        Question(question: "В каком состоянии вещества при одной и той же температуре скорость движения молекул больше?", choices: ["В газообразном", "В жидком", "В твёрдом"], answer: "В газообразном", image: "physics7.jpeg", levelOfdifficulty: .easy),
        Question(question: "В каком случае в физике утверждение считается истинным?", choices: ["Если оно многократно экспериментально проверено разными учёными", "Если оно опубликовано", "Если оно широко известно"], answer: "Если оно многократно экспериментально проверено разными учёными", image: "physics8.jpeg", levelOfdifficulty: .normal),
        Question(question: "Что является основной единицей массы в Международной системе единиц?", choices: ["Джоуль", "Килограмм", "Ньютон"], answer: "Килограмм", image: "physics9.jpeg", levelOfdifficulty: .hard),
        Question(question: "С какой силой притягивается к Земле тело массой 3 кг?", choices: ["30 кг", "30 Н", "3 кг"], answer: "30 Н", image: "physics10.jpeg", levelOfdifficulty: .easy),
        Question(question: "Велосипедист, двигаясь равномерно, проезжает 20 метров за 2 секунд. Определи, какой путь он проедет при движении с той же скоростью за 10 секунд.", choices: ["100 метров", "60 метров", "150 метров"], answer: "100 метров", image: "physics11.jpeg", levelOfdifficulty: .easy),
        Question(question: "Что является источником магнитного поля?", choices: ["Любое движущееся тело", "Любое заряженное тело", "Движущаяся заряженная частица"], answer: "Движущаяся заряженная частица", image: "physics12.jpeg", levelOfdifficulty: .normal),
        Question(question: "С какой высоты был сброшен камень, если он упал на землю через 3 секунды?", choices: ["45 метров", "60 метров", "90 метров"], answer: "45 метров", image: "physics13.jpeg", levelOfdifficulty: .hard),
        Question(question: "Движущиеся электрические заряды создают...", choices: ["Магнитное поле", "Электрическое поле", "Электрическое и магнитное поле"], answer: "Электрическое и магнитное поле", image: "physics14.jpeg", levelOfdifficulty: .easy),
        Question(question: "Как будет двигаться тело массой 5 кг под действием силы 5Н?", choices: ["Равноускоренно", "Будет покоиться", "Равномерно"], answer: "Равноускоренно", image: "physics15.jpeg", levelOfdifficulty: .normal),
        Question(question: "Период свободных колебаний пружинного маятника зависит от...", choices: ["Амплитуды колебаний", "Массы груза", "Частоты колебаний"], answer: "Массы груза", image: "physics16.jpeg", levelOfdifficulty: .hard),
        Question(question: "Назовите единицу измерения мощности.", choices: ["Ньютон", "Джоуль", "Ватт"], answer: "Ватт", image: "physics17.jpeg", levelOfdifficulty: .easy),
        Question(question: "Виды движения с точки зрения механики:", choices: ["Вращательные", "Поступательные", "Переменные"], answer: "Вращательные", image: "physics18.jpeg", levelOfdifficulty: .normal),
        Question(question: "Кто открыл законы движения планет вокруг Солнца?", choices: ["Бруно", "Кеплер", "Коперник"], answer: "Кеплер", image: "physics19.jpeg", levelOfdifficulty: .hard),
        Question(question: "Масса тела на Земле и на Луне…", choices: ["На Луне масса больше", "На Земле масса больше", "Одинакова"], answer: "Одинакова", image: "physics20.jpeg", levelOfdifficulty: .easy)
    ]
    
    }
}









