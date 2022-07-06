//
//  WeatherTableViewCell.swift
//  QUIZ
//
//  Created by Марк Киричко on 23.03.2022.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var highTempLabel: UILabel!
    @IBOutlet var lowTempLabel: UILabel!
    @IBOutlet var iconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    static let identifier = "WeatherTableViewCell"

    static func nib() -> UINib {
        return UINib(nibName: "WeatherTableViewCell",
                     bundle: nil)
    }

    func configure(with model: DailyWeatherEntry) {
        self.highTempLabel.textAlignment = .center
        self.lowTempLabel.textAlignment = .center
        self.lowTempLabel.text = "\(Int(model.temperatureLow))°"
        self.highTempLabel.text = "\(Int(model.temperatureHigh))°"
        self.dayLabel.text = getDayForDate(Date(timeIntervalSince1970: Double(model.time)))
        self.iconImageView.contentMode = .scaleAspectFit
        
        
        let icon = model.icon.lowercased()
        if icon.contains("clear") {
            self.iconImageView.image = UIImage(named: "sun")
            contentView.backgroundColor = UIColor(patternImage: UIImage(named: "clear.background.jpeg")!)
        }
        else if icon.contains("rain") {
            self.iconImageView.image = UIImage(named: "rainy")
            contentView.backgroundColor = UIColor(patternImage: UIImage(named: "rain.background.jpeg")!)
        }
        else {
            // cloud icon
            self.iconImageView.image = UIImage(named: "cloud")
            contentView.backgroundColor = UIColor(patternImage: UIImage(named: "cloud.background.jpeg")!)
        }

    }

    func getDayForDate(_ date: Date?) -> String {
        guard let inputDate = date else {
            return ""
        }

        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE" // Monday
        
        switch formatter.string(from: inputDate) {
            
        case "Monday":
            dayLabel.text = "Понедельник"
            dayLabel.textColor = UIColor.white
            lowTempLabel.textColor = UIColor.white
            highTempLabel.textColor = UIColor.white
            
            
        case "Tuesday":
            dayLabel.text = "Вторник"
            dayLabel.textColor = UIColor.white
            lowTempLabel.textColor = UIColor.white
            highTempLabel.textColor = UIColor.white
            
        case "Wednesday":
            dayLabel.text = "Среда"
            dayLabel.textColor = UIColor.white
            lowTempLabel.textColor = UIColor.white
            highTempLabel.textColor = UIColor.white
            
        case "Thursday":
            dayLabel.text = "Четверг"
            dayLabel.textColor = UIColor.white
            lowTempLabel.textColor = UIColor.white
            highTempLabel.textColor = UIColor.white
            
        case "Friday":
            dayLabel.text = "Пятница"
            dayLabel.textColor = UIColor.white
            lowTempLabel.textColor = UIColor.white
            highTempLabel.textColor = UIColor.white
            
        case "Saturday":
            dayLabel.text = "Суббота"
            dayLabel.textColor = UIColor.white
            lowTempLabel.textColor = UIColor.white
            highTempLabel.textColor = UIColor.white
            
        case "Sunday":
            dayLabel.text = "Воскресенье"
            dayLabel.textColor = UIColor.white
            lowTempLabel.textColor = UIColor.white
            highTempLabel.textColor = UIColor.white
        
        default:
            break
        }
        
        //return formatter.string(from: inputDate)
        return dayLabel.text!
    }
    
}
