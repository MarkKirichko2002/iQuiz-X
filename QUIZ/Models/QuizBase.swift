//
//  QuizBase.swift
//  QUIZ
//
//  Created by Марк Киричко on 20.02.2022.
//

import Foundation

class QuizBase {
    
    
    func questions() -> [Question] {
       return []
    }
    
    func ids() -> [QuizModel] {
        return []
    }
    
    var quiznumber = 0
    var questionNumber = 0;
    var score = 0;
    
    var quiz: QuizModel?
    
    init(){
    }
    
    func checkAnswer(_ userAnswer:String) -> Bool {
        print(userAnswer)
        print(questions()[questionNumber].answer)
        if userAnswer == questions()[questionNumber].answer{
            score+=1
            return true;
        }
        return false;
    }
    
    func checkQuestion() -> String {
        return questions()[questionNumber].question
    }
    
    func checkQuestionNumber() -> Int {
        return questionNumber + 1
    }
    
    func checkImage() -> String {
        return questions()[questionNumber].image
    }
    
    func checkAnswer() -> String {
        return questions()[questionNumber].answer
    }
    
    func checkChoices() -> [String] {
        return questions()[questionNumber].choices
    }
    
    func checkProgress() -> Float {
        return Float(questionNumber) / Float(questions().count);
    }
    
    
    func checkScore() -> Int {
        return score
    }
    
    func checkid() -> Int {
        return ids()[quiznumber].id
    }
    
    func checklevel() -> Question.levelOfdifficulty {
        return questions()[questionNumber].levelOfdifficulty
    }
    
    
    func nextQuiz(){
        quiznumber += 1
        if(quiznumber==ids().count){
            quiznumber=0
        }
    }
    
    func nextQuestion(){
        questionNumber += 1
        if(questionNumber==questions().count){
            questionNumber=0
            score = 0;
        }
    }
    
}


