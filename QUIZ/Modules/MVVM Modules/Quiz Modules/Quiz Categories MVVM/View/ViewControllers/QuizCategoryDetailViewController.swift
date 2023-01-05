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
    @IBOutlet weak var VoiceCommandLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    
    var category: QuizCategoryModel?
    private let player = SoundClass()
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
        CategoryName.text = category.name
        CategoryName.textColor = .white
        CategoryScore.text = "\(category.score)/100"
        CategoryScore.textColor = .white
        VoiceCommandLabel.text = "Ваша голосовая команда: \n\"\(category.voiceCommand)\""
        VoiceCommandLabel.textColor = UIColor.white
        DateLabel.text = "Вы играли последний раз: \n🗓️ \(category.date)"
        DateLabel.textColor = UIColor.white
        PlayButton.tintColor = .white
        switch category.complete {
            
        case true:
            CompleteStatus.text = "пройдено"
            CompleteStatus.textColor = .systemGreen
            
        case false:
            CompleteStatus.text = "не пройдено"
            CompleteStatus.textColor = .systemGray
        }
        CompleteStatus.textColor = .white
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
