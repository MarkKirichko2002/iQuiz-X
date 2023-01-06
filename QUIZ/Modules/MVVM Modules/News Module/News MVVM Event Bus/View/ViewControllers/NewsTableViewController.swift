//
//  NewsTableViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 29.06.2022.
//

import UIKit
import Alamofire
import SDWebImage

final class NewsTableViewController: UITableViewController, CustomViewCellDelegate {
    
    private var newsViewModel = NewsListViewModel()
    private let RefreshControl = UIRefreshControl()
    private let player = SoundClass()
    private let dateManager = DateManager()
    @IBOutlet weak var DiceButton: UIBarButtonItem!
    
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
        newsViewModel.GetNews()
    }
    
    @IBAction func GenerateRandomNews() {
        newsViewModel.GenerateRandomNews()
    }
    
    @objc func refresh(_ sender: AnyObject) {
        DispatchQueue.main.async {
            self.newsViewModel.GetNews()
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
        
        player.PlaySound(resource: "literature.mp3")
        
        if let cell = tableView.cellForRow(at: indexPath) as? NewsTableViewCell {
            cell.didSelect(indexPath: indexPath)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowWeb",
           let destinationController = segue.destination as? URLViewController,
           let indexSelectedCell = tableView.indexPathForSelectedRow {
           let url = newsViewModel.news[indexSelectedCell.row].url
           guard let url = url else {return}
           destinationController.url = url
        }
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
}
