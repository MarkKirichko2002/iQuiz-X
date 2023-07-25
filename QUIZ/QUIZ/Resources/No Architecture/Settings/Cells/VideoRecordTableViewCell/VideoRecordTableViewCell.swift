//
//  VideoRecordTableViewCell.swift
//  QUIZ
//
//  Created by Марк Киричко on 06.04.2022.
//

import UIKit

class VideoRecordTableViewCell: UITableViewCell {

    var userDefaults = UserDefaults.standard
    var animation = AnimationClass()
    var player = SoundClass()
    
    static let identifier = "VideoRecordTableViewCell"
    
    @IBOutlet weak var mySwitch: UISwitch!
    @IBOutlet weak var GestureLabel: UILabel!
    @IBOutlet weak var GestureImage: UIImageView!
    
    @IBAction func switchAction(_ sender: UISwitch) {
        
        userDefaults.set(sender.isOn, forKey: "on")
        userDefaults.set(sender.isOn, forKey: "off")
        
        if mySwitch.isOn == true {
            print("on")
            userDefaults.set(true, forKey: "onstatus")
            animation.SpringAnimation(view: GestureImage)
            player.PlaySound(resource: "click sound.wav")
        } else if mySwitch.isOn == false {
            print("off")
            userDefaults.set(false, forKey: "onstatus")
            player.PlaySound(resource: "click sound.wav")
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        mySwitch.isOn = userDefaults.bool(forKey: "on")
        mySwitch.isOn = userDefaults.bool(forKey: "off")
        print(userDefaults.bool(forKey: "on"))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
