//
//  QuizCategoriesCollectionViewCell.swift
//  QUIZ
//
//  Created by Марк Киричко on 23.01.2023.
//

import UIKit
import SnapKit


class QuizCategoriesCollectionViewCell: UICollectionViewCell {
    
    private let animation = AnimationClass()
    static let identifier = "QuizCategoriesCollectionViewCell"
    private let viewModel = QuizCategoriesListViewViewModel()
    
    private let CategoryIcon: RoundedImageView = {
        let imageView = RoundedImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let CategoryName: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = .systemFont(ofSize: 20, weight: .black)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let CategoryScore: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = .systemFont(ofSize: 20, weight: .black)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let CompleteStatus: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = .systemFont(ofSize: 20, weight: .black)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubviews(CategoryIcon,CategoryName,CategoryScore,CompleteStatus)
        setupConstraints()
        setUpLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpLayer() {
        contentView.layer.cornerRadius = 8
        contentView.layer.shadowColor = UIColor.label.cgColor
        contentView.layer.cornerRadius = 4
        contentView.layer.shadowOffset = CGSize(width: -4, height: 4)
        contentView.layer.shadowOpacity = 0.3
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            CategoryIcon.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            CategoryIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            CategoryIcon.widthAnchor.constraint(equalToConstant: 120),
            CategoryIcon.heightAnchor.constraint(equalToConstant: 120),
            
            CategoryName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            CategoryName.topAnchor.constraint(equalTo: CategoryIcon.bottomAnchor),
            CategoryName.heightAnchor.constraint(equalToConstant: 60),
            
            CategoryScore.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            CategoryScore.topAnchor.constraint(equalTo: CategoryName.bottomAnchor, constant: -10),
            CategoryScore.heightAnchor.constraint(equalToConstant: 60),
            
            CompleteStatus.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            CompleteStatus.topAnchor.constraint(equalTo: CategoryScore.bottomAnchor, constant: -10),
            CompleteStatus.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            CompleteStatus.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func configure(with viewModel: QuizCategoriesCollectionViewCellViewModel) {
        contentView.backgroundColor = UIColor(patternImage: UIImage(named: viewModel.categoryBackground)!)
        self.CategoryIcon.image = UIImage(named: viewModel.categoryIcon)
        self.CategoryIcon.sound = viewModel.categorySound
        self.CategoryIcon.music = viewModel.categoryMusic
        self.CategoryIcon.color = UIColor.white
        self.CategoryName.text = viewModel.categoryName
        self.CategoryScore.text = "счет: \(viewModel.categoryScore)/100"
        switch viewModel.categoryComplete {
        case true:
            self.CompleteStatus.text = "пройдено"
            
        case false:
            self.CompleteStatus.text = "не пройдено"
        }
    }
    
    func didCategoryTapped(indexPath: IndexPath) {
        self.animation.springImage(image: self.CategoryIcon)
    }
    
}

