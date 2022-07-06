//
//  NewsTableViewCellModel.swift
//  QUIZ
//
//  Created by Марк Киричко on 02.07.2022.
//

import Foundation
import UIKit
import SDWebImage

class NewsTableViewCellModel {
    
    func configure(article: Article, image: UIImageView, title: UILabel, description: UILabel) {
        image.sd_setImage(with: URL(string: article.urlToImage ?? ""))
        title.text = article.title
        description.text = article.description
    }
    
}
