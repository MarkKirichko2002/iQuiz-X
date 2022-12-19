//
//  TotalTableViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 15.03.2022.
//

import UIKit
import Combine

final class TotalTableViewController: UITableViewController {

    var categoriesViewModel = CategoriesViewModel()
    var timer = Timer()
    var cancellation: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoriesViewModel.$categories.sink { [weak self] category in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }.store(in: &cancellation)
        self.categoriesViewModel.LoadCategoriesResults()
        self.tableView.register(UINib(nibName: CategoryTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CategoryTableViewCell.identifier)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return categoriesViewModel.categories.count
    }
    
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       categoriesViewModel.categories[section].categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier, for: indexPath) as! CategoryTableViewCell
        cell.ConfigureCell(category: categoriesViewModel.categories[indexPath.section].categories[indexPath.row])
        return cell
    }
    
}

