//
//  NewsTableViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 29.06.2022.
//

import UIKit
import SafariServices

final class NewsTableViewController: UITableViewController, CustomViewCellDelegate, UISearchBarDelegate {
    
    private var newsViewModel = NewsListViewModel()
    private let RefreshControl = UIRefreshControl()
    private let dateManager = DateManager()
    @IBOutlet weak var DiceButton: UIBarButtonItem!
    
    private let searchVC = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Сегодня: \(dateManager.GetCurrentDate())"
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
        navigationItem.searchController = searchVC
        searchVC.searchBar.delegate = self
    }
    
    @IBAction func GenerateRandomNews() {
        newsViewModel.GenerateRandomNews()
    }
    
    @objc func refresh(_ sender: AnyObject) {
        DispatchQueue.main.async {
            self.newsViewModel.GetNews(category: .general)
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
        return cell
    }
    
    // Поиск
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        
        APIService.shared.search(type: NewsResponse.self, with: text) { [weak self] result in
            switch result {
            case .success(let data):
                self?.newsViewModel.news = data.articles
            
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.searchVC.dismiss(animated: true)
                }
            case .failure(let error):
                print(error)
            }
        }
        print(text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        newsViewModel.GetNews(category: .general)
        self.tableView.reloadData()
    }

}
