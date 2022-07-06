//
//  TabItem.swift
//  QUIZ
//
//  Created by Марк Киричко on 05.04.2022.
//

import UIKit

enum TabItem: String, CaseIterable {
    case today = "today"
    case categories = "categories"
    case tasks = "tasks"
    case players = "players"
    case profile = "profile"
    
    
    var viewController: UIViewController {
        switch self {
        case .today:
            return TodayTableViewController()
        case .categories:
            return CategoryTableViewController()
        case .tasks:
            return TasksTableViewController()
        case .players:
            return TasksTableViewController()
        case .profile:
            return PlayerBoardTableViewController()
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .today:
            return UIImage(named: "earth.jpeg")!
        case .categories:
            return UIImage(named: "history.jpeg")!
        case .tasks:
            return UIImage(named: "anatomy.jpeg")!
        case .players:
            return UIImage(named: "sport.jpeg")!
        case .profile:
            return UIImage(named: "games.jpeg")!
        }
    }
    
    var displayTitle: String {
        return self.rawValue.capitalized(with: nil)
    }
}

