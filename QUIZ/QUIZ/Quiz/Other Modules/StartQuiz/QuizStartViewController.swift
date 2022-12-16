//
//  QuizPreviewViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 11.08.2022.
//

import UIKit

class QuizStartViewController: UIViewController {
    
    @IBOutlet weak var Icon: RoundedImageView!
    @IBOutlet weak var CategoryName: UILabel!
    @IBOutlet weak var QuestionLabel: UILabel!
    @IBOutlet weak var TimerLabeL: UILabel!
    
    var viewModel = CategoriesViewModel()
    var base: QuizBaseViewModel?
    var category: QuizModel?
    var seconds = 6 {
        didSet {
            animation.springLabel(label: TimerLabeL)
            TimerLabeL.text = ("\(seconds)")
        }
    }
    var animation = AnimationClass()
    var timer = Timer()
    
    @objc func time() {
        seconds -= 1
        
        if seconds == 0 {
            timer.invalidate()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self.view
        viewModel.storyboard = self.storyboard
        view.backgroundColor = UIColor(patternImage: UIImage(named: category?.background ?? "")!)
        Icon.sound = category?.sound ?? "space.wav"
        Icon.image = UIImage(named: category?.image ?? "planets.jpeg")
        Icon.color = .white
        Icon.borderWidth = 5
        CategoryName.text = category?.name
        CategoryName.textColor = .white
        QuestionLabel.textColor = .white
        TimerLabeL.textColor = .white
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(time), userInfo: nil, repeats: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            self.viewModel.goToQuize(quiz: self.base!, category: self.category!)
        }
    }
    
}
