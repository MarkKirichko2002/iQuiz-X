//
//  QuizGeography.swift
//  QUIZ
//
//  Created by Марк Киричко on 28.02.2022.
//

import Foundation

class QuizGeography: QuizBaseViewModel {
    
    override func questions() -> [Question] {
        return [
        Question(question: "Знаешь ли ты, для какой из перечисленных территорий характерно распространение вечной мерзлоты?", choices: ["Остров Сахалин", "Полуостров Таймыр", "Курильские острова"], answer: "Полуостров Таймыр", image: "geography1.jpeg", levelOfdifficulty: .easy),
        Question(question: "Какой из перечисленных народов занимается оленеводством?", choices: ["Якуты", "Калмыки", "Буряты"], answer: "Якуты", image: "geography2.jpeg", levelOfdifficulty: .normal),
        Question(question: "Знаешь ли ты, сколько процентов поверхности планеты покрыто водой?", choices: ["68 %", "71 %", "82 %"], answer: "71 %", image: "geography3.jpeg", levelOfdifficulty: .hard),
        Question(question: "Знаешь ли ты самое большое по площади государство в данном списке?", choices: ["Китай", "Франция", "Казахстан"], answer: "Китай", image: "geography4.jpeg", levelOfdifficulty: .easy),
        Question(question: "Где находится пустыня Атакама?", choices: ["Америка", "Африка", "Евразия"], answer: "Америка", image: "geography5.jpeg", levelOfdifficulty: .normal),
        Question(question: "Салоники, Халкида и Серре – города какого государства?", choices: ["Турция", "Греция", "Марокко"], answer: "Греция", image: "geography6.jpeg", levelOfdifficulty: .hard),
        Question(question: "Знаешь ли ты, как называется самый большой остров Японии?", choices: ["Хонсю", "Хоккайдо", "Сикоку"], answer: "Хонсю", image: "geography7.jpeg", levelOfdifficulty: .easy),
        Question(question: "Знаешь ли ты, сколько часовых поясов в России?", choices: ["8", "9", "11"], answer: "11", image: "geography8.jpeg", levelOfdifficulty: .normal),
        Question(question: "С каким из перечисленных государств Россия имеет сухопутную границу?", choices: ["Молдавия", "Армения", "Норвегия"], answer: "Норвегия", image: "geography9.jpeg", levelOfdifficulty: .hard),
        Question(question: "В какой республике находится озеро Байкал?", choices: ["Бурятия", "Алтай", "Калмыкия"], answer: "Бурятия", image: "geography10.jpeg", levelOfdifficulty: .easy),
        Question(question: "Что из перечисленного остров, а не полуостров?", choices: ["Йорк", "Крым", "Сахалин"], answer: "Сахалин", image: "geography11.jpeg", levelOfdifficulty: .easy),
        Question(question: "Самое сухое место на планете земля?", choices: ["Фёрнес-Крик, Долина Смерти, Калифорния", "Пустыня Атакама, Чили", "Сухие долины Мак-Мёрдо, Антарктида"], answer: "Сухие долины Мак-Мёрдо, Антарктида", image: "geography12.jpeg", levelOfdifficulty: .normal),
        Question(question: "Какая из этих стран не граничит с Италией?", choices: ["Швейцария", "Германия", "Франция"], answer: "Германия", image: "geography13.jpeg", levelOfdifficulty: .hard),
        Question(question: "Какой город не входит в тройку крупнейших по численности населения городов США?", choices: ["Хьюстон", "Чикаго", "Лос-Анджелес"], answer: "Хьюстон", image: "geography14.jpeg", levelOfdifficulty: .easy),
        Question(question: "Какая из этих стран расположена не на экваторе?", choices: ["Бразилия", "Папуа - Новая Гвинея", "Индонезия"], answer: "Папуа - Новая Гвинея", image: "geography15.jpeg", levelOfdifficulty: .normal),
        Question(question: "Какая из этих стран находится не в Африке?", choices: ["Гвинея-Бисау", "Греция", "Французская Гвиана"], answer: "Французская Гвиана", image: "geography16.jpeg", levelOfdifficulty: .hard),
        Question(question: "Какое море не имеет выхода к мировому океану?", choices: ["Каспийское море", "Красное море", "Северное море"], answer: "Каспийское море", image: "geography17.jpeg", levelOfdifficulty: .easy),
        Question(question: "Какой из этих островов находится не в Тихом океане?", choices: ["Самоа", "Остров Пасхи", "Маврикий"], answer: "Маврикий", image: "geography18.jpeg", levelOfdifficulty: .normal),
        Question(question: "Какой из этих городов не является столицей европейской страны?", choices: ["Белград", "Мюнхен", "Копенгаген"], answer: "Мюнхен", image: "geography19.jpeg", levelOfdifficulty: .hard),
        Question(question: "Какая из этих стран не имеет выхода к Средиземному морю?", choices: ["Португалия", "Турция", "Египет"], answer: "Португалия", image: "geography20.jpeg", levelOfdifficulty: .easy)
    ]
    
    }
}






