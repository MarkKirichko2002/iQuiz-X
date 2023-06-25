//
//  NewsListViewController + Extensions.swift
//  QUIZ
//
//  Created by Марк Киричко on 25.06.2023.
//

import Foundation

// MARK: - CustomViewCellDelegate
extension NewsListViewController: CustomViewCellDelegate {
    
    func didElementClick() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.performSegue(withIdentifier: "ShowWeb", sender: nil)
        }
    }
}
