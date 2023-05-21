//
//  APIService.swift
//  QUIZ
//
//  Created by Марк Киричко on 13.03.2023.
//

import Alamofire

class APIService: APIServiceProtocol {
    
    static let shared = APIService()
    
    private init() {}
    
    func execute<T: Codable>(type: T.Type, category: NewsCategory, completion: @escaping (Result<T, Error>) -> Void) {
        
        AF.request("https://newsapi.org/v2/top-headlines?country=ru&category=\(category.rawValue)&apiKey=c6fb14909d524ae68ea631e5cb55ae67").responseData { response in
            guard let data = response.data else {return}
            
            var response: T
            
            do {
                response = try JSONDecoder().decode(T.self, from: data)
                completion(.success(response))
            } catch {
                print(error)
            }
        }
    }
}
