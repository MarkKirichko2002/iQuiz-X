//
//  NewsAPI.swift
//  QUIZ
//
//  Created by Марк Киричко on 29.06.2022.
//

import Foundation
import Alamofire

struct NewsListViewModel {
    
    public var news: [Article] = []
    
    public func GetNews() {
        let url = "https://newsapi.org/v2/top-headlines?country=ru&category=technology&apiKey=c6fb14909d524ae68ea631e5cb55ae67"
        
        AF.request(url).response { data in
            guard let data = data.data else {return}
        
            var event: NewsFetchEvent
            var news: NewsResponse
            
            do {
                news = try JSONDecoder().decode(NewsResponse.self, from: data)
                event = NewsFetchEvent(identifier: UUID().uuidString, result: .success(news.articles))
            } catch {
                event = NewsFetchEvent(identifier: UUID().uuidString,
                                          result: .failure(error))
            }
            Bus.shared.publish(type: .newsFetch, event: event)
        }
    }
}
