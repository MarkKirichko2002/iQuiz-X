//
//  SpeachTableViewCell.swift
//  QUIZ
//
//  Created by Марк Киричко on 08.04.2022.
//

import UIKit

class SpeachTableViewCell: UITableViewCell {

    var userDefaults = UserDefaults.standard
    var animation = AnimationClass()
    var player = SoundClass()
    
    static let identifier = "SpeachTableViewCell"
    
    @IBOutlet weak var mySwitch: UISwitch!
    @IBOutlet weak var SpeachLabel: UILabel!
    @IBOutlet weak var SpeachImage: UIImageView!
    
    @IBAction func switchAction(_ sender: UISwitch) {
        
        userDefaults.set(sender.isOn, forKey: "onspeach")
        userDefaults.set(sender.isOn, forKey: "offspeach")
        
        if mySwitch.isOn == true {
            print("on")
            userDefaults.set(true, forKey: "onstatusspeach")
            animation.springImage(image: SpeachImage)
            player.Sound(resource: "click sound.wav")
        } else if mySwitch.isOn == false {
            print("off")
            userDefaults.set(false, forKey: "onstatusspeach")
            player.Sound(resource: "click sound.wav")
        }
        
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        mySwitch.isOn = userDefaults.bool(forKey: "onspeach")
        mySwitch.isOn = userDefaults.bool(forKey: "offspeach")
        //userDefaults.object(forKey: "off")
        
        
        //mySwitch.isOn = userDefaults.bool(forKey: "on")
        //mySwitch.isOn = userDefaults.bool(forKey: "on")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
