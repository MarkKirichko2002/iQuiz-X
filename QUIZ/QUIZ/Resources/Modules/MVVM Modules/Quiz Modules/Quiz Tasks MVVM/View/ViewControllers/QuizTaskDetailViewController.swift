//
//  QuizTaskDetailViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 04.01.2023.
//

import Foundation
import UIKit

final class QuizTaskDetailViewController: UIViewController {
    
    var task: QuizTaskModel?
    var category: QuizCategoryModel?
    private let player = SoundClass()
    private let animation = AnimationClass()
    private let quizCategoriesViewModel = QuizCategoriesViewModel()
    
    @IBOutlet weak var TaskIcon: RoundedImageView!
    @IBOutlet weak var TaskName: UILabel!
    @IBOutlet weak var TaskCompleteStatus: UILabel!
    @IBOutlet weak var StartTaskButton: UIButton!
    @IBOutlet weak var CloseButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let task = self.task else {return}
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: task.background)!)
        self.quizCategoriesViewModel.view = self.view
        self.quizCategoriesViewModel.storyboard = self.storyboard
        TaskIcon.image = UIImage(named: task.image)
        TaskIcon.color = UIColor.white
        TaskIcon.sound = task.sound
        TaskName.textColor = UIColor.white
        TaskName.text = task.name
        TaskCompleteStatus.textColor = UIColor.white
        StartTaskButton.tintColor = UIColor.white
        CloseButton.tintColor = UIColor.white
        switch task.complete {
        case true:
            TaskCompleteStatus.text = "пройдено"
            
        case false:
            TaskCompleteStatus.text = "не пройдено"
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let category = self.category else {return}
        self.player.PlaySound(resource: category.music)
        self.animation.StartRotateImage(image: self.TaskIcon)
    }
    
    @IBAction func StartTask() {
        guard let category = self.category else {return}
        animation.SpringAnimation(view: self.StartTaskButton)
        animation.SpringAnimation(view: self.TaskIcon)
        animation.SpringAnimation(view: self.TaskName)
        player.StopSound(resource: category.music)
        player.PlaySound(resource: category.sound)
        self.animation.StopRotateImage(image: self.TaskIcon)
        quizCategoriesViewModel.GoToStart(quiz: category.base, category: category)
    }
    
    @IBAction func CloseDetailScreen() {
        guard let task = self.task else {return}
        self.animation.SpringAnimation(view: self.CloseButton)
        self.player.PlaySound(resource: task.sound)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.dismiss(animated: true)
        }
    }
}
