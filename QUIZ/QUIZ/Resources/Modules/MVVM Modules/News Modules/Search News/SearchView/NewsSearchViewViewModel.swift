//
//  NewsSearchViewViewModel.swift
//  QUIZ
//
//  Created by Марк Киричко on 15.03.2023.
//

import Foundation

class NewsSearchViewViewModel: NSObject {
    
    private var searchText = ""
    
    private var searchResultHandler: ((NewsSearchResultViewModel)-> Void)?
    
    private var noResultsHandler: (()-> Void)?
    
    func setquery(text: String) {
        self.searchText = text
    }
    
    func ExecuteSearch() {
        APIService.shared.search(type: NewsResponse.self, with: searchText) { [weak self] result in
            switch result {
            case .success(let data):
                self?.processSearchResults(model: data)
                
                if data.articles?.count == 0 {
                    self?.handleNoResults()
                }
                
            case .failure(let error):
                print(error)
                self?.handleNoResults()
            }
        }
    }
    
    func registerSearchResultHandler(block: @escaping((NewsSearchResultViewModel)-> Void)) {
        self.searchResultHandler = block
    }
    
    func registerNoSearchResultHandler(block: @escaping()-> Void) {
        self.noResultsHandler = block
    }
    
    private func processSearchResults(model: Codable) {
        var resultsVM: NewsSearchResultViewModel?
        
        if let newsResults = model as? NewsResponse {
            resultsVM = .news(newsResults.articles ?? [Article]())
        }
        
        if let results = resultsVM {
            self.searchResultHandler?(results)
        } else {
            handleNoResults()
        }
    }

    private func handleNoResults() {
        noResultsHandler?()
    }
}
