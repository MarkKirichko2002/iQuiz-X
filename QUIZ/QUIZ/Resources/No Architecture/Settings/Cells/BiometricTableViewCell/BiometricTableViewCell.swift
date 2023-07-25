//
//  BiometricTableViewCell.swift
//  QUIZ
//
//  Created by Марк Киричко on 03.04.2022.
//

import UIKit
import LocalAuthentication

class BiometricTableViewCell: UITableViewCell {

    static let identifier = "BiometricTableViewCell"
    
    let mycontext: LAContext = LAContext()
    
    var userDefaults = UserDefaults.standard
    var animation = AnimationClass()
    var player = SoundClass()
    
    @IBOutlet weak var mySwitch: UISwitch!
    @IBOutlet weak var BiometricMethod: UIImageView!
    @IBOutlet weak var BiometricName: UILabel!
    
    
    @IBAction func switchAction(_ sender: UISwitch) {
        
        userDefaults.set(sender.isOn, forKey: "onbiometric")
        userDefaults.set(sender.isOn, forKey: "offbiometric")
        
        if mySwitch.isOn == true {
            print("on")
            userDefaults.set(true, forKey: "onstatusbiometric")
            animation.SpringAnimation(view: BiometricMethod)
            player.PlaySound(resource: "click sound.wav")
        } else if mySwitch.isOn == false {
            print("off")
            userDefaults.set(false, forKey: "onstatusbiometric")
            player.PlaySound(resource: "click sound.wav")
        }
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if mycontext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            if mycontext.biometryType == .faceID {
               self.BiometricMethod.image = UIImage(named: "FACE ID.png")
               self.BiometricName.text = "Face ID"
            } else if mycontext.biometryType == .touchID {
                self.BiometricMethod.image = UIImage(named: "TOUCH ID.png")
                self.BiometricName.text = "Touch ID"
            }
        }
        
        mySwitch.isOn = userDefaults.bool(forKey: "onbiometric")
        mySwitch.isOn = userDefaults.bool(forKey: "offbiometric")
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
