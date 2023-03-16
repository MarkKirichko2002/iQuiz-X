//
//  NewsTableViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 29.06.2022.
//

import UIKit
import SafariServices

final class NewsTableViewController: UITableViewController, CustomViewCellDelegate {
    
    private var newsViewModel = NewsListViewModel()
    private let RefreshControl = UIRefreshControl()
    private let searchVC = UISearchController(searchResultsController: nil)
    private let currentCategory = UIBarButtonItem(image: UIImage(systemName: "newspaper"), style: .done, target: self, action: #selector(didTapCategoryIcon))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSearchButton()
        self.navigationItem.title = "Сегодня: \(newsViewModel.GetCurrentDate())"
        self.tableView.register(UINib(nibName: NewsTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: NewsTableViewCell.identifier)
        RefreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        tableView.addSubview(RefreshControl)
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
        newsViewModel.registerRandomCategoryHandler { category in
            self.title = category.name
            self.newsViewModel.sound = category.sound
            self.currentCategory.image = UIImage(named: category.categoryicon)
        }
    }
    
   @objc func GenerateRandomNews() {
        newsViewModel.GenerateRandomNews()
    }
    
    private func addSearchButton() {
        let search = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .done, target: self, action: #selector(didTapSearch))
        search.tintColor = .black
        currentCategory.tintColor = .black
        let DiceButton = UIBarButtonItem(image: UIImage(systemName: "dice"), style: .done, target: self, action: #selector(GenerateRandomNews))
        DiceButton.tintColor = .black
        navigationItem.setRightBarButtonItems([currentCategory,search,DiceButton], animated: true)
    }
    
    @objc private func didTapSearch() {
        let viewModel = NewsSearchViewViewModel()
        let vc = NewsSearchViewController(viewModel: viewModel)
        vc.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func refresh(_ sender: AnyObject) {
        DispatchQueue.main.async {
            self.newsViewModel.GetNews(category: .general)
            self.tableView.reloadData()
            self.RefreshControl.endRefreshing()
        }
    }
    
    @objc private func didTapCategoryIcon() {
       
    }
    
    func didElementClick() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.performSegue(withIdentifier: "ShowWeb", sender: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SFSafariViewController(url: URL(string: self.newsViewModel.news[indexPath.row].url ?? "https://www.apple.com")!)
        self.present(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsViewModel.news.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as! NewsTableViewCell
        cell.delegate = self
        cell.configure(news: newsViewModel.news[indexPath.row])
        cell.NewsImage.sound = self.newsViewModel.sound
        return cell
    }
}
