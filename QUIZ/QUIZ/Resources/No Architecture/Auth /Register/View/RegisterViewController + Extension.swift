//
//  RegisterViewController + Extension.swift
//  QUIZ
//
//  Created by Марк Киричко on 25.06.2023.
//

import UIKit

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        
        guard let imageData = image.pngData() else {
            return
        }
        
        if self.loginTextField.text != "" {
            storage.child("images/\(self.loginTextField.text ?? "")").putData(imageData,
                                                                            metadata: nil,
                                                                            completion: { _, error in
                                                                                guard error == nil else {
                                                                                print("Failed to upload")
                                                                                    return
                                                                                }
                
                
                self.storage.child("images/\(self.loginTextField.text ?? "")").downloadURL(completion : { url, error in
                    guard let url = url, error == nil else {
                        return
                    }
                    
                    self.urlString = url.absoluteString
                    
                    DispatchQueue.main.async {
                        self.Image.image = image
                    }
                    
                    print("Download URL: \(self.urlString)")
                    UserDefaults.standard.set(self.urlString, forKey: "url")
                })
            })
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
