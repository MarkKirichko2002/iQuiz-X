//
//  QuizResultsViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 16.02.2022.
//

import UIKit
import RxSwift
import RxCocoa

final class QuizResultsViewController: UIViewController {
    
    @IBOutlet weak var Image: RoundedImageView!
    @IBOutlet weak var ScoreLabel: UILabel!
    @IBOutlet weak var ExitButton: UIButton!
    @IBOutlet weak var CorrectAnswers: UILabel!
    @IBOutlet weak var CommentLabel: UILabel!
    @IBOutlet weak var RetryButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var view2: UIView!

    var quizResultsViewModel = QuizResultsViewModel()
    var quizBaseViewModel: QuizBaseViewModel?
    private let disposeBag = DisposeBag()
    private let animation = AnimationClass()
    private let player = SoundClass()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.quizResultsViewModel.quizCategoriesViewModel.view = self.view
        self.quizResultsViewModel.quizCategoriesViewModel.storyboard = self.storyboard
        self.Image.color = .white
        quizResultsViewModel.SetupView(view: self.view, storyboard: self.storyboard!)
        quizResultsViewModel.quizresult.subscribe(onNext: { result in
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
        quizResultsViewModel.GetQuizResult()
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
            self.quizBaseViewModel?.speechRecognition.cancelSpeechRecognition()
        }
    }
    
    @IBAction func presentCategoryScreen() {
        animation.SpringAnimation(view: self.ExitButton)
        player.PlaySound(resource: "spring.mp3")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.quizResultsViewModel.PresentCategoryScreen()
        }
    }
    
    @IBAction func restart() {
        animation.SpringAnimation(view: self.RetryButton)
        player.PlaySound(resource: "spring.mp3")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.quizResultsViewModel.restartGame()
        }
    }
}
