//
//  PauseTableViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 04.05.2022.
//

import UIKit
import SCLAlertView
import AVFoundation

class PauseTableViewController: UITableViewController {
    
    var currentquiz = UserDefaults.standard.object(forKey: "currentquiz") as? Int
    
    var timer = Timer()
    
    var player = SoundClass()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UserDefaults.standard.set(false, forKey: "music")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func exit() {
        DispatchQueue.main.async {
            guard let vc = self.storyboard?.instantiateViewController(identifier: "ViewController") else {return}
            guard let window = self.view.window else {return}
            window.rootViewController = vc
            UserDefaults.standard.set(false, forKey: "music")
        }
    }
    
    func restart() {
        
        switch currentquiz {
            
        case 1: RestartQuiz(quiz: QuizPlanets())
            
        case 2: RestartQuiz(quiz: QuizHistory())
            
        case 3: RestartQuiz(quiz: QuizAnatomy())
            
        case 4: RestartQuiz(quiz: QuizSport())
            
        case 5: RestartQuiz(quiz: QuizGames())
            
        case 6: RestartQuiz(quiz: QuizIQ())
            
        case 7: RestartQuiz(quiz: QuizEconomy())
            
        case 8: RestartQuiz(quiz: QuizGeography())
            
        case 9: RestartQuiz(quiz: QuizEcology())
            
        case 10: RestartQuiz(quiz: QuizPhysics())
            
        case 11: RestartQuiz(quiz: QuizChemistry())
            
        case 12: RestartQuiz(quiz: QuizInformatics())
            
        case 13: RestartQuiz(quiz: QuizLiterature())
            
        case 14: RestartQuiz(quiz: QuizRoadTraffic())
            
        case 15: RestartQuiz(quiz: QuizSwift())
            
        case 16: RestartQuiz(quiz: QuizUnderwater())
           
        case 17: RestartQuiz(quiz: QuizChess())
        
        default: break
            
        }
    }
    
    
    func RestartQuiz(quiz: QuizBase) {
        DispatchQueue.main.async {
            guard let vc = self.storyboard?.instantiateViewController(identifier: "BaseQuizViewController") else {return}
            (vc as? BaseQuizViewController)?.setQuizeModel(quiz: quiz)
            guard let window = self.view.window else {return}
            window.rootViewController = vc
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch(indexPath.row) {
            
        case 0: print("category")
            
        case 1: print("restart")
                restart()
            
        case 2: print("exit")
                exit()
            
        default: break
            
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0  {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CurrentCategoryTableViewCell") as? CurrentCategoryTableViewCell
            else { return UITableViewCell() }
            cell.configure()
            return cell
            
        } else if indexPath.row == 1  {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RestartTableViewCell") as? RestartTableViewCell
            else { return UITableViewCell() }
            
            return cell
            
        } else if indexPath.row == 2  {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExitTableViewCell") as? ExitTableViewCell
            else { return UITableViewCell() }
            
            return cell
            
        } else {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExitTableViewCell") as? ExitTableViewCell
            else { return UITableViewCell() }
            
            //cell.configure(groupItems[indexPath.row])
            return cell
            
        }
    }
}
