//
//  QuestionManager.swift
//  QUIZ
//
//  Created by Марк Киричко on 15.02.2022.
//

import Foundation

class QuizHistory: QuizBaseViewModel {
    
    override func ids() -> [QuizModel] {
        return [QuizModel(name: "история", image: "history.jpeg", complete: false, id: 2, score: 0)]
    }
    
    override func questions() -> [Question] {
        return [
        Question(question: "Какое из данных исторических явлений относится ко второму периоду истории средних веков?", choices: ["Образование сословий", "Возникновение и дальнейшее развитие капиталистических мануфактур", "Появление государств натурального хозяйства"], answer: "Образование сословий", image: "history1.jpeg", levelOfdifficulty: .easy),
        Question(question: "Когда пала Западная Римская империя?", choices: ["476 г.", "480 г.", "485 г."], answer: "476 г.", image: "history2.jpeg", levelOfdifficulty: .normal),
        Question(question: "Характерной чертой какой реформы является лозунг Три года упорного труда - десять тысяч лет счастья?", choices: ["Трех красных знамён в Китае", "Индийской реформы", "Реформы в Японии"], answer: "Трех красных знамён в Китае", image: "history3.jpeg", levelOfdifficulty: .hard),
        Question(question: "Где находилась большая часть железных дорог в мире в 1830 г.?", choices: ["Россия", "Англия", "Эстония"], answer: "Англия", image: "history4.jpeg", levelOfdifficulty: .easy),
        Question(question: "Выберите государство, в котором в 1945 г. было образовано правительство трех больших партий", choices: ["Финляндия", "Дания", "Англия"], answer: "Финляндия", image: "history5.jpeg", levelOfdifficulty: .normal),
        Question(question: "Население Франции в XVI в. разделилось по религиозному признаку на гугенотов и протестантов.", choices: ["Правда", "Ложь", "-"], answer: "Ложь", image: "history6.jpeg", levelOfdifficulty: .hard),
        Question(question: "В какой стране началась Реформация?", choices: ["Испания", "Германия", "Исландия"], answer: "Германия", image: "history7.jpeg", levelOfdifficulty: .easy),
        Question(question: "Выберите правильное название португальского корабля XVI века?", choices: ["Каравелла", "Триера", "Арго"], answer: "Каравелла", image: "history8.jpeg", levelOfdifficulty: .normal),
        Question(question: "Какой французский протестант провел церковную реформу в Женеве?", choices: ["Жан Кальвин", "Джавахарлал Неру", "Дэн Сяопин"], answer: "Жан Кальвин", image: "history9.jpeg", levelOfdifficulty: .hard),
        Question(question: "Какая страна осуществила колонизацию и покорение Северной Америки?", choices: ["Россия", "Англия", "Нидерланды"], answer: "Англия", image: "history10.jpeg", levelOfdifficulty: .easy),
        Question(question: "Русско-Японская война.", choices: ["1905-1906", "1904-1905", "1906-1907"], answer: "1904-1905", image: "history11.jpeg", levelOfdifficulty: .easy),
        Question(question: "Кровавое воскресенье.", choices: ["9 января 1905 г.", "10 января 1906 г.", "19 января 1905 г."], answer: "9 января 1905 г.", image: "history12.jpeg", levelOfdifficulty: .normal),
        Question(question: "Подписаны документы об образовании СССР (Союза Советских Социалистических Республик)", choices: ["29 декабря 1922 г.", "29 декабря 1921 г.", "29 декабря 1923 г."], answer: "29 декабря 1922 г.", image: "history13.jpeg", levelOfdifficulty: .hard),
        Question(question: "Принята первая Конституция СССР.", choices: ["Январь 1924 г.", "Январь 1926 г.", "Январь 1928 г."], answer: "Январь 1924 г.", image: "history14.jpeg", levelOfdifficulty: .easy),
        Question(question: "Запуск первого в мире искусственного спутника (Спутник-1).", choices: ["4 сентября 1956 г.", "4 октября 1957 г.", "4 ноября 1958 г."], answer: "4 октября 1957 г.", image: "history15.jpeg", levelOfdifficulty: .normal),
        Question(question: "Укажи год начала правления Бориса Годунова:", choices: ["1583", "1591", "1598"], answer: "1598", image: "history16.jpeg", levelOfdifficulty: .hard),
        Question(question: "Общеевропейская война XVIII в., в ходе которой русская армия взяла Берлин, получила название:", choices: ["Тридцатилетняя", "Семилетняя", "Северная"], answer: "Семилетняя", image: "history17.jpeg", levelOfdifficulty: .easy),
        Question(question: "Год открытия Америки...", choices: ["1491", "1492", "1493"], answer: "1492", image: "history18.jpeg", levelOfdifficulty: .normal),
        Question(question: "Крымский полуостров вошел в состав Российской империи в результате:", choices: ["Прутского похода", "Русско-турецкой войны", "Азовского похода"], answer: "Русско-турецкой войны", image: "history19.jpeg", levelOfdifficulty: .hard),
        Question(question: "Какой из европейских городов к 1700г. был самым большим по населению?", choices: ["Париж", "Лондон", "Рим"], answer: "Лондон", image: "history20.jpeg", levelOfdifficulty: .easy)
    ]
    
    }
}
