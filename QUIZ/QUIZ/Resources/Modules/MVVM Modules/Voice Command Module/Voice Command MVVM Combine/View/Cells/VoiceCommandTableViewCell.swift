//
//  VoiceCommandTableViewCell.swift
//  QUIZ
//
//  Created by Марк Киричко on 03.01.2023.
//

import UIKit

class VoiceCommandTableViewCell: UITableViewCell {
    
    static let identifier = "VoiceCommandTableViewCell"
    private let voiceCommandViewModel = VoiceCommandViewModel()
    private var voicecommand: VoiceCommandModel?
    private let player = SoundClass()
    private var animation = AnimationClass()
    
    @IBOutlet weak var Icon: RoundedImageView!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var VoiceCommandTextField: UITextField!
    @IBOutlet weak var Title: UILabel!
    
    @IBAction func SaveVoiceCommand() {
        guard let voicecommand = self.voicecommand else {return}
        voiceCommandViewModel.UpdateVoiceCommand(id: voicecommand.id, voicecommand: voicecommand, text: VoiceCommandTextField.text!)
        self.player.PlaySound(resource: voicecommand.sound)
        self.animation.SpringAnimation(view: self.Icon)
        self.animation.SpringAnimation(view: self.Title)
    }
    
    func configure(voicecommand: VoiceCommandModel) {
        Icon.image = UIImage(named: voicecommand.icon)
        Icon.sound = voicecommand.sound
        Name.text = voicecommand.name
        VoiceCommandTextField.placeholder = voicecommand.voiceCommand
        VoiceCommandTextField.text = voicecommand.voiceCommand
        self.voicecommand = voicecommand
    }
}
