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
    
    var currentquiz: QuizBaseViewModel?
    
    var viewModel = QuizBaseViewModel()
    var categoryViewModel = CategoriesViewModel()
    
    var icon = ""
    var score = 0
    var questionNumber = 0
    
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
        categoryViewModel.goToQuize(quiz: currentquiz ?? QuizPlanets(), storyboard: self.storyboard, view: self.view)
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
            cell.CurrentImage.image = UIImage(named: "planets.jpeg")
            cell.CurrentScore.text = "счет: \(score)/100"
            cell.CurrentQuestion.text = "вопрос: \(questionNumber)/20"
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