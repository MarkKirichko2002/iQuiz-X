//
//  TimerTableViewCell.swift
//  QUIZ
//
//  Created by Марк Киричко on 10.04.2022.
//

import UIKit

class TimerTableViewCell: UITableViewCell {

    var userDefaults = UserDefaults.standard
    var animation = AnimationClass()
    var player = SoundClass()
    
    static let identifier = "TimerTableViewCell"
    
    @IBOutlet weak var mySwitch: UISwitch!
    @IBOutlet weak var TimerLabel: UILabel!
    @IBOutlet weak var TimerImage: UIImageView!
    
    @IBAction func switchAction(_ sender: UISwitch) {
        
        userDefaults.set(sender.isOn, forKey: "ontimer")
        userDefaults.set(sender.isOn, forKey: "offtimer")
        
        if mySwitch.isOn == true {
            print("on")
            userDefaults.set(true, forKey: "onstatustimer")
            animation.springImage(image: TimerImage)
            player.PlaySound(resource: "click sound.wav")
        } else if mySwitch.isOn == false {
            print("off")
            userDefaults.set(false, forKey: "onstatustimer")
            player.PlaySound(resource: "click sound.wav")
        }
        
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        mySwitch.isOn = userDefaults.bool(forKey: "ontimer")
        mySwitch.isOn = userDefaults.bool(forKey: "offtimer")
        //userDefaults.object(forKey: "off")
        
        
        //mySwitch.isOn = userDefaults.bool(forKey: "on")
        //mySwitch.isOn = userDefaults.bool(forKey: "on")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
