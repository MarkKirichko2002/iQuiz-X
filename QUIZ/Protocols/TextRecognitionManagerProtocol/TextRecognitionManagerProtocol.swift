//
//  TextRecognitionManagerProtocol.swift
//  QUIZ
//
//  Created by Марк Киричко on 08.01.2023.
//

import UIKit

protocol TextRecognitionManagerProtocol {
    func recognizeText(image: UIImage,completion: @escaping(String)->())
}
