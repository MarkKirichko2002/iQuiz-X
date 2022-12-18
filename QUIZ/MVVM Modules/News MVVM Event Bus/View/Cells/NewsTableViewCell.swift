//
//  NewsTableViewCell.swift
//  QUIZ
//
//  Created by Марк Киричко on 29.06.2022.
//

import UIKit
import SDWebImage

class NewsTableViewCell: UITableViewCell {
    
    static let identifier = "NewsTableViewCell"
    
    @IBOutlet weak var NewsImage: UIImageView!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var DescriptionLabel: UILabel!
    
    func configure(news: Article) {
        NewsImage.sd_setImage(with: URL(string: news.urlToImage ?? ""))
        TitleLabel.text = news.title ?? ""
        DescriptionLabel.text = news.description ?? ""
    }
}
