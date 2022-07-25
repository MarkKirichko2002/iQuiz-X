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
        newsViewModel.news.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        GetNews()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "URLViewController") as? URLViewController {
            vc.url = newsViewModel.news.value?[indexPath.row].url ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return newsViewModel.news.value?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as! NewsTableViewCell
        
        cell.NewsImage.sd_setImage(with: URL(string: newsViewModel.news.value?[indexPath.row].urlToImage ?? ""))
        cell.TitleLabel.text = newsViewModel.news.value?[indexPath.row].title ?? ""
        cell.DescriptionLabel.text = newsViewModel.news.value?[indexPath.row].description ?? ""
        
        return cell
    }
    
    func GetNews() {
        
        AF.request("https://newsapi.org/v2/top-headlines?country=ru&category=technology&apiKey=c6fb14909d524ae68ea631e5cb55ae67").responseData { response in
                  
            print(response.request as Any)
            print(response.response as Any)
        
            guard let data = response.data else { return }
            print(data)
            
            var newsresponse: NewsResponse?
            do {
                newsresponse = try JSONDecoder().decode(NewsResponse.self, from: data)
                self.newsViewModel.news.value = newsresponse?.articles.compactMap({
                    NewsTableViewCellViewModel(urlToImage: $0.urlToImage ?? "", url: $0.url ?? "", description: $0.description ?? "", title: $0.title ?? "")
                })
            } catch {
                print(error)
            }
        }
    }
}
