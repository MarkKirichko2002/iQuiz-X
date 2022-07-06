//
//  NewsAPI.swift
//  QUIZ
//
//  Created by Марк Киричко on 29.06.2022.
//

import Foundation
import Alamofire
import DynamicJSON


class NewsViewModel {
    
    var news = [Article]()
    
    func GetNews(completion: @escaping([Article]) -> ()) {
        
        AF.request("https://newsapi.org/v2/top-headlines?country=ru&category=technology&apiKey=c6fb14909d524ae68ea631e5cb55ae67").responseData { response in
                  
            print(response.request as Any)
            print(response.response as Any)
        
            guard let data = response.data else { return }
            print(data)
            
            var newsresponse: NewsResponse?
            do {
                newsresponse = try JSONDecoder().decode(NewsResponse.self, from: data)
            } catch {
                print(error)
            }
            
            guard let news = newsresponse?.articles else { return }
            completion(news)
        }
    }
}

