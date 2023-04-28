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
    private var completedQuizAchievements = [QuizAchievementViewModel]()
    private var completePercentage = 0
    private let quizCategoriesViewModel = QuizCategoriesViewModel()
    private let quizTasksViewModel = QuizTasksViewModel()
    private let quizAchievementsViewModel = QuizAchievementsViewModel()
    
    @Published var sections = [QuizSectionModel(id: 1, name: "категории", icon: "astronomy", sound: "IQ.mp3", info: "На данный момент существует 19 категорий.", itemsCount: 19, completedItemsCount: 0, percentage: 0), QuizSectionModel(id: 2, name: "задания", icon: "tasks icon", sound: "IQ.mp3", info: "На данный момент существует 19 заданий.", itemsCount: 19, completedItemsCount: 0, percentage: 0), QuizSectionModel(id: 3, name: "достижения", icon: "trophy.png", sound: "league.mp3", info: "получите все достижения в iQuiz X!", itemsCount: 1, completedItemsCount: 0, percentage: 0)]
    
    func GetQuizSectionData() {
        
        // последняя категория викторины
        firebaseManager.LoadLastQuizCategoryData { category in
            self.sections[0].icon = category.icon
            self.sections[0].sound = category.sound
        }
        
        // категории
        for i in quizCategoriesViewModel.quizcategories {
            firebaseManager.LoadQuizCategoriesData(quizpath: i.quizpath) { category in
                if category.complete == true && category.score == 100 {
                    self.completedQuizCategories.append(category)
                    print(self.completedQuizCategories.count)
                    self.completePercentage = (self.completedQuizCategories.count * 100) / 19
                    self.sections[0].completedItemsCount = self.completedQuizCategories.count
                    self.sections[0].percentage = self.completePercentage
                }
            }
        }
        
        // задания
        for i in quizTasksViewModel.tasks {
            firebaseManager.LoadQuizTasksData(quizpath: i.quizpath) { task in
                if task.complete == true {
                    self.completedQuizTasks.append(task)
                    print(self.completedQuizTasks.count)
                    self.completePercentage = (self.completedQuizTasks.count * 100) / 19
                    self.sections[1].completedItemsCount = self.completedQuizTasks.count
                    self.sections[1].percentage = self.completePercentage
                }
            }
        }
        
        // достижения
        for i in quizAchievementsViewModel.achievements {
            firebaseManager.LoadQuizAchievementsData(quizachievement: i) { achievement in
                if achievement.conditions[0].score == i.conditions[0].score && achievement.conditions[0].complete == i.conditions[0].complete {
                    self.completedQuizAchievements.append(achievement)
                    self.completePercentage = (self.completedQuizAchievements.count * 100) / 1
                    self.sections[2].completedItemsCount = self.completedQuizAchievements.count
                    self.sections[2].percentage = self.completePercentage
                }
            }
        }
    }
}