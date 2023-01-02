//
//  QuizCategoryDetailViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 04.12.2022.
//

import Foundation
import UIKit


class QuizCategoryDetailViewController: UIViewController {
    
    @IBOutlet weak var CategoryIcon: RoundedImageView!
    @IBOutlet weak var CategoryName: UILabel!
    @IBOutlet weak var CompleteStatus: UILabel!
    @IBOutlet weak var CategoryScore: UILabel!
    @IBOutlet weak var PlayButton: UIButton!
    
    var category: QuizCategoryModel?
    var player = SoundClass()
    var categoriesViewModel = CategoriesViewModel()
    var animation = AnimationClass()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoriesViewModel.view = self.view
        categoriesViewModel.storyboard = self.storyboard
        view?.backgroundColor = UIColor(patternImage: UIImage(named: category?.background ?? "")!)
        CategoryIcon.image = UIImage(named: category?.image ?? "")
        CategoryIcon.color = .white
        CategoryIcon.sound = category?.sound ?? ""
        CategoryName.textColor = .white
        CategoryName.text = category?.name
        CategoryScore.textColor = .white
        CategoryScore.text = "\(category?.score ?? 0)/100"
        CompleteStatus.textColor = .white
        switch category?.complete {
        case true:
            CompleteStatus.text = "пройдено"
            CompleteStatus.textColor = .systemGreen
            
        case false:
            CompleteStatus.text = "не пройдено"
            CompleteStatus.textColor = .systemGray
            
        default:
            CompleteStatus.text = "не пройдено"
            CompleteStatus.textColor = .systemGray
        }
        PlayButton.tintColor = .white
        self.player.PlaySound(resource: self.category?.music ?? "")
    }
    
    @IBAction func PlayQuiz() {
        animation.springButton(button: self.PlayButton)
        player.StopSound(resource: category?.music ?? "")
        player.PlaySound(resource: category?.sound ?? "")
        categoriesViewModel.GoToStart(quiz: category!.base, category: category!)
    }
    
}