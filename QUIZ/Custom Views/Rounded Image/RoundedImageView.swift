//
//  RoundedImageView.swift
//  QUIZ
//
//  Created by Марк Киричко on 22.02.2022.
//

import UIKit
import AVFoundation

class RoundedImageView: UIImageView {
    
    private let player = SoundClass()
    private let animation = AnimationClass()
    private var isPlaying = false
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
                    self.animation.StartRotateImage(image: self)
                    self.player.PlaySound(resource: self.music)
                    self.isPlaying = true
                }
            } else {
                animation.StopRotateImage(image: self)
                player.StopSound(resource: music)
                player.PlaySound(resource: sound)
                isPlaying = false
            }
        }
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.75,
                           delay: 0,
                           usingSpringWithDamping: 0.50,
                           initialSpringVelocity: 0.50,
                           options: [.allowUserInteraction],
                           animations: {
                self.bounds = self.bounds.insetBy(dx: 15, dy: 15)
            },
                           completion: nil)
        }
    }
}
