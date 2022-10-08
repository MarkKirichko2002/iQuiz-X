//
//  QuizMediaLibraryTableViewCell.swift
//  QUIZ
//
//  Created by Марк Киричко on 08.10.2022.
//

import UIKit

class QuizMediaLibraryTableViewCell: UITableViewCell {
    
    static let identifier = "QuizMediaLibraryTableViewCell"
    var player = SoundClass()
    var music = "space music.mp3"
    var isPlaying = false
    
    @IBOutlet weak var Icon: UIImageView!
    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var PlayButton: UIButton!
    
    func configure(mediateka: QuizMediaLibraryModel) {
        Icon.image = UIImage(named: mediateka.icon)
        Title.text = mediateka.title
        music = mediateka.music
    }
    
    @IBAction func PlayMusic() {
        
        let rotationAnimation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        
        if isPlaying == false {
            PlayButton.setImage(UIImage(named: "player selected"), for: .normal)
            player.Sound(resource: music)
            rotationAnimation.toValue = NSNumber(value: .pi * 2.0)
            rotationAnimation.duration = 2.0;
            rotationAnimation.isCumulative = true;
            rotationAnimation.repeatCount = .infinity;
            self.Icon?.layer.add(rotationAnimation, forKey: "rotationAnimation")
            isPlaying = true
        } else if isPlaying == true {
            PlayButton.setImage(UIImage(named: "player"), for: .normal)
            player.StopSound(resource: music)
            isPlaying = false
            self.Icon?.layer.removeAnimation(forKey: "rotationAnimation")
        }
    }
}
