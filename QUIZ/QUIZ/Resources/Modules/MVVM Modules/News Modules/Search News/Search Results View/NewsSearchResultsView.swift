//
//  NewsSearchResultsView.swift
//  QUIZ
//
//  Created by Марк Киричко on 15.03.2023.
//

import UIKit

protocol NewsSearchResultsViewDelegate: AnyObject {
    func DidSelectArticle(article: Article)
}

class NewsSearchResultsView: UIView {

    weak var delegate: NewsSearchResultsViewDelegate?
    
    private var newsViewModel = NewsListViewModel()
    
    private var viewModel: NewsSearchResultViewModel? {
        didSet {
            self.processViewModel()
        }
    }
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableView)
        SetUpTable()
        Bus.shared.subscribeOnMain(.newsFetch) { [weak self] event in
            guard let result = event.result else {
                return
            }
            switch result {
            case .success (let news):
                self?.newsViewModel.news = news
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
        newsViewModel.GetNews(category: .general)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func processViewModel() {
        guard let viewModel = viewModel else {
            return
        }
        
        switch viewModel {
        case .news(let news):
            self.newsViewModel.news = news
            self.tableView.reloadData()
        case .noResults(_):
            self.newsViewModel.news = []
        }
    }
    
    private func SetUpTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: NewsTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: NewsTableViewCell.identifier)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    public func configure(with viewModel: NewsSearchResultViewModel) {
        self.viewModel = viewModel
    }
}

// MARK: - Table

extension NewsSearchResultsView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsViewModel.news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else {
            fatalError()
        }
        cell.configure(news: newsViewModel.news[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.DidSelectArticle(article: newsViewModel.news[indexPath.row])
    }
}


