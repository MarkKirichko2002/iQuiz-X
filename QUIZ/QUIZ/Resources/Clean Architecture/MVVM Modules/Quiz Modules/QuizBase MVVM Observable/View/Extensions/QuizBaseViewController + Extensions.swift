//
//  QuizBaseViewController + Extensions.swift
//  QUIZ
//
//  Created by Марк Киричко on 25.06.2023.
//

import UIKit

// UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension QuizBaseViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            picker.dismiss(animated: true, completion: nil)
            self.quiz?.speechRecognition.startSpeechRecognition()
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as?
        UIImage else {
            return
        }
        quiz?.recognizeText(image: image)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            picker.dismiss(animated: true, completion: nil)
            self.quiz?.speechRecognition.startSpeechRecognition()
        }
    }
}
