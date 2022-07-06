//
//  AttemptsTableViewCell.swift
//  QUIZ
//
//  Created by Марк Киричко on 12.04.2022.
//

import UIKit

class AttemptsTableViewCell: UITableViewCell {

    var userDefaults = UserDefaults.standard
    var animation = AnimationClass()
    var player = SoundClass()
    
    static let identifier = "AttemptsTableViewCell"
    
    @IBOutlet weak var mySwitch: UISwitch!
    @IBOutlet weak var AttemptsLabel: UILabel!
    @IBOutlet weak var AttemptsImage: UIImageView!
    
    @IBAction func switchAction(_ sender: UISwitch) {
        
        userDefaults.set(sender.isOn, forKey: "onattempts")
        userDefaults.set(sender.isOn, forKey: "offattempts")
        
        if mySwitch.isOn == true {
            print("on")
            userDefaults.set(true, forKey: "onstatusattempts")
            animation.springImage(image: AttemptsImage)
            player.Sound(resource: "click sound.wav")
        } else if mySwitch.isOn == false {
            print("off")
            userDefaults.set(false, forKey: "onstatusattempts")
            player.Sound(resource: "click sound.wav")
        }
        
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        mySwitch.isOn = userDefaults.bool(forKey: "onattempts")
        mySwitch.isOn = userDefaults.bool(forKey: "offattempts")
        //userDefaults.object(forKey: "off")
        
        
        //mySwitch.isOn = userDefaults.bool(forKey: "on")
        //mySwitch.isOn = userDefaults.bool(forKey: "on")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
