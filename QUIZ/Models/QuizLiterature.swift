//
//  QuizLiterature.swift
//  QUIZ
//
//  Created by Марк Киричко on 02.04.2022.
//

import Foundation

class QuizLiterature: QuizBase {
    
    
    override func ids() -> [QuizModel] {
        return [QuizModel(name: "литература", image: "literature.jpeg", complete: false, id: 13, score: 0)]
    }
     
    override func questions() -> [Question] {
        return [
        Question(question: "На печать какого из этих произведений Л.Толстого понадобится наибольшее количество бумаги?", choices: ["«Анна Каренина»", "«Детство»", "«Война и мир»"], answer: "«Война и мир»", image: "literature1.jpeg", levelOfdifficulty: .easy),
        Question(question: "У литературного героя какого из этих классиков некогда пропал нос?", choices: ["А. Грибоедов", "Н. Гоголь", "Н. Карамзин"], answer: "Н. Гоголь", image: "literature2.jpeg", levelOfdifficulty: .normal),
        Question(question: "В каком экспрессе герои одноименного романа Агаты Кристи ехали из Стамбула в Париж?", choices: ["Восточном", "Западном", "Северном"], answer: "Восточном", image: "literature3.jpeg", levelOfdifficulty: .hard),
        Question(question: "Кто автор этих строк: «Счастлив, кто падает вниз головой, мир для него хоть на миг, а иной»?", choices: ["Евгений Баратынский", "Владислав Ходасевич", "Николай Некрасов"], answer: "Владислав Ходасевич", image: "literature4.jpeg", levelOfdifficulty: .easy),
        Question(question: "В миле от какого города находится замок Иф, где содержался в заключении граф Монте-Кристо?", choices: ["Ницца", "Монако", "Марсель"], answer: "Марсель", image: "literature5.jpeg", levelOfdifficulty: .normal),
        Question(question: "Какой автор писал под псевдонимом Мэри Вестмакотт?", choices: ["Шарлотта Бронте", "Агата Кристи", "Маргарет Митчелл"], answer: "Агата Кристи", image: "literature6.jpeg", levelOfdifficulty: .hard),
        Question(question: "Кто был героем рассказов Р. Киплинга?", choices: ["Буратино", "Красная Шапочка", "Маугли"], answer: "Маугли", image: "literature7.jpeg", levelOfdifficulty: .easy),
        Question(question: "Какой из этих романов написал не Хемингуэй?", choices: ["Фиеста", "Триумфальная арка", "По ком звонит колокол"], answer: "Триумфальная арка", image: "literature8.jpeg", levelOfdifficulty: .normal),
        Question(question: "Какое произведение Гёте писал дольше?", choices: ["«Ифигения в Тавриде»", "Торквато Тассо", "Фауст"], answer: "Фауст", image: "literature9.jpeg", levelOfdifficulty: .hard),
        Question(question: "Кто автор трагедии «Гамлет»?", choices: ["Чехов", "Вергилий", "Шекспир"], answer: "Шекспир", image: "literature10.jpeg", levelOfdifficulty: .easy),
        Question(question: "Что означает этот литературный термин?", choices: ["Научный, исторический или публицистический очерк", "Определение, прибавляемое к слову с целью подчеркнуть его свойство и придать ему художественную выразительность", "Опущение в речи слов, легко подразумеваемых"], answer: "Определение, прибавляемое к слову с целью подчеркнуть его свойство и придать ему художественную выразительность", image: "literature11.jpeg", levelOfdifficulty: .easy),
        Question(question: "Что означает этот литературный термин?", choices: ["Слово или фраза в переносном, иносказательном значении", "Избыточность высказывания, повторение одних и тех же или близких по смыслу слов", "Оборот речи, применяемый для усиления экспрессивности"], answer: "Избыточность высказывания, повторение одних и тех же или близких по смыслу слов", image: "literature12.jpeg", levelOfdifficulty: .normal),
        Question(question: "Что означает этот литературный термин?", choices: ["Старинная лирико-эпическая французская песня", "Игра слов, основанная на их звуковом сходстве при различном смысле", "другое"], answer: "Игра слов, основанная на их звуковом сходстве при различном смысле", image: "literature13.jpeg", levelOfdifficulty: .hard),
        Question(question: "Что означает этот литературный термин?", choices: ["Опущение в речи слов, легко подразумеваемых", "Риторическая фигура, состоящая из повторения одного и того же слова или оборота", "Стилистическая фигура явного и намеренного преувеличения, с целью усиления выразительности"], answer: "Опущение в речи слов, легко подразумеваемых", image: "literature14.jpeg", levelOfdifficulty: .easy),
        Question(question: "Какой жанр не относится к лирике?", choices: ["ода", "роман", "стихотворение"], answer: "роман", image: "literature15.jpeg", levelOfdifficulty: .normal),
        Question(question: "Что означает этот литературный термин?", choices: ["Толкование, раскрытие смысла чего-либо, разъяснение того или иного текста", "Внедрение новых слов в речь", "Процесс вставки частей предложения в текст"], answer: "Толкование, раскрытие смысла чего-либо, разъяснение того или иного текста", image: "literature16.jpeg", levelOfdifficulty: .hard),
        Question(question: "Что означает этот литературный термин?", choices: ["Оборот речи, состоящий в чрезмерном преувелечении для более сильного впечатления", "Рифма, в которой после последнего ударного слога идут три и более безударных слога", "Употребление слова или выражения в переносном смысле"], answer: "Оборот речи, состоящий в чрезмерном преувелечении для более сильного впечатления", image: "literature17.jpeg", levelOfdifficulty: .easy),
        Question(question: "Что означает этот литературный термин?", choices: ["Толковый словарь устарелых и малоупотребительных слов к какому-либо тексту", "Сборник сведений, статей, материалов по какому-либо вопросу", "Небольшое повествовательное прозаическое литературное произведение"], answer: "Толковый словарь устарелых и малоупотребительных слов к какому-либо тексту", image: "literature18.jpeg", levelOfdifficulty: .normal),
        Question(question: "Что означает этот литературный термин?", choices: ["Форма средневековой немецкой дидактической поэзии", "Русские эпические песни и стихи", "Небольшое повествовательное прозаическое литературное произведение"], answer: "Русские эпические песни и стихи", image: "literature19.jpeg", levelOfdifficulty: .hard),
        Question(question: "Что означает этот литературный термин?", choices: ["Оборот речи, обратный гиперболе, преуменьшение", "Употребление слова или выражения в переносном смысле", "Перестановка звуков внутри слова"], answer: "Употребление слова или выражения в переносном смысле", image: "literature20.jpeg", levelOfdifficulty: .easy)
    ]
    
    }
}











