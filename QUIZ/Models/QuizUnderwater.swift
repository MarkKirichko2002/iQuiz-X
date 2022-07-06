//
//  QuizUnderwater.swift
//  QUIZ
//
//  Created by Марк Киричко on 30.06.2022.
//

import Foundation

class QuizUnderwater: QuizBase {
    
    override func ids() -> [QuizModel] {
        return [QuizModel(name: "подводный мир", image: "underwater.png", complete: false, id: 16, score: 0)]
    }
     
    override func questions() -> [Question] {
        return [
        Question(question: "Как называется эта рыба?", choices: ["Морской окунь", "Морской карась", "Треска"], answer: "Морской окунь", image: "underwater1.jpeg", levelOfdifficulty: .easy),
        Question(question: "Что за существо изображено на фото?", choices: ["Мидия", "Морской конек", "Устрица"], answer: "Морской конек", image: "underwater2.jpeg", levelOfdifficulty: .normal),
        Question(question: "Этот обитатель морей способен проглотить добычу крупнее самого себя, при этом у него сильно растягивается желудок. Что это за рыба?", choices: ["Морской черт", "Черный живоглот", "Бурый мешкобрюх"], answer: "Черный живоглот", image: "underwater3.jpeg", levelOfdifficulty: .hard),
        Question(question: "Что за рыба изображена на фото?", choices: ["Сайра", "Треска", "Форель"], answer: "Треска", image: "underwater4.jpeg", levelOfdifficulty: .easy),
        Question(question: "Правда ли что рыба парусник может развивать скорость более 100 км/ч?", choices: ["да", "нет", "-"], answer: "да", image: "underwater5.jpeg", levelOfdifficulty: .normal),
        Question(question: "Как называется животное изображенное на фото?", choices: ["Белая акула", "Акула-самолет", "Акула-молот"], answer: "Акула-молот", image: "underwater6.jpeg", levelOfdifficulty: .hard),
        Question(question: "На фото изображен дельфин Иния. Правдали что эти животные не обитают в морях и являются пресноводными?", choices: ["да", "нет", "-"], answer: "да", image: "underwater7.jpeg", levelOfdifficulty: .easy),
        Question(question: "Что за рыба изображена на фото?", choices: ["Сельдь", "Треска", "Скумбрия"], answer: "Сельдь", image: "underwater8.jpeg", levelOfdifficulty: .normal),
        Question(question: "Как называется эта огромная рыба изображенная на фото?", choices: ["Фугу", "Рыба-луна", "Рыба-попугай"], answer: "Рыба-луна", image: "underwater9.jpeg", levelOfdifficulty: .hard),
        Question(question: "Как называется рыба изображенная на фото?", choices: ["Рыба-капля", "Латимерия", "Рыба-луна"], answer: "Рыба-капля", image: "underwater10.jpeg", levelOfdifficulty: .easy),
        Question(question: "Правда ли что летучая рыба может выпрыгивать из воды и пролетать над водой по воздуху расстояние более 50 метров?", choices: ["Эта рыба может пролетать расстояния не более 3 метров", "Да это правда", "Нет, эта рыба не летает"], answer: "Да это правда", image: "underwater11.jpeg", levelOfdifficulty: .easy),
        Question(question: "Кто или что изображено на фото?", choices: ["Морская губка", "Водоросль спирулина", "Водоросль ламинария"], answer: "Морская губка", image: "underwater12.jpeg", levelOfdifficulty: .normal),
        Question(question: "Кто изображен на фото?", choices: ["Кальмар", "Осьминог", "Каракатица"], answer: "Осьминог", image: "underwater13.jpeg", levelOfdifficulty: .hard),
        Question(question: "Почему дельфины спят с одним открытым глазом?", choices: ["Чтобы следить за хищниками и другими угрозами", "Чтобы не удариться об камни во сне", "другой вариант ответа"], answer: "Чтобы следить за хищниками и другими угрозами", image: "underwater14.jpeg", levelOfdifficulty: .easy),
        Question(question: "Медузы появились раньше акул и даже динозавров. Это правда или ложь?", choices: ["Ложь", "Правда", "-"], answer: "Правда", image: "underwater15.jpeg", levelOfdifficulty: .normal),
        Question(question: "Какая самая крупная хищная рыба в океане?", choices: ["Белая акула", "Китовая акула", "Акула-молот"], answer: "Белая акула", image: "underwater16.jpeg", levelOfdifficulty: .hard),
        Question(question: "Скаты - близкие родственники...", choices: ["Акул", "Осьминогов", "другой вариант ответа"], answer: "Акул", image: "underwater17.jpeg", levelOfdifficulty: .easy),
        Question(question: "Косатка - это...", choices: ["Кит", "Дельфин", "другой вариант ответа"], answer: "Дельфин", image: "underwater18.jpeg", levelOfdifficulty: .normal),
        Question(question: "Правда или ложь: синий кит издает самый громкий звук в мире", choices: ["Правда", "Ложь", "-"], answer: "Правда", image: "underwater19.jpeg", levelOfdifficulty: .hard),
        Question(question: "Эта рыба обитает в самых глубоких местах океана. Как она называется?", choices: ["Саблезуб", "Морской черт", "другой вариант ответа"], answer: "Саблезуб", image: "underwater20.jpeg", levelOfdifficulty: .easy)
    ]
        
    }
}
















