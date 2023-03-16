//
//  NewsSearchViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 15.03.2023.
//

import UIKit
import SafariServices

class NewsSearchViewController: UIViewController {

    private let viewModel: NewsSearchViewViewModel
    private let searchView: NewsSearchView
    
    init(viewModel: NewsSearchViewViewModel) {
        let viewModel = NewsSearchViewViewModel()
        self.viewModel = viewModel
        self.searchView = NewsSearchView(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(searchView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Поиск",
            style: .done,
            target: self,
            action: #selector(didTapExecuteSearch)
        )
        searchView.delegate = self
        addConstraints()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.topAnchor),
            searchView.leftAnchor.constraint(equalTo: view.leftAnchor),
            searchView.rightAnchor.constraint(equalTo: view.rightAnchor),
            searchView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc func didTapExecuteSearch() {
        viewModel.ExecuteSearch()
    }
}

extension NewsSearchViewController: NewsSearchViewDelegate {
    func DidArticleTapped(article: Article) {
        guard let articleUrl = article.url else {return}
        let vc = SFSafariViewController(url: URL(string: articleUrl)!)
        present(vc, animated: true)
    }
}
