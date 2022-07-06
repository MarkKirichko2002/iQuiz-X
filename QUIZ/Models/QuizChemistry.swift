//
//  QuizChemistry.swift
//  QUIZ
//
//  Created by Марк Киричко on 15.03.2022.
//

import Foundation

class QuizChemistry: QuizBase {
    
    override func ids() -> [QuizModel] {
        return [QuizModel(name: "химия", image: "chemistry.jpeg", complete: false, id: 11, score: 0)]
    }
     
    override func questions() -> [Question] {
        return [
        Question(question: "Во время первой мировой войны этот газ применяли как химическое оружие.", choices: ["угарный газ", "этилен", "хлор"], answer: "хлор", image: "chemistry1.jpeg", levelOfdifficulty: .easy),
        Question(question: "Эти два металла чаще всего встречаются при анализе земной коры.", choices: ["титан, марганец", "железо, алюминий", "магний, железо"], answer: "железо, алюминий", image: "chemistry2.jpeg", levelOfdifficulty: .normal),
        Question(question: "Соединение этого галогена, 35-го элемента в периодической таблице, успокаивает нервную систему.", choices: ["бром", "мышьяк", "неон"], answer: "бром", image: "chemistry3.jpeg", levelOfdifficulty: .hard),
        Question(question: "Сколько элементов в таблице Менделеева на сегодняшний день?", choices: ["102", "115", "118"], answer: "118", image: "chemistry4.jpeg", levelOfdifficulty: .easy),
        Question(question: "Что означает К в периодической таблице?", choices: ["кальций", "калий", "кадмий"], answer: "калий", image: "chemistry5.jpeg", levelOfdifficulty: .normal),
        Question(question: "Какое вещество гасят водой, хотя ему не свойственно гореть.", choices: ["карбид кальция", "оксид кальция", "карбонат кальция"], answer: "оксид кальция", image: "chemistry6.jpeg", levelOfdifficulty: .hard),
        Question(question: "В каком году Таблица Менделеева была опубликована впервые?", choices: ["1835", "1869", "1909"], answer: "1869", image: "chemistry7.jpeg", levelOfdifficulty: .easy),
        Question(question: "Процесс отдачи и присоединения электронов называется...", choices: ["окисление и восстановление", "коррозия", "химическая реакция"], answer: "окисление и восстановление", image: "chemistry8.jpeg", levelOfdifficulty: .normal),
        Question(question: "Этот элемент называют элементом жизни и смерти.", choices: ["титан", "азот", "сера"], answer: "азот", image: "chemistry9.jpeg", levelOfdifficulty: .hard),
        Question(question: "Как называется газ, который поддерживает горение?", choices: ["водород", "кислород", "хлор"], answer: "кислород", image: "chemistry10.jpeg", levelOfdifficulty: .easy),
        Question(question: "В молекуле азота количество общих электронных пар...", choices: ["Одна", "Две", "Три"], answer: "Три", image: "chemistry11.jpeg", levelOfdifficulty: .easy),
        Question(question: "В соединении K2S химическая связь...", choices: ["Металлическая", "Ионная", "Ковалентная полярная"], answer: "Ионная", image: "chemistry12.jpeg", levelOfdifficulty: .normal),
        Question(question: "Выберите формулу вещества с двойной химической связью.", choices: ["Cl2", "H2", "S2"], answer: "S2", image: "chemistry13.jpeg", levelOfdifficulty: .hard),
        Question(question: "Вещество с ковалентной неполярной связью:", choices: ["H2", "NaH", "HCl"], answer: "H2", image: "chemistry14.jpeg", levelOfdifficulty: .easy),
        Question(question: "Укажите неправильное утверждение.", choices: ["Водородная связь присутствует в молекулах белков", "Водородная связь прочная", "Водородная связь бывает межмолекулярной и внутримолекулярной"], answer: "Водородная связь прочная", image: "chemistry15.jpeg", levelOfdifficulty: .normal),
        Question(question: "Наиболее электроотрицательным элементом является...", choices: ["Фтор", "Водород", "Хлор"], answer: "Фтор", image: "chemistry16.jpeg", levelOfdifficulty: .hard),
        Question(question: "Самый легкий газ это ...", choices: ["Водород", "Азот", "Метан"], answer: "Водород", image: "chemistry17.jpeg", levelOfdifficulty: .easy),
        Question(question: "Металл, без которого не сможет образовываться хлорофилл.", choices: ["Натрий", "Магний", "Калий"], answer: "Магний", image: "chemistry18.jpeg", levelOfdifficulty: .normal),
        Question(question: "Кристаллогидраты - это твердые вещества, которые…", choices: ["Содержат связанную воду", "Не растворяются в воде", "Растворяются в воде"], answer: "Содержат связанную воду", image: "chemistry19.jpeg", levelOfdifficulty: .hard),
        Question(question: "Какие вещества не проводят электрический ток?", choices: ["Оксиды", "Щелочи", "Кислоты"], answer: "Оксиды", image: "chemistry20.jpeg", levelOfdifficulty: .easy)
    ]
    
    }
}










