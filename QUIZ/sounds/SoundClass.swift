//
//  SoundClass.swift
//  QUIZ
//
//  Created by Марк Киричко on 16.02.2022.
//
import Foundation
import AVFoundation

class SoundClass {
    
    var player: AVAudioPlayer?
    
    func Sound(resource: String) {

        let path = Bundle.main.path(forResource: resource, ofType:nil)!
        let url = URL(fileURLWithPath: path)

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            
        }
    }
    
    
    func StopSound(resource: String) {

        let path = Bundle.main.path(forResource: resource, ofType:nil)!
        let url = URL(fileURLWithPath: path)

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.stop()
        } catch {
            
        }
    }
    
    
}
