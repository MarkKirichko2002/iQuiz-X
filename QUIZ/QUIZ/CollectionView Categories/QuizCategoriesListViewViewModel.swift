//
//  QuizCategoriesViewViewModel.swift
//  QUIZ
//
//  Created by Марк Киричко on 23.01.2023.
//

import UIKit

protocol QuizCategoriesListViewViewModelDelegate: NSObject {
    func didCategorySelected(category: QuizCategoryModel)
    func didLoadCategories()
}

class QuizCategoriesListViewViewModel: NSObject {
    
    weak var delegate: QuizCategoriesListViewViewModelDelegate?
    
    private let firebaseManager = FirebaseManager()
    private var cellViewModels = QuizCategoriesViewModel().quizcategories.compactMap {
        QuizCategoriesCollectionViewCellViewModel(categoryName: $0.name, categoryIcon: $0.image, categoryScore: $0.score, categoryComplete: $0.complete, categoryBackground: $0.background, categorySound: $0.sound, categoryMusic: $0.music)
    }
    
    private var categories = QuizCategoriesViewModel().quizcategories
    
    func GetQuizCategoriesResults() {
        for i in categories {
            firebaseManager.LoadQuizCategoriesData(quizpath: i.quizpath) { category in
                self.categories[i.id - 1].complete = category.complete
                self.categories[i.id - 1].score = category.score
                self.categories[i.id - 1].date = category.date
                
                self.cellViewModels[i.id - 1].categoryComplete = category.complete
                self.cellViewModels[i.id - 1].categoryScore = category.score
                self.delegate?.didLoadCategories()
            }
            
            firebaseManager.LoadVoiceCommands(command: i.name) { command in
                self.categories[i.id - 1].voiceCommand = command
            }
        }
    }
}

extension QuizCategoriesListViewViewModel: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuizCategoriesCollectionViewCell.identifier, for: indexPath) as? QuizCategoriesCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        cell.configure(with: cellViewModels[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath)-> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30) / 2
        return CGSize(width: width, height: width * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuizCategoriesCollectionViewCell.identifier, for: indexPath) as? QuizCategoriesCollectionViewCell {
            cell.didCategoryTapped(indexPath: indexPath)
        }
        delegate?.didCategorySelected(category: categories[indexPath.row])
    }
    
}
