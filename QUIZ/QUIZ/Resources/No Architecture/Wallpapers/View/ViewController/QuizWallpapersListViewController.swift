//
//  QuizWallpapersListViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 25.06.2023.
//

import UIKit

class QuizWallpapersListViewController: UIViewController {

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(QuizWallpaperCollectionViewCell.self, forCellWithReuseIdentifier: QuizWallpaperCollectionViewCell.identifier)
        return collectionView
    }()
    
    var wallpapers = [
        "earth.background.jpeg",
        "history.background.jpeg",
        "anatomy.background.jpeg",
        "sport.background.jpeg",
        "games.background.jpeg",
        "IQ.background.jpeg",
        "economy.background.jpeg",
        "geography.background.jpeg",
        "ecology.background.jpeg",
        "physics.background.jpeg",
        "chemistry.background.jpeg",
        "informatics.background.jpeg",
        "literature.background.jpeg",
        "drive.background.jpeg",
        "swift.background.jpeg",
        "underwater.background.jpeg",
        "chess.background.jpeg",
        "halloween.background.jpeg",
        "newyear.background.jpeg"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Викторина Обои"
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        SetUpCollectionView()
    }
    
    private func SetUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}
