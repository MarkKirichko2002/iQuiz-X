//
//  TasksTableViewCell.swift
//  QUIZ
//
//  Created by Марк Киричко on 20.02.2022.
//

import UIKit
import Firebase

class TasksTableViewCell: UITableViewCell {
    
    static let identifier = "TasksTableViewCell"
    private let animation = AnimationClass()
    var delegate: CustomViewCellDelegate?
    
    @IBOutlet weak var TaskText: UILabel!
    @IBOutlet weak var TaskImage: RoundedImageView!
    @IBOutlet weak var TaskStatus: UILabel!
    
    func ConfigureCell(task: QuizTaskModel) {
        TaskImage.image = UIImage(named: task.image)
        TaskImage.sound = task.sound
        TaskImage.color = .white
        TaskText.text = task.name
        contentView.backgroundColor = UIColor(patternImage: UIImage(named: task.background)!)
        switch task.complete {
        case true:
            TaskStatus.text = "пройдено"
            TaskStatus.textColor = .systemGreen
        case false:
            TaskStatus.text = "не пройдено"
            TaskStatus.textColor = .white
        }
    }
    
    func didSelect(indexPath: IndexPath) {
        animation.springImage(image: TaskImage)
        animation.springLabel(label: TaskText)
        animation.springLabel(label: TaskStatus)
        delegate?.didElementClick()
    }
    
}
