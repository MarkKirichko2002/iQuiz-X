//
//  NewsAPI.swift
//  QUIZ
//
//  Created by Марк Киричко on 29.06.2022.
//

import Foundation
import Alamofire

struct NewsListViewModel {
    
    var news: [Article] = []
    private let player = SoundClass()
    private let urls = ["https://newsapi.org/v2/top-headlines?country=ru&category=general&apiKey=c6fb14909d524ae68ea631e5cb55ae67","https://newsapi.org/v2/top-headlines?country=ru&category=science&apiKey=c6fb14909d524ae68ea631e5cb55ae67", "https://newsapi.org/v2/top-headlines?country=ru&category=technology&apiKey=c6fb14909d524ae68ea631e5cb55ae67", "https://newsapi.org/v2/top-headlines?country=ru&category=sport&apiKey=c6fb14909d524ae68ea631e5cb55ae67","https://newsapi.org/v2/top-headlines?country=ru&category=business&apiKey=c6fb14909d524ae68ea631e5cb55ae67"]
    private var url = "https://newsapi.org/v2/top-headlines?country=ru&category=science&apiKey=c6fb14909d524ae68ea631e5cb55ae67"
    
    // получить новости
    func GetNews() {
       
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
    
    mutating func CurrentCategory(category: NewsCategoryModel) {
        switch category.id {
            
        case 1:
            url = "https://newsapi.org/v2/top-headlines?country=ru&category=general&apiKey=c6fb14909d524ae68ea631e5cb55ae67"
            player.PlaySound(resource: "literature.mp3")
            GetNews()
            
        case 2:
            url = "https://newsapi.org/v2/top-headlines?country=ru&category=technology&apiKey=c6fb14909d524ae68ea631e5cb55ae67"
            player.PlaySound(resource: "technology.wav")
            GetNews()
            
        case 3:
            url = "https://newsapi.org/v2/top-headlines?country=ru&category=sport&apiKey=c6fb14909d524ae68ea631e5cb55ae67"
            player.PlaySound(resource: "sport.mp3")
            GetNews()
            
        case 4:
            url = "https://newsapi.org/v2/top-headlines?country=ru&category=business&apiKey=c6fb14909d524ae68ea631e5cb55ae67"
            player.PlaySound(resource: "economics.mp3")
            GetNews()
        
        case 5:
            url = "https://newsapi.org/v2/top-headlines?country=ru&category=science&apiKey=c6fb14909d524ae68ea631e5cb55ae67"
            player.PlaySound(resource: "chemistry.mp3")
            GetNews()
            
        default:
            break
            
        }
    }
    
    // сгенерировать случайные статьи
    mutating func GenerateRandomNews() {
        self.url = urls.randomElement() ?? ""
        player.PlaySound(resource: "dice.wav")
        switch url {
            
        case "https://newsapi.org/v2/top-headlines?country=ru&category=general&apiKey=c6fb14909d524ae68ea631e5cb55ae67":
            player.PlaySound(resource: "literature.mp3")
          
        case "https://newsapi.org/v2/top-headlines?country=ru&category=technology&apiKey=c6fb14909d524ae68ea631e5cb55ae67":
            player.PlaySound(resource: "technology.wav")
            
        case "https://newsapi.org/v2/top-headlines?country=ru&category=sport&apiKey=c6fb14909d524ae68ea631e5cb55ae67":
            player.PlaySound(resource: "sport.mp3")
            
        case "https://newsapi.org/v2/top-headlines?country=ru&category=business&apiKey=c6fb14909d524ae68ea631e5cb55ae67":
            player.PlaySound(resource: "economics.mp3")
        
        case "https://newsapi.org/v2/top-headlines?country=ru&category=science&apiKey=c6fb14909d524ae68ea631e5cb55ae67":
            player.PlaySound(resource: "chemistry.mp3")
            
        default:
            break
        }
        GetNews()
    }
}
