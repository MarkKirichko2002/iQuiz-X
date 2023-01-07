//
//  SpeechSynthesizerManager.swift
//  QUIZ
//
//  Created by Марк Киричко on 07.01.2023.
//

import AVFoundation

class SpeechSynthesizerManager: SpeechSynthesizerManagerProtocol {
    
    private let synthesizer = AVSpeechSynthesizer()
    
    func sayComment(comment: String) {
        let utterance = AVSpeechUtterance(string: comment)
        utterance.voice = AVSpeechSynthesisVoice(language: "ru-RU")
        synthesizer.speak(utterance)
    }
    
    func StopSaying() {
        synthesizer.stopSpeaking(at: .immediate)
    }
}
