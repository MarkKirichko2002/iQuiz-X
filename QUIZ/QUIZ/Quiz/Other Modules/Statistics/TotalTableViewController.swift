//
//  TotalTableViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 15.03.2022.
//

import UIKit

final class TotalTableViewController: UITableViewController {

    var categories = CategoriesViewModel()
    var cellmodel = CategoriesTableViewCellModel()
    
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: CategoryTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CategoryTableViewCell.identifier)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return categories.categories.count
    }
    
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       categories.categories[section].categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier, for: indexPath) as! CategoryTableViewCell
        cellmodel.configure(categories.categories[indexPath.section].categories[indexPath.row], CategoryImage: cell.CategoryImage, CategoryText: cell.CategoryText, isComplete: cell.isComplete, CategoryScore: cell.CategoryScore, background: cell)
        cell.CategoryImage.sound = categories.categories[indexPath.section].categories[indexPath.row].sound
        cell.CategoryImage.color = .white
        
        return cell
    }
    
}

