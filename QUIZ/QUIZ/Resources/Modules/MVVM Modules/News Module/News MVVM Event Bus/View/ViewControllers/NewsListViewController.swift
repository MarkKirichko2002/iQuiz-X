//
//  NewsListViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 29.06.2022.
//

import UIKit
import SafariServices
import Swinject

final class NewsListViewController: UITableViewController, CustomViewCellDelegate {
    
    private var newsListViewModel: NewsListViewModel?
    private let RefreshControl = UIRefreshControl()
    
    // MARK: - Init
    init(newsListViewModel: NewsListViewModel?) {
        self.newsListViewModel = newsListViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpViewModel()
        configureNavigation()
        SetUpTable()
    }
    
    private func SetUpViewModel() {
        let container = Container()
        // Container
        container.register(SoundClassProtocol.self) { _ in
            return SoundClass()
        }
        // ViewModel
        container.register(NewsListViewModel.self) { resolver in
            let viewModel = NewsListViewModel(
                player: resolver.resolve(SoundClassProtocol.self)
            )
            return viewModel
        }
        
        newsListViewModel = container.resolve(NewsListViewModel.self)
        
        Bus.shared.subscribeOnMain(.newsFetch) { [weak self] event in
            guard let result = event.result else {
                return
            }
            switch result {
            case .success (let news):
                self?.newsListViewModel?.news = news
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
        newsListViewModel?.GetNews(category: NewsCategories.categories[0])
    }
    
    private func configureNavigation() {
        let categoryBarButton = UIBarButtonItem(title: nil, image: UIImage(named: "list"), primaryAction: nil, menu: newsListViewModel?.categoryMenu)
        categoryBarButton.tintColor = .black
        navigationItem.rightBarButtonItem = categoryBarButton
        newsListViewModel?.registerCategoryChangedHandler { category in
            self.navigationItem.title = "\(category.name): \(category.articlesCount)"
        }
    }
    
    private func SetUpTable() {
        self.tableView.register(UINib(nibName: NewsTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: NewsTableViewCell.identifier)
        RefreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        tableView.addSubview(RefreshControl)
    }
    
    @objc private func GenerateRandomNews() {
        newsListViewModel?.GenerateRandomNews()
    }
    
    @objc private func refresh(_ sender: AnyObject) {
        DispatchQueue.main.async {
            self.newsListViewModel?.GetNews(category: NewsCategories.categories[0])
            self.tableView.reloadData()
            self.RefreshControl.endRefreshing()
        }
    }
    
    func didElementClick() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.performSegue(withIdentifier: "ShowWeb", sender: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SFSafariViewController(url: URL(string: self.newsListViewModel?.news[indexPath.row].url ?? "https://www.apple.com")!)
        self.present(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsListViewModel?.news.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else {fatalError()}
        if let articles = newsListViewModel?.news {
            cell.configure(news: articles[indexPath.row])
        }
        cell.delegate = self
        return cell
    }
}
