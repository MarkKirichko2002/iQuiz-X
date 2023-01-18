//
//  QuizSectionsViewModel.swift
//  QUIZ
//
//  Created by Марк Киричко on 18.01.2023.
//

import Foundation
import Combine

class QuizSectionsViewModel {
    
    private let firebaseManager = FirebaseManager()
    private var completedQuizCategories = [QuizCategoryViewModel]()
    private var completedQuizTasks = [QuizTaskViewModel]()
    private var completePercentage = 0
    private let quizCategoriesViewModel = QuizCategoriesViewModel()
    private let quizTasksViewModel = QuizTasksViewModel()
    @Published var sections = [QuizSectionModel(id: 1, name: "категории", icon: "astronomy", sound: "IQ.mp3", itemsCount: 0, percentage: 0), QuizSectionModel(id: 2, name: "задания", icon: "tasks icon", sound: "IQ.mp3", itemsCount: 0, percentage: 0)]
    
    func GetQuizSectionData() {
        
        firebaseManager.LoadLastQuizCategoryData { category in
            self.sections[0].icon = category.icon
            self.sections[0].sound = category.sound
        }
        
        for i in quizCategoriesViewModel.quizcategories {
            firebaseManager.LoadQuizCategoriesData(quizpath: i.quizpath) { category in
                if category.complete == true {
                    self.completedQuizCategories.append(category)
                    print(self.completedQuizCategories.count)
                    self.completePercentage = (self.completedQuizCategories.count * 100) / 20
                    self.sections[0].itemsCount = self.completedQuizCategories.count
                    self.sections[0].percentage = self.completePercentage
                }
            }
        }
        
        for i in quizTasksViewModel.tasks {
            firebaseManager.LoadQuizTasksData(quizpath: i.quizpath) { task in
                if task.complete == true {
                    self.completedQuizTasks.append(task)
                    print(self.completedQuizTasks.count)
                    self.completePercentage = (self.completedQuizCategories.count * 100) / 20
                    self.sections[1].itemsCount = self.completedQuizTasks.count
                    self.sections[1].percentage = self.completePercentage
                }
            }
        }
    }
}
