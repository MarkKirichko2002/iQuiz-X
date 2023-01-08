//
//  QuizSegmentedViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 20.07.2022.
//

import UIKit

final class QuizSegmentedViewController: UIViewController {
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        setupSegmentedControl()
        updateView()
    }
    
    private func setupSegmentedControl() {
        // Configure Segmented Control
        segmentedControl.removeAllSegments()
        segmentedControl.insertSegment(with: UIImage(named: "categories"), at: 0, animated: true)
        segmentedControl.insertSegment(with: UIImage(named: "tasks"), at: 1, animated: true)
        segmentedControl.insertSegment(with: UIImage(named: "player"), at: 2, animated: true)
        segmentedControl.addTarget(self, action: #selector(selectionDidChange(_:)), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = UserDefaults.standard.object(forKey: "selectedSegmentIndex") as? Int ?? 0
    }
    
    @objc func selectionDidChange(_ sender: UISegmentedControl) {
        updateView()
    }
    
    private lazy var categoriesViewController: QuizCategoriesTableViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "QuizCategoriesTableViewController") as! QuizCategoriesTableViewController
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private lazy var tasksViewController: TasksTableViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "TasksTableViewController") as! TasksTableViewController
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private lazy var quizMediaLibraryTableViewController: QuizMediaLibraryTableViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "QuizMediaLibraryTableViewController") as! QuizMediaLibraryTableViewController
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private func add(asChildViewController viewController: UIViewController) {
        // Add Child View Controller
        addChild(viewController)
        
        // Add Child View as Subview
        view.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParent: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParent: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParent()
    }
    
    private func updateView() {
        if segmentedControl.selectedSegmentIndex == 0 {
            remove(asChildViewController: tasksViewController)
            add(asChildViewController: categoriesViewController)
        } else if segmentedControl.selectedSegmentIndex == 1  {
            remove(asChildViewController: categoriesViewController)
            add(asChildViewController: tasksViewController)
        } else if segmentedControl.selectedSegmentIndex == 2  {
            remove(asChildViewController: tasksViewController)
            add(asChildViewController: quizMediaLibraryTableViewController)
        }
        UserDefaults.standard.setValue(segmentedControl.selectedSegmentIndex, forKey: "selectedSegmentIndex")
    }
}
