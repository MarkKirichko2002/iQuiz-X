//
//  NewsAPI.swift
//  QUIZ
//
//  Created by Марк Киричко on 29.06.2022.
//

import Foundation
import Alamofire

class NewsListViewModel {
    
    var news: [Article] = []
    var sound = "newspaper.mp3"
    private let player = SoundClass()
    private let dateManager = DateManager()
    private var randomCategoryHandler: ((NewsCategoryModel)->Void)?
    
    // категории новостей
    let categories = [NewsCategoryModel(id: 1, name: "Главное", icon: "newspaper", categoryicon: "top news icon", sound: "literature.mp3", category: .general), NewsCategoryModel(id: 2, name: "Технологии", icon: "technology", categoryicon: "technology icon", sound: "technology.wav", category: .technology), NewsCategoryModel(id: 3, name: "Спорт", icon: "sport.jpeg", categoryicon: "sport icon", sound: "sport.mp3", category: .sport),NewsCategoryModel(id: 4, name: "Бизнес", icon: "business", categoryicon: "business icon", sound: "economics.mp3", category: .business), NewsCategoryModel(id: 5, name: "Наука", icon: "science", categoryicon: "science icon", sound: "chemistry.mp3", category: .science)]
    
    // получить новости
    func GetNews(category: NewsCategory) {
        
        var event: NewsFetchEvent?
        
        APIService.shared.execute(type: NewsResponse.self, category: category) { result in
            switch result {
            case .success(let data):
                guard let news = data.articles else {return}
                event = NewsFetchEvent(identifier: UUID().uuidString, result: .success(news))
                Bus.shared.publish(type: .newsFetch, event: event!)
            case .failure(let error):
                event = NewsFetchEvent(identifier: UUID().uuidString, result: .failure(error))
                Bus.shared.publish(type: .newsFetch, event: event!)
            }
        }
    }
    
    // получить текущую дату
    func GetCurrentDate()-> String {
        return dateManager.GetCurrentDate()
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
        randomCategoryHandler?(randomCategory)
    }
    
    func registerRandomCategoryHandler(block: @escaping(NewsCategoryModel)-> Void) {
        self.randomCategoryHandler = block
    }
}
