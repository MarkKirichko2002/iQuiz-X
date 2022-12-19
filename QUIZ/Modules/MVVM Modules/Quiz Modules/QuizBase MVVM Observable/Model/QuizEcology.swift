//
//  QuizEcology.swift
//  QUIZ
//
//  Created by Марк Киричко on 03.03.2022.
//

import Foundation

class QuizEcology: QuizBaseViewModel {
    
    override func questions() -> [Question] {
        return [
        Question(question: "Экология - это...", choices: ["Совокупность наук о строении Земли, её происхождении и развитии", "Наука о взаимодействиях живых организмов между собой и с их средой обитания", "Наука о жизни, существовавшей до начала голоценовой эпохи или в её начале в прошлые геологические периоды"], answer: "Наука о взаимодействиях живых организмов между собой и с их средой обитания", image: "ecology1.jpeg", levelOfdifficulty: .easy),
        Question(question: "Кто предложил термин «Экология»:", choices: ["Чарльз Дарвин", "Эрнст Геккель", "Карл Линней"], answer: "Эрнст Геккель", image: "ecology2.jpeg", levelOfdifficulty: .normal),
        Question(question: "Как называется книга, где публикуется список животных, вымерших после 1500 года?", choices: ["Красная книга", "Мертвая книга", "Черная книга"], answer: "Черная книга", image: "ecology3.jpeg", levelOfdifficulty: .hard),
        Question(question: "Что из перечисленных видов мусора разлагается 1000 лет?", choices: ["Стекло", "Пластик", "Полиэтилен"], answer: "Стекло", image: "ecology4.jpeg", levelOfdifficulty: .easy),
        Question(question: "Какое из этих животных не находится на грани вымирания?", choices: ["Амурский тигр", "Пятнистый олень", "Бабуин"], answer: "Бабуин", image: "ecology5.jpeg", levelOfdifficulty: .normal),
        Question(question: "Как называется участок, где оберегаются и размножаются редкие и ценные растения, животные?", choices: ["Пуща", "Заповедник", "Лес"], answer: "Заповедник", image: "ecology6.jpeg", levelOfdifficulty: .hard),
        Question(question: "Как называется самое грязное озеро в России?", choices: ["Ильмень", "Сегозеро", "Карачай"], answer: "Карачай", image: "ecology7.jpeg", levelOfdifficulty: .easy),
        Question(question: "Как называется сообщество, призывающее всех перестать разрушать экологию и прекратить размножаться?", choices: ["Движение за добровольное вымирание человечества", "Всемирное общество охраны природы от людей", "Международный Зелёный Крест"], answer: "Движение за добровольное вымирание человечества", image: "ecology8.jpeg", levelOfdifficulty: .normal),
        Question(question: "Что изображено на картинке?", choices: ["Спутниковые антенны", "Светоотражатели", "Солнечные батареи"], answer: "Солнечные батареи", image: "ecology9.jpeg", levelOfdifficulty: .hard),
        Question(question: "Какое из этих животных не находится на грани вымирания?", choices: ["Лесная соня", "Аддакс", "Беломордый дельфин"], answer: "Аддакс", image: "ecology10.jpeg", levelOfdifficulty: .easy),
        Question(question: "Какая из стран стоит на первом месте в мире по «производству» мусора?", choices: ["Канада", "Япония", "Египет"], answer: "Канада", image: "ecology11.jpeg", levelOfdifficulty: .easy),
        Question(question: "Какое утверждение о воде не является верным?", choices: ["Льды Гренландии содержат 20% всей пресной воды планеты", "Загрязнение воды является причиной гибели на Земле 14 000 человек в день", "Заболоченные территории составляют 1,5% от поверхности планеты"], answer: "Заболоченные территории составляют 1,5% от поверхности планеты", image: "ecology12.jpeg", levelOfdifficulty: .normal),
        Question(question: "Каков процент содержания азота в воздухе?", choices: ["20.93%", "78.09%", "54.13%"], answer: "78.09%", image: "ecology13.jpeg", levelOfdifficulty: .hard),
        Question(question: "Какой из экологических факторов не относится к абиотическим?", choices: ["вырубка леса", "климат", "рельеф"], answer: "вырубка леса", image: "ecology14.jpeg", levelOfdifficulty: .easy),
        Question(question: "Как называются растения, создающие органическое вещество из неорганического с помощью окружающей среды?", choices: ["продуценты", "редуценты", "консументы"], answer: "продуценты", image: "ecology15.jpeg", levelOfdifficulty: .normal),
        Question(question: "К какой группе природных ресурсов относятся нефть, газ, торф?", choices: ["минерально-сырьевые", "энергетические", "водные"], answer: "энергетические", image: "ecology16.jpeg", levelOfdifficulty: .hard),
        Question(question: "Что не относится к физическим загрязнителям окружающей природной среды?", choices: ["шум", "электромагнитные", "радиоактивные выбросы"], answer: "радиоактивные выбросы", image: "ecology17.jpeg", levelOfdifficulty: .easy),
        Question(question: "Где сосредоточены самые большие запасы пресной воды?", choices: ["полярные льды, ледники", "реки", "озера"], answer: "полярные льды, ледники", image: "ecology18.jpeg", levelOfdifficulty: .normal),
        Question(question: "Какой процент поверхности планеты (приблизительно) занимает мировой океан?", choices: ["20%", "70%", "90%"], answer: "70%", image: "ecology19.jpeg", levelOfdifficulty: .hard),
        Question(question: "Что не является объектом международно-правовой охраны окружающей природной среды?", choices: ["воздушный бассейн", "космос", "животный мир"], answer: "животный мир", image: "ecology20.jpeg", levelOfdifficulty: .easy)
    ]
    
    }
}








