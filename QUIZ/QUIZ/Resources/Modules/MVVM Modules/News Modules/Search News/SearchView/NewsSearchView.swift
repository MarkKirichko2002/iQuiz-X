//
//  NewsSearchView.swift
//  QUIZ
//
//  Created by Марк Киричко on 15.03.2023.
//

import UIKit

protocol NewsSearchViewDelegate: AnyObject {
    func DidArticleTapped(article: Article)
}

class NewsSearchView: UIView {

    weak var delegate: NewsSearchViewDelegate?
    
    private let viewModel: NewsSearchViewViewModel
    
    private let searchInputView = NewsSearchInputView()
    
    private let noResultsView = NewsNoSearchResultsView()
    
    private let resultsView = NewsSearchResultsView()
    
    init(frame: CGRect, viewModel: NewsSearchViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(resultsView, noResultsView, searchInputView)
        addConstraints()
        
        searchInputView.delegate = self
        resultsView.delegate = self
        setUpHandlers(viewModel: viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setUpHandlers(viewModel: NewsSearchViewViewModel) {
        viewModel.registerSearchResultHandler { [weak self] results in
            DispatchQueue.main.async {
                self?.resultsView.configure(with: results)
                self?.noResultsView.isHidden = true
                self?.resultsView.isHidden = false
            }
        }
        viewModel.registerNoSearchResultHandler {
            DispatchQueue.main.async {
                self.resultsView.isHidden = true
                self.noResultsView.isHidden = false
            }
        }
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            // Search input view
            searchInputView.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            searchInputView.leftAnchor.constraint(equalTo: leftAnchor),
            searchInputView.rightAnchor.constraint(equalTo: rightAnchor),
            searchInputView.heightAnchor.constraint(equalToConstant: 100),
            
            resultsView.topAnchor.constraint(equalTo: searchInputView.bottomAnchor),
            resultsView.leftAnchor.constraint(equalTo: leftAnchor),
            resultsView.rightAnchor.constraint(equalTo: rightAnchor),
            resultsView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            // No results
            noResultsView.widthAnchor.constraint(equalToConstant: 150),
            noResultsView.heightAnchor.constraint(equalToConstant: 150),
            noResultsView.centerXAnchor.constraint(equalTo: centerXAnchor),
            noResultsView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}

extension NewsSearchView: NewsSearchInputViewDelegate {
    func newsSearchInputView(_ inputView: NewsSearchInputView, didChangeSearchText text: String) {
        viewModel.setquery(text: text)
    }
    
    func newsSearchInputViewDidTapSearchKeyboardButton(_ inputView: NewsSearchInputView) {
        viewModel.ExecuteSearch()
    }
}

extension NewsSearchView: NewsSearchResultsViewDelegate {
    func DidSelectArticle(article: Article) {
        delegate?.DidArticleTapped(article: article)
    }
}
