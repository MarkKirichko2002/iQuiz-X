//
//  BaseTotalQuizViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 16.02.2022.
//

import UIKit
import RxSwift
import RxCocoa

class BaseTotalQuizViewController: UIViewController {
    
    @IBOutlet weak var Image: RoundedImageView!
    @IBOutlet weak var ScoreLabel: UILabel!
    @IBOutlet weak var ExitButton: UIButton!
    @IBOutlet weak var CorrectAnswers: UILabel!
    @IBOutlet weak var CommentLabel: UILabel!
    @IBOutlet weak var RetryButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var view2: UIView!

    var quizResultViewModel = QuizResultViewModel()
    var disposeBag = DisposeBag()
    var quizBaseViewModel: QuizBaseViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.quizResultViewModel.viewModel.view = self.view
        self.quizResultViewModel.viewModel.storyboard = self.storyboard
        self.Image.color = .white
        quizResultViewModel.SetupView(view: self.view, storyboard: self.storyboard!)
        quizResultViewModel.quizresult.subscribe(onNext: { result in
            guard let background = UIImage(named: result.background) else {return}
            self.Image.image = UIImage(named: result.icon)
            self.Image.sound = result.sound
            self.CommentLabel.text = result.categoryName
            self.ScoreLabel.text = "счет: \(String(result.bestscore))/100 баллов"
            self.CorrectAnswers.text = "правильные ответы: \(result.CorrectAnswersCounter)/20"
            self.view.backgroundColor = UIColor(patternImage: background)
            self.view2.backgroundColor = UIColor(patternImage: background)
            self.scrollView.backgroundColor = UIColor(patternImage: background)
        }).disposed(by: disposeBag)
        RetryButton.layer.borderWidth = 2
        RetryButton.layer.borderColor = UIColor.black.cgColor
        ExitButton.layer.borderWidth = 2
        ExitButton.layer.borderColor = UIColor.black.cgColor
        quizResultViewModel.GetQuizResult()
        Image.layer.cornerRadius = Image.frame.size.width / 2
        Image.clipsToBounds = true
        Image.layer.borderWidth = 5
        Image.layer.borderColor = UIColor.black.cgColor
        CommentLabel.font = UIFont.boldSystemFont(ofSize: 20)
        ScoreLabel.font = UIFont.boldSystemFont(ofSize: 20)
        CorrectAnswers.font = UIFont.boldSystemFont(ofSize: 20)
        ExitButton.layer.cornerRadius = ExitButton.frame.size.width / 5
        ExitButton.clipsToBounds = true
        RetryButton.layer.cornerRadius = RetryButton.frame.size.width / 5
        RetryButton.clipsToBounds = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.quizBaseViewModel?.stopSpeechRecognition()
        }
    }
    
    
    @IBAction func presentCategoryScreen() {
        quizResultViewModel.PresentCategoryScreen()
    }
    
    @IBAction func restart() {
        quizResultViewModel.restartGame()
    }
    
}





