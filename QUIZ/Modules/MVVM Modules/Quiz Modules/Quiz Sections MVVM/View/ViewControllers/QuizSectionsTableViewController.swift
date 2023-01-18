//
//  QuizSectionsTableViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 18.01.2023.
//

import UIKit
import Combine

class QuizSectionsTableViewController: UIViewController {
    
    private var tableView = UITableView()
    private var cancellation: Set<AnyCancellable> = []
    private let player = SoundClass()
    private var quizSectionsViewModel = QuizSectionsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: QuizSectionsTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: QuizSectionsTableViewCell.identifier)
        quizSectionsViewModel.$sections.sink { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }.store(in: &cancellation)
        quizSectionsViewModel.GetQuizSectionData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

extension QuizSectionsTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizSectionsViewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        player.PlaySound(resource: quizSectionsViewModel.sections[indexPath.row].sound)
        
        if let cell = tableView.cellForRow(at: indexPath) as? QuizSectionsTableViewCell {
            cell.didSelect(indexPath: indexPath)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.GoToQuizSection(section: self.quizSectionsViewModel.sections[indexPath.row])
        }
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
        cell.configure(section: quizSectionsViewModel.sections[indexPath.row])
        return cell
    }
    
}
