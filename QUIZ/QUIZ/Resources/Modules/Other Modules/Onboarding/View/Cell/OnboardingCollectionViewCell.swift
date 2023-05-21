//
//  OnboardingCollectionViewCell.swift
//  QUIZ
//
//  Created by Марк Киричко on 02.01.2023.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "OnboardingCollectionViewCell"
    
    @IBOutlet weak var slideImageView: UIImageView!
    @IBOutlet weak var slideTitleLbl: UILabel!
    @IBOutlet weak var slideDescriptionLbl: UILabel!
    
    func setup(_ slide: OnboardingSlide) {
        slideImageView.image = UIImage(named: slide.image)
        slideTitleLbl.text = slide.title
        slideDescriptionLbl.text = slide.description
    }
}
