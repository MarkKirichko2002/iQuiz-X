//
//  NewsSearchInputView.swift
//  QUIZ
//
//  Created by Марк Киричко on 15.03.2023.
//

import UIKit

protocol NewsSearchInputViewDelegate: AnyObject {
    func newsSearchInputView(_ inputView: NewsSearchInputView,
                           didChangeSearchText text: String)
    
    func newsSearchInputViewDidTapSearchKeyboardButton(_ inputView: NewsSearchInputView)
}

final class NewsSearchInputView: UIView {

    weak var delegate: NewsSearchInputViewDelegate?
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Поиск"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private var viewModel: NewsSearchInputViewViewModel?
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(searchBar)
        addConstraints()
        
        searchBar.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Private
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: topAnchor),
            searchBar.leftAnchor.constraint(equalTo: leftAnchor),
            searchBar.rightAnchor.constraint(equalTo: rightAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 58)
        ])
    }
}

// MARK: - UISearchBarDelegate

extension NewsSearchInputView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Notify delegate of change text
        print(searchText)
        delegate?.newsSearchInputView(self, didChangeSearchText: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Notify that search button was tapped
        searchBar.resignFirstResponder()
        delegate?.newsSearchInputViewDidTapSearchKeyboardButton(self)
    }
}
