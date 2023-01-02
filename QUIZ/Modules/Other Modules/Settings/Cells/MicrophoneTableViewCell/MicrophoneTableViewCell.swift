//
//  MicrophoneTableViewCell.swift
//  QUIZ
//
//  Created by Марк Киричко on 07.04.2022.
//

import UIKit

class MicrophoneTableViewCell: UITableViewCell {

    var userDefaults = UserDefaults.standard
    var animation = AnimationClass()
    var player = SoundClass()
    
    static let identifier = "MicrophoneTableViewCell"
    
    @IBOutlet weak var mySwitch: UISwitch!
    @IBOutlet weak var MicrophoneLabel: UILabel!
    @IBOutlet weak var MicrophoneImage: UIImageView!
    
    @IBAction func switchAction(_ sender: UISwitch) {
        
        userDefaults.set(sender.isOn, forKey: "onaudio")
        userDefaults.set(sender.isOn, forKey: "offaudio")
        
        if mySwitch.isOn == true {
            print("on")
            userDefaults.set(true, forKey: "onstatusaudio")
            animation.springImage(image: MicrophoneImage)
            player.PlaySound(resource: "click sound.wav")
        } else if mySwitch.isOn == false {
            print("off")
            userDefaults.set(false, forKey: "onstatusaudio")
            player.PlaySound(resource: "click sound.wav")
        }
        
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        mySwitch.isOn = userDefaults.bool(forKey: "onaudio")
        mySwitch.isOn = userDefaults.bool(forKey: "offaudio")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
