//
//  StatisticTableViewCell.swift
//  QUIZ
//
//  Created by Марк Киричко on 03.04.2022.
//

import UIKit

class StatisticTableViewCell: UITableViewCell {

    static let identifier = "StatisticTableViewCell"
    var delegate: CustomViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func didSelect(indexPath: IndexPath) {
        delegate?.didElementClick()
    }
}
