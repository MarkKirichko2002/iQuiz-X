//
//  NewsTableViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 29.06.2022.
//

import UIKit
import Alamofire
import SDWebImage


class NewsTableViewController: UITableViewController {
    
    var newsViewModel = NewsListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        newsViewModel.GetNews()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "URLViewController") as? URLViewController {
            vc.url = newsViewModel.news[indexPath.row].url ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return newsViewModel.news.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as! NewsTableViewCell
        
        cell.NewsImage.sd_setImage(with: URL(string: newsViewModel.news[indexPath.row].urlToImage ?? ""))
        cell.TitleLabel.text = newsViewModel.news[indexPath.row].title ?? ""
        cell.DescriptionLabel.text = newsViewModel.news[indexPath.row].description ?? ""
        
        return cell
    }
}
