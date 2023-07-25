//
//  QuizTabBarController + Extensions.swift
//  QUIZ
//
//  Created by Марк Киричко on 24.06.2023.
//

import UIKit

extension QuizTabBarController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            picker.dismiss(animated: true, completion: nil)
            self.speechRecognition.startRecognize()
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as?
                UIImage else {
            return
        }
        
        quizCategoriesViewModel.CheckText(image: image)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            picker.dismiss(animated: true, completion: nil)
            self.speechRecognition.startRecognize()
        }
    }
}
