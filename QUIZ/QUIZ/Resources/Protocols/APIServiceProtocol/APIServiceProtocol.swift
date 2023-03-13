//
//  APIServiceProtocol.swift
//  QUIZ
//
//  Created by Марк Киричко on 13.03.2023.
//

import Foundation

protocol APIServiceProtocol {
    func execute<T: Codable>(type: T.Type, category: NewsCategory, completion: @escaping(Result<T, Error>)-> Void)
}
