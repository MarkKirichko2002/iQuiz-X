//
//  QuizPreviewViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 11.08.2022.
//

import UIKit

class QuizStartViewController: UIViewController {
    
    @IBOutlet weak var Icon: UIImageView!
    @IBOutlet weak var QuestionLabel: UILabel!
    @IBOutlet weak var TimerLabeL: UILabel!
    
    var viewModel = CategoriesViewModel()
    var base: QuizBaseViewModel?
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
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(time), userInfo: nil, repeats: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            self.viewModel.goToQuize(quiz: self.base!, storyboard: self.storyboard, view: self.view)
        }
    }
    
}
