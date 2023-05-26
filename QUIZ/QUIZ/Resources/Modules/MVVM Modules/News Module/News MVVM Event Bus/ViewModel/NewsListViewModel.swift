//
//  NewsListViewModel.swift
//  QUIZ
//
//  Created by Марк Киричко on 29.06.2022.
//

import UIKit

class NewsListViewModel {
    
    var news: [Article] = []
    
    // категории новостей
    let categories = NewsCategories.categories
    
    private var categoryChangedHandler: ((NewsCategoryViewModel)->Void)?
    
    // MARK: - сервисы
    private let player: SoundClassProtocol?
    
    // MARK: - Init
    init(player: SoundClassProtocol?) {
        self.player = player
    }
    
    func registerCategoryChangedHandler(block: @escaping(NewsCategoryViewModel)->Void) {
        self.categoryChangedHandler = block
    }
    
    // получить новости
    func GetNews(category: NewsCategoryModel) {
        
        var event: NewsFetchEvent?
        
        APIService.shared.execute(type: NewsResponse.self, category: category.endpoint) { result in
            switch result {
            case .success(let data):
                event = NewsFetchEvent(identifier: UUID().uuidString, result: .success(data.articles))
                Bus.shared.publish(type: .newsFetch, event: event!)
                let category = NewsCategoryViewModel(name: category.name, articlesCount: data.articles.count)
                self.categoryChangedHandler?(category)
            case .failure(let error):
                event = NewsFetchEvent(identifier: UUID().uuidString, result: .failure(error))
                Bus.shared.publish(type: .newsFetch, event: event!)
            }
        }
    }
    
    var categoryMenu: UIMenu {
        let menuActions = NewsCategories.categories.map({ (item) -> UIAction in
            let name = item.name
            return UIAction(title: name.capitalized, image: UIImage(named: item.icon)) { (_) in
                self.SelectNewsCategory(category: item)
            }
        })
        return UIMenu(title: "Выберите категорию", children: menuActions)
    }
    
    // выбрать конкретную категорию новостей
    func SelectNewsCategory(category: NewsCategoryModel) {
        player?.PlaySound(resource: category.sound)
        GetNews(category: category)
    }
    
    // сгенерировать случайные статьи
    func GenerateRandomNews() {
        let randomCategory = categories[Int.random(in: 0..<categories.count - 1)]
        player?.PlaySound(resource: randomCategory.sound)
        GetNews(category: randomCategory)
    }
}
