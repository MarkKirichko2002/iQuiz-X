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
    @IBOutlet weak var CloseButton: UIButton!
    @IBOutlet weak var VoiceCommandLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    
    var category: QuizCategoryModel?
    private let player = SoundClass()
    private let categoriesViewModel = CategoriesViewModel()
    private let animation = AnimationClass()
    private let speechSynthesizerManager = SpeechSynthesizerManager()
   
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
        CloseButton.tintColor = .white
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
        setupLabelTap()
        guard let category = self.category else {return}
        self.player.PlaySound(resource: category.music)
        self.animation.StartRotateImage(image: self.CategoryIcon)
    }
    
    @IBAction func PlayQuiz() {
        guard let category = self.category else {return}
        DispatchQueue.main.async {
            self.animation.springImage(image: self.CategoryIcon)
            self.animation.springLabel(label: self.CategoryName)
            self.animation.springLabel(label: self.CategoryScore)
            self.animation.springLabel(label: self.CompleteStatus)
            self.animation.springButton(button: self.PlayButton)
            self.player.StopSound(resource: category.music)
            self.player.PlaySound(resource: category.sound)
            self.animation.StopRotateImage(image: self.CategoryIcon)
            self.categoriesViewModel.GoToStart(quiz: category.base, category: category)
        }
    }
    
    @IBAction func CloseDetailScreen() {
        guard let category = self.category else {return}
        self.animation.springButton(button: self.CloseButton)
        self.player.PlaySound(resource: category.sound)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.dismiss(animated: true)
        }
    }
    
    @objc func SayVoiceCommand(_ sender: UITapGestureRecognizer) {
        speechSynthesizerManager.sayComment(comment: self.VoiceCommandLabel.text!)
    }
    
    private func setupLabelTap() {
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(SayVoiceCommand(_:)))
        self.VoiceCommandLabel.isUserInteractionEnabled = true
        self.VoiceCommandLabel.addGestureRecognizer(labelTap)
    }
}
