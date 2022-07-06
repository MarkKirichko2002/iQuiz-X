//
//  QuizGames.swift
//  QUIZ
//
//  Created by Марк Киричко on 18.02.2022.
//

import Foundation

class QuizGames : QuizBase {
    
    override func ids() -> [QuizModel] {
        return [QuizModel(name: "игры", image: "games.jpeg", complete: false, id: 5, score: 0)]
    }
    
    override func questions() -> [Question] {
        return [
            Question(question: "Из какой игры это изображение?", choices: ["Warcraft", "Dota 2", "  Dota"], answer: "Warcraft", image: "games1.jpeg", levelOfdifficulty: .easy),
            Question(question: "Из какой игры это изображение?", choices: ["Among the Sleep", "Cry of Fear", "Slender: The Arrival"], answer: "Slender: The Arrival", image: "games2.jpeg", levelOfdifficulty: .normal),
            Question(question: "Из какой игры это изображение?", choices: ["Amnesia: The Dark Descent", "Resident Evil 7", "The Evil Within"], answer: "Resident Evil 7", image: "games3.jpeg", levelOfdifficulty: .hard),
            Question(question: "Из какой игры это изображение?", choices: ["Among the Sleep", "Five Nights at Freddy's", "Daylight"], answer: "Five Nights at Freddy's", image: "games4.jpeg", levelOfdifficulty: .easy),
            Question(question: "Из какой игры это изображение?", choices: ["The Evil Within", "Outlast 2", "Cry of Fear"], answer: "Outlast 2", image: "games5.jpeg", levelOfdifficulty: .normal),
            Question(question: "Из какой игры это изображение?", choices: ["Witcher 3", "Middle-earth: Shadow of War", "Cyberpunk 2077"], answer: "Witcher 3", image: "games6.jpeg", levelOfdifficulty: .hard),
            Question(question: "Из какой игры это изображение?", choices: ["Dragon Age", "The Elder Scrolls V: Skyrim", "Diablo III"], answer: "Dragon Age", image: "games7.jpeg", levelOfdifficulty: .easy),
            Question(question: "Из какой игры это изображение?", choices: ["Sid Meier’s Civilization V", "Might & Magic Heroes VII", "Final Fantasy XV"], answer: "Might & Magic Heroes VII", image: "games8.jpeg", levelOfdifficulty: .normal),
            Question(question: "Из какой игры это изображение?", choices: ["Mass Effect", "BioShock Infinite", "StarCraft II: Wings of Liberty"], answer: "StarCraft II: Wings of Liberty", image: "games9.jpeg", levelOfdifficulty: .hard),
            Question(question: "Из какой игры это изображение?", choices: ["Fallout: New Vegas", "S.T.A.L.K.E.R.: Call of Pripyat", "Metro: Last Light"], answer: "S.T.A.L.K.E.R.: Call of Pripyat", image: "games10.jpeg", levelOfdifficulty: .easy),
            Question(question: "Что это за игра?", choices: ["Tron", "Space Invaders", "Missile Command"], answer: "Space Invaders", image: "games11.jpeg", levelOfdifficulty: .easy),
            Question(question: "Что это за игра?", choices: ["Duke Nukem 3D", "Zero Tolerance", "Mappy"], answer: "Zero Tolerance", image: "games12.jpeg", levelOfdifficulty: .normal),
            Question(question: "Что это за игра?", choices: ["Darkwing Duck", "Teenage Mutant Ninja Turtles", "Prince of persia"], answer: "Teenage Mutant Ninja Turtles", image: "games13.jpeg", levelOfdifficulty: .hard),
            Question(question: "Что это за игра?", choices: ["Battle city", "Space Invaders", "Berzerk"], answer: "Battle city", image: "games14.jpeg", levelOfdifficulty: .easy),
            Question(question: "Что это за игра?", choices: ["Donkey Kong", "Jungle Hunt", "Super Mario Bros."], answer: "Donkey Kong", image: "games15.jpeg", levelOfdifficulty: .normal),
            Question(question: "Какой чит-код снимал уровень розыска в GTA: San Andreas?", choices: ["ASNAED", "OSRBLHH", "ROCKETMAN"], answer: "ASNAED", image: "games16.jpeg", levelOfdifficulty: .hard),
            Question(question: "Из какой игры фрагмент этого скриншота?", choices: ["Diablo", "Fallout", "Might and Magic"], answer: "Fallout", image: "games17.jpeg", levelOfdifficulty: .easy),
            Question(question: "Какая необычная способность была у героя Driver: San Francisco?", choices: ["Стрельба по колесам", "Переселение души", "Прогулки по городу"], answer: "Переселение души", image: "games18.jpeg", levelOfdifficulty: .normal),
            Question(question: "Какого оружия не было в Quake 2?", choices: ["Рукавица", "BFG-10K", "Дробовик"], answer: "Рукавица", image: "games19.jpeg", levelOfdifficulty: .hard),
            Question(question: "В The Neverhood герой искал специальные видеокассеты с рассказами Вилли Тромбона. Сколько кассет надо было найти?", choices: ["28", "20", "18"], answer: "20", image: "games20.jpeg", levelOfdifficulty: .easy)
        ]
    }
}




