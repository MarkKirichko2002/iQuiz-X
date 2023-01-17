//
//  QuizSectionsTableViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 18.01.2023.
//

import UIKit

class QuizSectionsTableViewController: UIViewController {
    
    private var sections = [QuizSectionModel(id: 1, name: "категории", icon: "astronomy"), QuizSectionModel(id: 2, name: "задания", icon: "tasks icon")]
    private var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: QuizSectionsTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: QuizSectionsTableViewCell.identifier)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

extension QuizSectionsTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.GoToQuizSection(section: sections[indexPath.row])
    }
    
    func GoToQuizSection(section: QuizSectionModel) {
        
        switch section.id {
            
        case 1:
            if let vc = storyboard?.instantiateViewController(withIdentifier: "QuizCategoriesTableViewController") as? QuizCategoriesTableViewController {
                vc.title = "Категории"
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        case 2:
            if let vc = storyboard?.instantiateViewController(withIdentifier: "QuizTasksTableViewController") as? QuizTasksTableViewController {
                vc.title = "Задания"
                self.navigationController?.pushViewController(vc, animated: true)
            }
                        
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: QuizSectionsTableViewCell.identifier, for: indexPath) as? QuizSectionsTableViewCell else {return UITableViewCell()}
        cell.configure(section: sections[indexPath.row])
        return cell
    }
    
}
