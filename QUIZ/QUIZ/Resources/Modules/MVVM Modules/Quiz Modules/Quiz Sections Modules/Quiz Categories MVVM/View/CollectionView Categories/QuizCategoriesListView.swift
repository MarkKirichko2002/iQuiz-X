//
//  QuizCategoriesListView.swift
//  QUIZ
//
//  Created by Марк Киричко on 23.01.2023.
//

import UIKit

protocol QuizCategoriesListViewDelegate: NSObject {
    func ShowDetailCategoryScreen(view: UIView, category: QuizCategoryModel)
}

class QuizCategoriesListView: UIView {

    public weak var delegate: QuizCategoriesListViewDelegate?
    
    private let viewModel = QuizCategoriesListViewViewModel()
    
    private let collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
       layout.scrollDirection = .vertical
       layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
       let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
       collectionView.translatesAutoresizingMaskIntoConstraints = false
       collectionView.register(QuizCategoriesCollectionViewCell.self, forCellWithReuseIdentifier: QuizCategoriesCollectionViewCell.identifier)
       return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)
        viewModel.delegate = self
        viewModel.GetQuizCategoriesResults()
        SetupConstraints()
        setUpCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func SetupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setUpCollectionView() {
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
    }
}

extension QuizCategoriesListView: QuizCategoriesListViewViewModelDelegate {
  
    func didCategorySelected(category: QuizCategoryModel) {
        delegate?.ShowDetailCategoryScreen(view: self, category: category)
    }
    
    func didLoadCategories() {
        collectionView.reloadData()
    }
}
