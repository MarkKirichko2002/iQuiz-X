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
        print(categories.categories.count)
    }
    
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.categories.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier, for: indexPath) as! CategoryTableViewCell
        
        cellmodel.configure(categories.categories[indexPath.row], CategoryImage: cell.CategoryImage, CategoryText: cell.CategoryText, isComplete: cell.isComplete, CategoryScore: cell.CategoryScore, background: cell)
        
        
        return cell
    }
    
}

