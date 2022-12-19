//
//  MusicTableViewCell.swift
//  QUIZ
//
//  Created by Марк Киричко on 09.04.2022.
//

import UIKit

class MusicTableViewCell: UITableViewCell {

    var userDefaults = UserDefaults.standard
    var animation = AnimationClass()
    var player = SoundClass()
    
    static let identifier = "MusicTableViewCell"
    
    @IBOutlet weak var mySwitch: UISwitch!
    @IBOutlet weak var MusicLabel: UILabel!
    @IBOutlet weak var MusicImage: UIImageView!
    
    @IBAction func switchAction(_ sender: UISwitch) {
        
        userDefaults.set(sender.isOn, forKey: "onmusic")
        userDefaults.set(sender.isOn, forKey: "offmusic")
        
        if mySwitch.isOn == true {
            print("on")
            userDefaults.set(true, forKey: "onstatusmusic")
            animation.springImage(image: MusicImage)
            player.Sound(resource: "click sound.wav")
        } else if mySwitch.isOn == false {
            print("off")
            userDefaults.set(false, forKey: "onstatusmusic")
            player.Sound(resource: "click sound.wav")
        }
        
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        mySwitch.isOn = userDefaults.bool(forKey: "onmusic")
        mySwitch.isOn = userDefaults.bool(forKey: "offmusic")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
