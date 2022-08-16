//
//  QuizSwift.swift
//  QUIZ
//
//  Created by Марк Киричко on 07.04.2022.
//

import Foundation

class QuizSwift: QuizBaseViewModel {
    
    
    override func ids() -> [QuizModel] {
        return [QuizModel(name: "Swift", image: "swift.jpeg", complete: false, id: 15, score: 0)]
    }
     
    override func questions() -> [Question] {
        return [
        Question(question: "Из-за какой строки данный код не скомпилируется?", choices: ["5", "4", "3"], answer: "5", image: "Swift1.jpeg", levelOfdifficulty: .easy),
        Question(question: " Чем отличается class от structure?", choices: ["Классы могут быть расширены с помощью extended, а структуры – нет", "Классы представляют собой типы значений, а структуры являются ссылочными типами", "В классах есть наследование. Структуры не поддерживают наследование"], answer: "В классах есть наследование. Структуры не поддерживают наследование", image: "Swift2.jpeg", levelOfdifficulty: .normal),
        Question(question: "Сколько элементов в массиве result?", choices: ["4", "7", "3"], answer: "4", image: "Swift3.jpeg", levelOfdifficulty: .hard),
        Question(question: "Сколько строк выведут циклы for?", choices: ["2 и 3", "3 и 2", "4 и 2"], answer: "3 и 2", image: "Swift4.jpeg", levelOfdifficulty: .easy),
        Question(question: "Какой тип данных будет у mySeason после выполнения следующего кода?", choices: ["(String, String)", "[String, String]", "(String)"], answer: "(String, String)", image: "Swift5.jpeg", levelOfdifficulty: .normal),
        Question(question: "Каково значение переменной animal?", choices: ["cat", "Код не скомпилируется", "dog"], answer: "cat", image: "Swift6.jpeg", levelOfdifficulty: .hard),
        Question(question: "Что выведет данный код?", choices: ["3", "45", "15"], answer: "15", image: "Swift7.jpeg", levelOfdifficulty: .easy),
        Question(question: "Что выведет следующий код?", choices: ["5", "150", "10"], answer: "150", image: "Swift8.jpeg", levelOfdifficulty: .normal),
        Question(question: "Что не является условием компиляции в Swift?", choices: ["#if os", "#if compiler", "#if platform"], answer: "#if platform", image: "Swift9.jpeg", levelOfdifficulty: .hard),
        Question(question: "Какое из перечисленных высказываний истинно?", choices: ["Протоколы могут быть приняты классами, но не структурами.", "Протоколы могут быть приняты классами и структурами.", "В Swift 5 нельзя использовать протоколы."], answer: "Протоколы могут быть приняты классами и структурами.", image: "Swift10.jpeg", levelOfdifficulty: .easy),
        Question(question: "Сколько циклов существует в Swift?", choices: ["1", "2", "3"], answer: "3", image: "Swift11.jpeg", levelOfdifficulty: .easy),
        Question(question: "Какая библиотека используется для создания игр?", choices: ["SpriteKit", "GameplayKit", "GameplayKit и SpriteKit"], answer: "GameplayKit и SpriteKit", image: "Swift12.jpeg", levelOfdifficulty: .normal),
        Question(question: "Чем отличаются операторы break и continue?", choices: ["Они используются в разных циклах", "Continue - пропускает итерацию, break - выходит из цикла", "Break - пропускает итерацию, continue - выходит из цикла"], answer: "Continue - пропускает итерацию, break - выходит из цикла", image: "Swift13.jpeg", levelOfdifficulty: .hard),
        Question(question: "Где правильно создана переменная?", choices: ["var x = 2.56 : Float", "float x = 2.56", "var x : Float = 2.56"], answer: "var x : Float = 2.56", image: "Swift14.jpeg", levelOfdifficulty: .easy),
        Question(question: "Какой результат будет выведен?", choices: ["Жилищный этаж и Буфет", "Крыша", "Буфет"], answer: "Жилищный этаж и Буфет", image: "Swift15.jpeg", levelOfdifficulty: .normal),
        Question(question: "Что покажет этот код?", choices: ["Будет выведено - Переменная равна - false", "Будет выведено - Переменная равна - true", "В коде есть ошибка и ничего не сработает"], answer: "Будет выведено - Переменная равна - false", image: "Swift16.jpeg", levelOfdifficulty: .hard),
        Question(question: "Какая библиотека нужна для создания пользовательского интерфейса?", choices: ["SpriteKit", "UI", "UIKit"], answer: "UIKit", image: "Swift17.jpeg", levelOfdifficulty: .easy),
        Question(question: "Какой результат покажет эта проверка", choices: ["Не сработало", "Выдаст ошибку", "Сработало"], answer: "Сработало", image: "Swift18.jpeg", levelOfdifficulty: .normal),
        Question(question: "Что можно создавать на Swift?", choices: ["Приложения на телефоны и планшеты (iPhone, iPad)", "Игры и ПО для всех устройств", "Игры и ПО для всей продукции Apple"], answer: "Игры и ПО для всей продукции Apple", image: "Swift19.jpeg", levelOfdifficulty: .hard),
        Question(question: "Где неправильно добавляются элементы в массив?", choices: ["Все варианты верные", "digits[0] = 0.5", "digits += [8.23, 5, 2.96]"], answer: "Все варианты верные", image: "Swift20.jpeg", levelOfdifficulty: .easy)
    ]
        
    }
}














