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
    var animation = AnimationClass()
    
    @IBOutlet weak var Icon: RoundedImageView!
    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var PlayButton: UIButton!
    
    func configure(medialibrary: QuizMediaLibraryModel) {
        Icon.image = UIImage(named: medialibrary.icon)
        Icon.sound = medialibrary.sound
        Title.text = medialibrary.title
        Title.textColor = .white
        music = medialibrary.music
        contentView.backgroundColor = UIColor(patternImage: UIImage(named: medialibrary.background)!)
    }
    
    @IBAction func PlayMusic() {
        
        if isPlaying == false {
            PlayButton.setImage(UIImage(named: "player selected"), for: .normal)
            player.Sound(resource: music)
            animation.StartRotateImage(image: self.Icon)
            isPlaying = true
        } else if isPlaying == true {
            PlayButton.setImage(UIImage(named: "player"), for: .normal)
            player.StopSound(resource: music)
            isPlaying = false
            animation.StopRotateImage(image: self.Icon)
        }
    }
}
