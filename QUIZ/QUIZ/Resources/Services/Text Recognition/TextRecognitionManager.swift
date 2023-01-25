//
//  TextRecognitionManager.swift
//  QUIZ
//
//  Created by Марк Киричко on 04.01.2023.
//

import UIKit
import Vision

class TextRecognitionManager: TextRecognitionManagerProtocol {
    
    func recognizeText(image: UIImage,completion: @escaping(String)->()) {
        guard let cgImage = image.cgImage else {
            return
        }
        
        // Handler
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        
        // Request
        let request = VNRecognizeTextRequest { request,error in
            guard let observations = request.results as? [VNRecognizedTextObservation],
                  error == nil else {
                return
            }
            
            let text = observations.compactMap({
                $0.topCandidates(1).first?.string
            }).joined(separator: " ")
            completion(text)
        }
        
        do {
            try handler.perform([request])
        } catch {
            print(error)
        }
    }
}
