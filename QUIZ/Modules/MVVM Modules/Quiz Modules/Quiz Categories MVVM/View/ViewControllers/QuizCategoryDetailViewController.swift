//
//  QuizCategoryDetailViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 04.12.2022.
//

import Foundation
import UIKit

final class QuizCategoryDetailViewController: UIViewController {
    
    @IBOutlet weak var CategoryIcon: RoundedImageView!
    @IBOutlet weak var CategoryName: UILabel!
    @IBOutlet weak var CompleteStatus: UILabel!
    @IBOutlet weak var CategoryScore: UILabel!
    @IBOutlet weak var PlayButton: UIButton!
    
    var category: QuizCategoryModel?
    var player = SoundClass()
    private let categoriesViewModel = CategoriesViewModel()
    private let animation = AnimationClass()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let category = self.category else {return}
        categoriesViewModel.view = self.view
        categoriesViewModel.storyboard = self.storyboard
        view?.backgroundColor = UIColor(patternImage: UIImage(named: category.background)!)
        CategoryIcon.image = UIImage(named: category.image)
        CategoryIcon.color = .white
        CategoryIcon.sound = category.sound
        CategoryName.textColor = .white
        CategoryName.text = category.name
        CategoryScore.textColor = .white
        CategoryScore.text = "\(category.score)/100"
        CompleteStatus.textColor = .white
        PlayButton.tintColor = .white
        switch category.complete {
            
        case true:
            CompleteStatus.text = "пройдено"
            CompleteStatus.textColor = .systemGreen
            
        case false:
            CompleteStatus.text = "не пройдено"
            CompleteStatus.textColor = .systemGray
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let category = self.category else {return}
        self.player.PlaySound(resource: category.music)
    }
    
    @IBAction func PlayQuiz() {
        guard let category = self.category else {return}
        animation.springImage(image: self.CategoryIcon)
        animation.springLabel(label: self.CategoryName)
        animation.springButton(button: self.PlayButton)
        player.StopSound(resource: category.music)
        player.PlaySound(resource: category.sound)
        categoriesViewModel.GoToStart(quiz: category.base, category: category)
    }
}
