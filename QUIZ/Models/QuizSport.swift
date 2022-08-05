//
//  QuizSport.swift
//  QUIZ
//
//  Created by Марк Киричко on 17.02.2022.
//

import Foundation

class QuizSport: QuizBase {
    
    override func ids() -> [QuizModel] {
        return [QuizModel(name: "спорт", image: "sport.jpeg", complete: false, id: 4, score: 0)]
    }
    
    override func questions() -> [Question] {
        return [
        Question(question: "Чем поливают друг друга победители этапа «Формулы-1» в Бахрейне?", choices: ["Газировкой", "Шампанским", "Другой вариант ответа"], answer: "Газировкой", image: "sport1.jpeg", levelOfdifficulty: .easy),
        Question(question: "Какой вид спорта входит в программу зимних Олимпиад?", choices: ["Бейсбол", "Биатлон", "Триатлон"], answer: "Биатлон", image: "sport2.jpeg", levelOfdifficulty: .normal),
        Question(question: "Что делают с коньками перед соревнованиями?", choices: ["Отбрасывают", "Режут", "Точат"], answer: "Точат", image: "sport3.jpeg", levelOfdifficulty: .hard),
        Question(question: "Какой вид лыжного спорта не является дисциплиной фристайла?", choices: ["Слалом", "Лыжная акробатика", "Лыжный балет"], answer: "Слалом", image: "sport4.jpeg", levelOfdifficulty: .easy),
        Question(question: "Как называется запрещённый приём в футболе?", choices: ["Укладка", "Закладка", "Накладка"], answer: "Накладка", image: "sport5.jpeg", levelOfdifficulty: .normal),
        Question(question: "Как называется установка с мишенями в одной из дисциплин стрелкового спорта?", choices: ["Ползущий танк", "Висящий шимпанзе", "Бегущий кабан"], answer: "Бегущий кабан", image: "sport6.jpeg", levelOfdifficulty: .hard),
        Question(question: "Кто руководил СССР во время московской Олимпиады в 1980 году?", choices: ["М.С. Горбачев", "Л.И. Брежнев", "Ю.В.Андропов"], answer: "Л.И. Брежнев", image: "sport7.jpeg", levelOfdifficulty: .easy),
        Question(question: "На какие даты ПЕРВОНАЧАЛЬНО был запланирован матч ЕВРО-2020?", choices: ["11 июня - 11 июля 2020 года", "12 июня - 12 июля 2020 года", "11 июня - 11 июля 2021 года"], answer: "12 июня - 12 июля 2020 года", image: "sport8.jpeg", levelOfdifficulty: .normal),
        Question(question: "Какая компания предоставила официальный мяч для ЕВРО-2020?", choices: ["Adidas", "Nike", "Puma"], answer: "Adidas", image: "sport9.jpeg", levelOfdifficulty: .hard),
        Question(question: "Какая из перечисленных стран дошла до четвертьфинала ЕВРО-2020, но не прошла в полуфинал?", choices: ["Чехия", "Франция", "Англия"], answer: "Чехия", image: "sport10.jpeg", levelOfdifficulty: .easy),
        Question(question: "Что в Древней Греции означал термин Олимпиада?", choices: ["Международные спортивные соревнования", "Высшая награда для спортсмена", "Период в 4 года между Олимпийскими играми"], answer: "Период в 4 года между Олимпийскими играми", image: "sport11.jpeg", levelOfdifficulty: .easy),
        Question(question: "В каком году и где состоялись первые современные Олимпийские игры?", choices: ["В 1892, в Риме", "В 1896, в Афинах", "В 1894, в Париже"], answer: "В 1896, в Афинах", image: "sport12.jpeg", levelOfdifficulty: .normal),
        Question(question: "Какой части света принадлежит зеленое кольцо в главном символе Олимпиады?", choices: ["Европе", "Азии", "Австралии"], answer: "Австралии", image: "sport13.jpeg", levelOfdifficulty: .hard),
        Question(question: "На каких Олимпийских играх впервые появилась символика в виде пяти переплетенных колец?", choices: ["В 1920 году, на играх в Антверпене", "В 1924 года, в Париже", "В 1908 году, в Лондоне"], answer: "В 1920 году, на играх в Антверпене", image: "sport14.jpeg", levelOfdifficulty: .easy),
        Question(question: "Какие из перечисленных Олимпийских игр не состоялись?", choices: ["Олимпийские игры 1916 года в Берлине", "Олимпийские игры 1912 года в Стокгольме", "Олимпийские игры 1932 года в Лос-Анджелесе"], answer: "Олимпийские игры 1916 года в Берлине", image: "sport15.jpeg", levelOfdifficulty: .normal),
        Question(question: "Какая страна стала чемпионом Европы по футболу 2020?", choices: ["Англия", "Италия", "Дания"], answer: "Италия", image: "sport16.jpeg", levelOfdifficulty: .hard),
        Question(question: "Кто был признан лучшим игроком ЕВРО 2020?", choices: ["Джанлуиджи Доннарумма", "Антуан Гризманн", "Криштиану Роналду"], answer: "Джанлуиджи Доннарумма", image: "sport17.jpeg", levelOfdifficulty: .easy),
        Question(question: "Угадайте какой вид спорта на фотографии?", choices: ["Гонки NASCAR", "Дрэг-рейсинг", "Ралли"], answer: "Дрэг-рейсинг", image: "sport18.jpeg", levelOfdifficulty: .normal),
        Question(question: "Угадайте какой вид спорта на фотографии?", choices: ["Регби", "Американский футбол", "футбол"], answer: "Американский футбол", image: "sport19.jpeg", levelOfdifficulty: .hard),
        Question(question: "Угадайте какой вид спорта на фотографии?", choices: ["Мототриал", "Мотокросс", "Суперкросс"], answer: "Мототриал", image: "sport20.jpeg", levelOfdifficulty: .easy)
    ]
    
    }
}



