//
//  SpeechRecognitionManager.swift
//  QUIZ
//
//  Created by Марк Киричко on 03.01.2023.
//

import Speech

class SpeechRecognitionManager: SpeechRecognitionManagerProtocol {
    
    private let audioEngine = AVAudioEngine()
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ru_RU"))
    private let request = SFSpeechAudioBufferRecognitionRequest()
    private var recognitionTask: SFSpeechRecognitionTask?
    private var speechRecognitionHandler: ((String)->Void)?
    
    func registerSpeechRecognitionHandler(block: @escaping(String)->Void) {
        self.speechRecognitionHandler = block
    }
    
    func startRecognize() {
        if startRecording() {
            startSpeechRecognition()
        } else {}
    }
    
    func startRecording() -> Bool {
        do {
            try? AVAudioSession.sharedInstance().setCategory(.playAndRecord, mode: .default,
            policy: .default, options: .defaultToSpeaker)
            return true
        } catch {
            print(error)
            return false
        }
    }
    
    func startSpeechRecognition() {
        
        let node = audioEngine.inputNode
        let recognitionFormat = node.outputFormat(forBus: 0)
        
        node.installTap(onBus: 0, bufferSize: 1024, format: recognitionFormat) {
            [unowned self](buffer, audioTime) in
            self.request.append(buffer)
        }
        
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch let error {
            print("\(error.localizedDescription)")
        }
        
        recognitionTask = speechRecognizer?.recognitionTask(with: request, resultHandler: {
            [weak self] (result, error) in
            if let res = result?.bestTranscription {
                DispatchQueue.main.async {
                    self?.speechRecognitionHandler?(res.formattedString)
                    print(res.formattedString.lowercased())
             }
          } else if let error = error {
              print("\(error.localizedDescription)")
          }
        })
    }
    
    func cancelSpeechRecognition() {
        audioEngine.stop()
        recognitionTask?.cancel()
        request.endAudio()
        audioEngine.inputNode.removeTap(onBus: 0)
    }
}
