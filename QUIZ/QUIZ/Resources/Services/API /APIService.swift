//
//  APIService.swift
//  QUIZ
//
//  Created by Марк Киричко on 13.03.2023.
//

import Alamofire

class APIService: APIServiceProtocol {
    
    static let shared = APIService()
    
    struct Contacts {
        static var url = "https://newsapi.org/v2/top-headlines?country=ru&category=general&apiKey=c6fb14909d524ae68ea631e5cb55ae67"
        static let searchUrlString = "https://newsapi.org/v2/everything?sortedBy=popularity&apiKey=c6fb14909d524ae68ea631e5cb55ae67&q="
    }
    
    private init() {}
    
    func execute<T: Codable>(type: T.Type, category: NewsCategory, completion: @escaping (Result<T, Error>) -> Void) {
        Contacts.url = "https://newsapi.org/v2/top-headlines?country=ru&category=\(category.rawValue)&apiKey=c6fb14909d524ae68ea631e5cb55ae67"
        AF.request(Contacts.url).responseData { response in
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
    
    func search<T: Codable>(type: T.Type, with query: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        let urlstring = Contacts.searchUrlString + query
        guard let url = URL(string: urlstring) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(result))
                }
                catch {
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }
}
