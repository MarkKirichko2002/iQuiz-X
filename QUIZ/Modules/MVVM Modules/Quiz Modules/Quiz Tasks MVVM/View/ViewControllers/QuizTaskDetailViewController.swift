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
    private let categoriesViewModel = CategoriesViewModel()
    
    @IBOutlet weak var TaskIcon: RoundedImageView!
    @IBOutlet weak var TaskName: UILabel!
    @IBOutlet weak var TaskCompleteStatus: UILabel!
    @IBOutlet weak var StartTaskButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let task = self.task else {return}
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: task.background)!)
        self.categoriesViewModel.view = self.view
        self.categoriesViewModel.storyboard = self.storyboard
        TaskIcon.image = UIImage(named: task.image)
        TaskIcon.color = UIColor.white
        TaskIcon.sound = task.sound
        TaskName.textColor = UIColor.white
        TaskName.text = task.name
        TaskCompleteStatus.textColor = .white
        StartTaskButton.tintColor = UIColor.white
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
        animation.springButton(button: self.StartTaskButton)
        animation.springImage(image: self.TaskIcon)
        animation.springLabel(label: self.TaskName)
        player.StopSound(resource: category.music)
        player.PlaySound(resource: category.sound)
        self.animation.StopRotateImage(image: self.TaskIcon)
        categoriesViewModel.GoToStart(quiz: category.base, category: category)
    }
}
