//
//  QuizWallpapersListViewController + Extensions.swift
//  QUIZ
//
//  Created by Марк Киричко on 25.06.2023.
//

import UIKit

// MARK: - UICollectionViewDataSource
extension QuizWallpapersListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wallpapers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuizWallpaperCollectionViewCell.identifier, for: indexPath) as? QuizWallpaperCollectionViewCell else {return UICollectionViewCell()}
        cell.configure(with: wallpapers[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension QuizWallpapersListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                                 contextMenuConfigurationForItemAt indexPath: IndexPath,
                                 point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { suggestedActions in
            let save = UIAction(title: "cохранить", image: UIImage(systemName: "photo")) { _ in
                if let cell = collectionView.cellForItem(at: indexPath) as? QuizWallpaperCollectionViewCell {
                    if let image = cell.imageView.image {
                        let imageSaver = ImageSaver()
                        imageSaver.writeToPhotoAlbum(image: image)
                    }
                }
            }
            return UIMenu(title: "", children: [save])
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension QuizWallpapersListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath)-> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30) / 2
        return CGSize(width: width, height: width * 1.5)
    }
}
