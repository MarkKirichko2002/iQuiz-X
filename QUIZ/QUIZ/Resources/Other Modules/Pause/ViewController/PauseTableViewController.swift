//
//  PauseTableViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 04.05.2022.
//

import UIKit
import SCLAlertView
import AVFoundation

final class PauseTableViewController: UITableViewController {
    
    var category: QuizCategoryModel?
    
    private let quizBaseViewModel = QuizBaseViewModel()
    private let quizCategoriesViewModel = QuizCategoriesViewModel()
    
    var icon = ""
    var score = 0
    var questionNumber = 0
    
    private let player = SoundClass()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quizBaseViewModel.view = view
        quizBaseViewModel.storyboard = storyboard
        self.quizCategoriesViewModel.view = self.view
        self.quizCategoriesViewModel.storyboard = self.storyboard
        self.SetUpCells()
    }
    
    private func SetUpCells() {
        self.tableView.register(UINib(nibName: CurrentCategoryTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CurrentCategoryTableViewCell.identifier)
        self.tableView.register(UINib(nibName: RestartTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: RestartTableViewCell.identifier)
        self.tableView.register(UINib(nibName: ExitTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ExitTableViewCell.identifier)
    }
    
    private func restart() {
        DispatchQueue.main.async {
            self.category?.base.speechRecognition.cancelSpeechRecognition()
            self.category?.base.captureSession.stopRunning()
            self.category?.base.questionNumber = 0
            self.quizCategoriesViewModel.GoToStart(quiz: self.category?.base ?? QuizAstronomy(), category: self.category ?? QuizCategories.categories[0])
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch(indexPath.row) {
            
        case 0: print("category")
            
        case 1: print("restart")
            if let cell = tableView.cellForRow(at: indexPath) as? RestartTableViewCell {
                cell.didSelect(indexPath: indexPath)
            }
            restart()
            
        case 2: print("exit")
            if let cell = tableView.cellForRow(at: indexPath) as? ExitTableViewCell {
                cell.didSelect(indexPath: indexPath)
            }
            quizBaseViewModel.exit()
            
        default: break
            
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
            
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CurrentCategoryTableViewCell") as? CurrentCategoryTableViewCell
            else { return UITableViewCell() }
            cell.CurrentImage.image = UIImage(named: category?.image ?? "")
            cell.CurrentImage.color = .white
            cell.CurrentImage.sound = category?.sound ?? ""
            cell.CurrentName.text = category?.name
            cell.CurrentName.textColor = .white
            cell.CurrentScore.text = "счет: \(score)/100"
            cell.CurrentScore.textColor = .white
            cell.CurrentQuestion.text = "вопрос: \(questionNumber)/20"
            cell.CurrentQuestion.textColor = .white
            cell.contentView.backgroundColor = UIColor(patternImage: UIImage(named: category?.background ?? "")!)
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RestartTableViewCell") as? RestartTableViewCell
            else { return UITableViewCell() }
            return cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExitTableViewCell") as? ExitTableViewCell
            else { return UITableViewCell() }
            return cell
         
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExitTableViewCell") as? ExitTableViewCell
            else { return UITableViewCell() }
            return cell
        }
    }
}
