//
//  RoundedImageView.swift
//  QUIZ
//
//  Created by Марк Киричко on 22.02.2022.
//

import UIKit

class RoundedImageView: UIImageView {
    
    private let player = SoundClass()
    private let animation = AnimationClass()
    var isPlaying = false
    var sound = "IQ.mp3"
    var color = UIColor.black
    var borderWidth = 3
    var music = ""
    
    override func layoutSubviews() {
        self.layer.cornerRadius = self.bounds.width / 2
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapFunction))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tap)
        self.layer.borderWidth = CGFloat(borderWidth)
        self.layer.borderColor = color.cgColor
        self.clipsToBounds = true
    }
    
    @IBAction func tapFunction(sender: UITapGestureRecognizer) {
       
        player.PlaySound(resource: sound)
        
        if music != "" {
            if isPlaying == false {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.animation.StartRotateAnimation(view: self)
                    self.player.PlaySound(resource: self.music)
                    self.isPlaying = true
                }
            } else {
                animation.StopRotateAnimation(view: self)
                player.StopSound(resource: music)
                player.PlaySound(resource: sound)
                isPlaying = false
            }
        }
        animation.SpringAnimation(view: self)
    }
}
