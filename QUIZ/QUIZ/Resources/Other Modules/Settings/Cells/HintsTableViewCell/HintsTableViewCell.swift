//
//  HintsTableViewCell.swift
//  QUIZ
//
//  Created by Марк Киричко on 08.04.2022.
//

import UIKit

class HintsTableViewCell: UITableViewCell {

    var userDefaults = UserDefaults.standard
    var animation = AnimationClass()
    var player = SoundClass()
    
    static let identifier = "HintsTableViewCell"
    
    @IBOutlet weak var mySwitch: UISwitch!
    @IBOutlet weak var HintLabel: UILabel!
    @IBOutlet weak var HintsImage: UIImageView!
    
    @IBAction func switchAction(_ sender: UISwitch) {
        
        userDefaults.set(sender.isOn, forKey: "onhints")
        userDefaults.set(sender.isOn, forKey: "offhints")
        
        if mySwitch.isOn == true {
            print("on")
            userDefaults.set(true, forKey: "onstatushints")
            animation.SpringAnimation(view: HintsImage)
            player.PlaySound(resource: "click sound.wav")
        } else if mySwitch.isOn == false {
            print("off")
            userDefaults.set(false, forKey: "onstatushints")
            player.PlaySound(resource: "click sound.wav")
        }
        
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        mySwitch.isOn = userDefaults.bool(forKey: "onhints")
        mySwitch.isOn = userDefaults.bool(forKey: "offhints")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
