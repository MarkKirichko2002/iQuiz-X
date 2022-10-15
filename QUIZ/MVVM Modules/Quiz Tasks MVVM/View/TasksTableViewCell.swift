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
    var animation = AnimationClass()
    
    @IBOutlet weak var TaskText: UILabel!
    @IBOutlet weak var TaskImage: UIImageView!
    @IBOutlet weak var TaskStatus: UILabel!
    
    func didSelect(indexPath: IndexPath) {
        animation.springImage(image: TaskImage)
        animation.springLabel(label: TaskText)
        animation.springLabel(label: TaskStatus)
    }
    
}
