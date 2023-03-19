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
    
    // категории новостей
    let categories = [NewsCategoryModel(id: 1, name: "главное", icon: "newspaper", sound: "literature.mp3", category: .general), NewsCategoryModel(id: 2, name: "технологии", icon: "technology", sound: "technology.wav", category: .technology), NewsCategoryModel(id: 3, name: "спорт", icon: "sport.jpeg", sound: "sport.mp3", category: .sport),NewsCategoryModel(id: 4, name: "бизнес", icon: "business", sound: "economics.mp3", category: .business), NewsCategoryModel(id: 5, name: "наука", icon: "science", sound: "chemistry.mp3", category: .science)]
    
    // получить новости
    func GetNews(category: NewsCategory) {
        
        var event: NewsFetchEvent?
        
        APIService.shared.execute(type: NewsResponse.self, category: category) { result in
            switch result {
            case .success(let data):
                event = NewsFetchEvent(identifier: UUID().uuidString, result: .success(data.articles))
                Bus.shared.publish(type: .newsFetch, event: event!)
            case .failure(let error):
                event = NewsFetchEvent(identifier: UUID().uuidString, result: .failure(error))
                Bus.shared.publish(type: .newsFetch, event: event!)
            }
        }
    }
    
    // выбрать конкретную категорию новостей
    func SelectNewsCategory(category: NewsCategoryModel) {
        player.PlaySound(resource: category.sound)
        GetNews(category: category.category)
    }
    
    // сгенерировать случайные статьи
    func GenerateRandomNews() {
        let randomCategory = categories[Int.random(in: 0..<categories.count - 1)]
        player.PlaySound(resource: randomCategory.sound)
        GetNews(category: randomCategory.category)
    }
}
