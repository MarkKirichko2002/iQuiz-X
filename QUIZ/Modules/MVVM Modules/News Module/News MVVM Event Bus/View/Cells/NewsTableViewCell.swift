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
    var delegate: CustomViewCellDelegate?
    private var animation = AnimationClass()
    
    @IBOutlet weak var NewsImage: RoundedImageView!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var DescriptionLabel: UILabel!
    
    func configure(news: Article) {
        NewsImage.sd_setImage(with: URL(string: news.urlToImage ?? ""))
        NewsImage.sound = "newspaper.mp3"
        TitleLabel.text = news.title ?? ""
        DescriptionLabel.text = news.description ?? ""
    }
    
    func didSelect(indexPath: IndexPath) {
        animation.springImage(image: NewsImage)
        animation.springLabel(label: TitleLabel)
        animation.springLabel(label: DescriptionLabel)
        delegate?.didElementClick()
    }
}
