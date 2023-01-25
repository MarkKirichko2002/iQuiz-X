//
//  SpeechRecognitionManager.swift
//  QUIZ
//
//  Created by Марк Киричко on 03.01.2023.
//

import Foundation
import Speech

class SpeechRecognitionManager: SpeechRecognitionManagerProtocol {
    
    func configureAudioSession() {
        
        do {
            try? AVAudioSession.sharedInstance().setCategory(.playAndRecord, mode: .default, policy: .default, options: .defaultToSpeaker)
        }  catch  {
            print(error)
        }
    }
    
}
