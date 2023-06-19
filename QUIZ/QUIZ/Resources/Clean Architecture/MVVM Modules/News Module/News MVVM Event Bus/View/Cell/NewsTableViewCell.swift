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
        NewsImage.sd_setImage(with: URL(string: news.urlToImage ?? "https://media.istockphoto.com/id/1175387759/vector/camera-icon.jpg?s=612x612&w=0&k=20&c=paC1ZkU31dH2B5epXqT_cYOyca5uqh4v0WpFUldCUBE="))
        NewsImage.sound = "newspaper.mp3"
        TitleLabel.text = news.title ?? ""
        DescriptionLabel.text = news.description ?? ""
    }
    
    func didSelect(indexPath: IndexPath) {
        animation.SpringAnimation(view: NewsImage)
        animation.SpringAnimation(view: TitleLabel)
        animation.SpringAnimation(view: DescriptionLabel)
        delegate?.didElementClick()
    }
}
