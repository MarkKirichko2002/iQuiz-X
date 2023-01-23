//
//  QuizHalloween.swift
//  QUIZ
//
//  Created by Марк Киричко on 01.10.2022.
//

import Foundation

class QuizHalloween: QuizBaseViewModel {
    
    override func questions() -> [Question] {
        return [
        Question(question: "Какая группа людей начала Хэллоуин?", choices: ["Викинги", "Мавры", "кельты"], answer: "кельты", image: "halloween1.jpeg", levelOfdifficulty: .easy),
        Question(question: "Какая религия адаптировала Хэллоуин в 1000 году нашей эры в соответствии со своими обычаями?", choices: ["Иудаизм", "Христианство", "Конфуцианство"], answer: "Христианство", image: "halloween2.jpeg", levelOfdifficulty: .normal),
        Question(question: "Какие из этих конфет наиболее популярны в США во время Хэллоуина?", choices: ["M & Ms ", "Сникерс", "Риз"], answer: "Риз", image: "halloween3.jpeg", levelOfdifficulty: .hard),
        Question(question: "В какой стране начался Хэллоуин", choices: ["Бразилия", "Ирландия", "Германия"], answer: "Ирландия", image: "halloween4.jpeg", levelOfdifficulty: .easy),
        Question(question: "Что из этого не является традиционным украшением Хэллоуина?", choices: ["Котел", "Ведьма", "Венок"], answer: "Венок", image: "halloween5.jpeg", levelOfdifficulty: .normal),
        Question(question: "В каком году вышла современная классика «Кошмар перед Рождеством»?", choices: ["1987", "1993", "1999"], answer: "1993", image: "halloween6.jpeg", levelOfdifficulty: .hard),
        Question(question: "Уэнсдей Аддамс - кто из членов семьи Аддамсов?", choices: ["Дочь", "Мать", "Сестра"], answer: "Дочь", image: "halloween7.jpeg", levelOfdifficulty: .easy),
        Question(question: "Какой персонаж в классическом фильме 1966 года «Это большая тыква, Чарли Браун» объясняет сказку о Великой тыкве?", choices: ["Снупи", "Линус", "Салли"], answer: "Линус", image: "halloween8.jpeg", levelOfdifficulty: .normal),
        Question(question: "Как называется день после Хэллоуина?", choices: ["День всех святых", "День всех мертвых", "другой вариант ответа"], answer: "День всех святых", image: "halloween9.jpeg", levelOfdifficulty: .hard),
        Question(question: "Согласно поверью, люди, рожденные в Хэллоуин, обладают сверхъестественной способностью. Какой?", choices: ["Умеют предсказывать будущее", "Умеют читать мысли", "Умеют общаться с призраками"], answer: "Умеют общаться с призраками", image: "halloween10.jpeg", levelOfdifficulty: .easy),
        Question(question: "Как называется эта популярная американская конфета?", choices: ["Кусочки тыквы", "Сладкий попкорн", "Зубы ведьм"], answer: "Сладкий попкорн", image: "halloween11.jpeg", levelOfdifficulty: .easy),
        Question(question: "Какого числа празднуют Хэллоуин?", choices: ["В ночь с 31 октября на 1 ноября", "30 октября ", "29 октября"], answer: "В ночь с 31 октября на 1 ноября", image: "halloween12.jpeg", levelOfdifficulty: .normal),
        Question(question: "Какой овощ считается символом Хэллоуина?", choices: ["Тыква", "Арбуз", "Кабачок"], answer: "Тыква", image: "halloween13.jpeg", levelOfdifficulty: .hard),
        Question(question: "Как называется этот дом?", choices: ["Дом-монстр", "Дом-чудовище", "другой вариант ответа"], answer: "Дом-монстр", image: "halloween14.jpeg", levelOfdifficulty: .easy),
        Question(question: "Как называется этот фильм о Хэллоуине 2007 года?", choices: ["Trick 'r Treat", "Калейдоскоп ужасов", "It"], answer: "Trick 'r Treat", image: "halloween15.jpeg", levelOfdifficulty: .normal),
        Question(question: "Тыквы растут…", choices: ["на кустах", "под землей", "на лозе"], answer: "на лозе", image: "halloween16.jpeg", levelOfdifficulty: .hard),
        Question(question: "Насколько тяжелой может быть тыква?", choices: ["Не более 500 кг", "Не более 1000 кг", "Свыше 1000 кг"], answer: "Свыше 1000 кг", image: "halloween17.jpeg", levelOfdifficulty: .easy),
        Question(question: "Из какого овоща вырезали фонарики до того, как в этой роли стала популярна тыква?", choices: ["Из репы", "Из огурца", "Из кабачка"], answer: "Из репы", image: "halloween18.jpeg", levelOfdifficulty: .normal),
        Question(question: "Как называется группа ведьм?", choices: ["Ковен", "Овен", "Колен"], answer: "Ковен", image: "halloween19.jpeg", levelOfdifficulty: .hard),
        Question(question: "Тыквы бывают далеко не только оранжевые. Но какого цвета они не могут быть?", choices: ["Черного", "Зеленого", "Перламутрового"], answer: "Перламутрового", image: "halloween20.jpeg", levelOfdifficulty: .easy)
    ]
        
    }
}


