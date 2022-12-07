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
    @IBOutlet weak var PlayButton: UIButton!
    
    var category: QuizModel?
    var player = SoundClass()
    var categoriesViewModel = CategoriesViewModel()
    var animation = AnimationClass()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view?.backgroundColor = UIColor(patternImage: UIImage(named: category?.background ?? "")!)
        CategoryIcon.image = UIImage(named: category?.image ?? "")
        CategoryIcon.color = .white
        CategoryIcon.sound = category?.sound ?? ""
        CategoryName.text = category?.name
        CategoryName.textColor = .white
        PlayButton.tintColor = .white
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.player.Sound(resource: self.category?.music ?? "")
        }
    }
    
    @IBAction func PlayQuiz() {
        animation.springButton(button: self.PlayButton)
        player.StopSound(resource: category?.music ?? "")
        player.Sound(resource: category?.sound ?? "")
        categoriesViewModel.GoToStart(quiz: category!.base, category: category!, storyboard: self.storyboard, view: self.view)
    }
    
}
