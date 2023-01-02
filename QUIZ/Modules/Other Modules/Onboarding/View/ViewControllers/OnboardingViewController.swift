//
//  OnboardingViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 02.01.2023.
//

import Foundation
import UIKit

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    private var slides: [OnboardingSlide] = []
    
    private var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                nextBtn.setTitle("Начать", for: .normal)
            } else {
                nextBtn.setTitle("Далее", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        slides = [OnboardingSlide(title: "распознавание речи", description: "выбирайте правильный вариант ответа в викторине сказав 1,2,3 или выберите нужную категории сказав название категории", image: "voice.png"), OnboardingSlide(title: "биометрия", description: "авторизация с помощью Face ID/Touch ID", image: "FACE ID.png"), OnboardingSlide(title: "новости", description: "читайте новости каждый день", image: "newspaper.png")]
    }
    
    @IBAction func NextBtnClicked(_ sender: UIButton) {
        if currentPage == slides.count - 1 {
            UserDefaults.standard.setValue(true, forKey: "isOnboarding")
            guard let controller = storyboard?.instantiateViewController(withIdentifier: "StartViewController") as? UIViewController else {return}
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .flipHorizontal
            present(controller, animated: true, completion: nil)
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        cell.setup(slides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath)-> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
    
}
