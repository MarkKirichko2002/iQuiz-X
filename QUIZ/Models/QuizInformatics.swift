//
//  QuizInformatics.swift
//  QUIZ
//
//  Created by Марк Киричко on 17.03.2022.
//

import Foundation

class QuizInformatics: QuizBase {
    
        
    override func ids() -> [QuizModel] {
        return [QuizModel(name: "информатика", image: "informatics.jpeg", complete: false, id: 12, score: 0)]
    }
     
    override func questions() -> [Question] {
        return [
        Question(question: "Кто ввел термин информатика?", choices: ["Карл Штейнбух", "Алан Тьюринг", "Чарлз Бэббидж"], answer: "Карл Штейнбух", image: "informatics1.jpeg", levelOfdifficulty: .easy),
        Question(question: "За обработку данных и все расчеты в компьютере отвечает...", choices: ["Оперативная память", "Процессор", "Видеокарта"], answer: "Процессор", image: "informatics2.jpeg", levelOfdifficulty: .normal),
        Question(question: "Какая комбинация клавиш вызывает диспетчер задач?", choices: ["Ctrl + Alt + Delete", "Ctrl+Alt+S", "Shift + CapsLock"], answer: "Ctrl + Alt + Delete", image: "informatics3.jpeg", levelOfdifficulty: .hard),
        Question(question: "Что такое кибернетика?", choices: ["Наука об искусственном интеллекте", "Наука об общих закономерностях процессов управления и передачи информации в машинах, живых организмах и обществе", "Система для работы с программами, файлами и оглавлениями данных на компьютере"], answer: "Наука об общих закономерностях процессов управления и передачи информации в машинах, живых организмах и обществе", image: "informatics4.jpeg", levelOfdifficulty: .easy),
        Question(question: "Окно в компьютере - это?", choices: ["Прямоугольная область на экране компьютера, которая служит для вывода информации", "Прикладное программное обеспечение для просмотра страниц, содержания веб-документов, а также для решения других задач", "Приложение, реализующее графический интерфейс доступа пользователя к файлам в операционной системе"], answer: "Прямоугольная область на экране компьютера, которая служит для вывода информации", image: "informatics5.jpeg", levelOfdifficulty: .normal),
        Question(question: "Какое окно считается активным?", choices: ["Первое из открытых", "Последнее из открытых", "То, в котором происходит работа"], answer: "То, в котором происходит работа", image: "informatics6.jpeg", levelOfdifficulty: .hard),
        Question(question: "Что из перечисленного не является операционной системой?", choices: ["Microsoft Windows", "Mac OS", "Avast Free"], answer: "Avast Free", image: "informatics7.jpeg", levelOfdifficulty: .easy),
        Question(question: "Что изображено на картинке?", choices: ["Видеокарта", "Кулер", "Блок питания"], answer: "Блок питания", image: "informatics8.jpeg", levelOfdifficulty: .normal),
        Question(question: "Что относится к единицам измерения информации?", choices: ["Ампер", "Герц", "Бит"], answer: "Бит", image: "informatics9.jpeg", levelOfdifficulty: .hard),
        Question(question: "Самым популярным языком программирования в мире на сегодня является...", choices: ["Java", "Pascal", "HTML"], answer: "Java", image: "informatics10.jpeg", levelOfdifficulty: .easy),
        Question(question: "Как называется группа файлов, которая хранится отдельной группой и имеет собственное имя ?", choices: ["Байт", "Каталог", "Дискета"], answer: "Каталог", image: "informatics11.jpeg", levelOfdifficulty: .easy),
        Question(question: "Как называются данные или программа на магнитном диске?", choices: ["Папка", "Файл", "Дискета"], answer: "Файл", image: "informatics12.jpeg", levelOfdifficulty: .normal),
        Question(question: "Выберите имя файла anketa с расширением txt.", choices: ["Anketa.txt.", "Anketa.txt", "Anketa/txt"], answer: "Anketa.txt", image: "informatics13.png", levelOfdifficulty: .hard),
        Question(question: "Что необходимо компьютеру для нормальной работы?", choices: ["Различные прикладные программы", "Операционная система", "Дискета в дисководе"], answer: "Операционная система", image: "informatics14.jpeg", levelOfdifficulty: .easy),
        Question(question: "Сколько окон может быть одновременно открыто?", choices: ["много", "одно", "два"], answer: "много", image: "informatics15.jpeg", levelOfdifficulty: .normal),
        Question(question: "Архивация файлов – это…", choices: ["Объединение нескольких файлов", "Разметка дисков на сектора и дорожки", "Сжатие файлов"], answer: "Сжатие файлов", image: "informatics16.png", levelOfdifficulty: .hard),
        Question(question: "Какая из программ является антивирусной программой?", choices: ["NDD", "DRWEB", "RAR"], answer: "DRWEB", image: "informatics17.jpeg", levelOfdifficulty: .easy),
        Question(question: "Первая ЭВМ называлась:", choices: ["ENIAC", "Macintosh", "Linux"], answer: "ENIAC", image: "informatics18.jpeg", levelOfdifficulty: .normal),
        Question(question: "Дисковод это устройство для:", choices: ["Чтения информации со съемного носителя", "Записи информации на запоминающее устройство", "Соединения с LAN"], answer: "Чтения информации со съемного носителя", image: "informatics19.png", levelOfdifficulty: .hard),
        Question(question: "Процессор обрабатывает информацию:", choices: ["В текстовом формате", "В двоичном коде", "На языке Pascal"], answer: "В двоичном коде", image: "informatics20.jpeg", levelOfdifficulty: .easy),
    ]
    
    }
}











