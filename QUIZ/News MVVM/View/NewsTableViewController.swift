//
//  NewsTableViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 29.06.2022.
//

import UIKit
import SCLAlertView

class NewsTableViewController: UITableViewController {
    
    var newsViewModel = NewsViewModel()
    var newsArray: [Article] = []
    var newscellmodel = NewsTableViewCellModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsViewModel.GetNews { [weak self] news in
            guard let self = self else { return }
            self.newsArray = news
            self.tableView.reloadData()
            print(news)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return newsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as! NewsTableViewCell
        
        newscellmodel.configure(article: newsArray[indexPath.row], image: cell.NewsImage, title: cell.TitleLabel, description: cell.DescriptionLabel)
        
        return cell
    }
    
}
