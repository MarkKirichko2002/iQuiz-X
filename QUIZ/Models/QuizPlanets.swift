//
//  QuizPlanets.swift
//  QUIZ
//
//  Created by Марк Киричко on 15.02.2022.
//

import Foundation

class QuizPlanets: QuizBase {
    
    override func ids() -> [QuizModel] {
        return [QuizModel(name: "планеты", image: "planets.jpeg", complete: false, id: 1, score: 0)]
    }
    
    override func questions() -> [Question] {
        return [
        Question(question: "Эта планета самая яркая в Солнечной системе.", choices: ["Юпитер", "Венера", "Нептун"], answer: "Венера", image: "planets1.jpeg", levelOfdifficulty: .easy),
        Question(question: "Самая холодная планета Солнечной системы.", choices: ["Уран", "Юпитер", "Сатурн"], answer: "Уран", image: "planets2.jpeg", levelOfdifficulty: .normal),
        Question(question: "На этой планете расположена самая высокая гора в Солнечной системе.", choices: ["Земля", "Марс", "Венера"], answer: "Марс", image: "planets3.jpeg", levelOfdifficulty: .hard),
        Question(question: "Самая быстрая планета в Солнечной системе.", choices: ["Меркурий", "Земля", "Марс"], answer: "Меркурий", image: "planets4.jpeg", levelOfdifficulty: .easy),
        Question(question: "Среди всех планет Солнечной системы лишь эта планета вращается по часовой стрелке.", choices: ["Сатурн", "Венера", "Земля"], answer: "Венера", image: "planets5.jpeg", levelOfdifficulty: .normal),
        Question(question: "Эта планета ближе всего находится к Солнцу.", choices: ["Земля", "Марс", "Меркурий"], answer: "Меркурий", image: "planets6.jpeg", levelOfdifficulty: .hard),
        Question(question: "Самая жаркая планета Солнечной системы.", choices: ["Меркурий", "Венера", "Марс"], answer: "Венера", image: "planets7.jpeg", levelOfdifficulty: .easy),
        Question(question: "На этой планете самые большие пылевые бури в Солнечной системе.", choices: ["Марс", "Меркурий", "Сатурн"], answer: "Марс", image: "planets8.jpeg", levelOfdifficulty: .normal),
        Question(question: "Самая большая планета Солнечной системы.", choices: ["Сатурн", "Юпитер", "Уран"], answer: "Юпитер", image: "planets9.jpeg", levelOfdifficulty: .hard),
        Question(question: "Эта планета находится ближе всего к Земле.", choices: ["Венера", "Марс", "Меркурий"], answer: "Марс", image: "planets10.jpeg", levelOfdifficulty: .easy),
        Question(question: "Какая теория происхождения Солнечной системы включает в себя идею о том, что умирающая звезда выбрасывает пыль и обломки из формирующегося Солнца?", choices: ["Гипотеза протопланет", "Теория столкновений", "Теория приливов"], answer: "Теория приливов", image: "planets11.jpeg", levelOfdifficulty: .easy),
        Question(question: "Какой процент от массы Солнечной системы составляют планеты?", choices: ["0,135%", "1,35%", "13,5%"], answer: "0,135%", image: "planets12.jpeg", levelOfdifficulty: .normal),
        Question(question: "Какие две планеты Солнечной системы не имеют спутников?", choices: ["Уран и Нептун", "Меркурий и Венера", "Нептун и Плутон"], answer: "Меркурий и Венера", image: "planets13.jpeg", levelOfdifficulty: .hard),
        Question(question: "Как называется крупнейший спутник Плутона?", choices: ["Пандора", "Харон", "Фобос"], answer: "Харон", image: "planets14.jpeg", levelOfdifficulty: .easy),
        Question(question: "Три главные составляющие кометы - это ядро, хвост и...", choices: ["Зенит", "Кома", "Конус тени"], answer: "Кома", image: "planets15.jpeg", levelOfdifficulty: .normal),
        Question(question: "Какое название носит явление, при котором три небесных тела встают в одну линию?", choices: ["Сизигия", "Покрытие", "Смещение"], answer: "Сизигия", image: "planets16.jpeg", levelOfdifficulty: .hard),
        Question(question: "Какая пилотируемая космическая программа США в итоге доставила 12 человек на Луну?", choices: ["Аполлон", "Джемини", "Вояджер"], answer: "Аполлон", image: "planets17.jpeg", levelOfdifficulty: .easy),
        Question(question: "Какая планета с 1978 по 1999 гг. находилась дальше остальных от Солнца?", choices: ["Сатурн", "Уран", "Нептун"], answer: "Нептун", image: "planets18.jpeg", levelOfdifficulty: .normal),
        Question(question: "Какая из этих планет не имеет колец?", choices: ["Сатурн", "Венера", "Нептун"], answer: "Венера", image: "planets19.jpeg", levelOfdifficulty: .hard),
        Question(question: "Сколько планет находится в Солнечной системе (согласно учебникам)?", choices: ["8", "9", "10"], answer: "8", image: "planets20.jpeg", levelOfdifficulty: .easy),
        
    ]
        
    }
}
