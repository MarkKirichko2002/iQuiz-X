//
//  QuizSectionsViewModel.swift
//  QUIZ
//
//  Created by Марк Киричко on 18.01.2023.
//

import Combine

class QuizSectionsViewModel {
    
    private var completedQuizCategories = [QuizCategoryViewModel]()
    private var completedQuizTasks = [QuizTaskViewModel]()
    private var completedQuizAchievements = [QuizAchievementViewModel]()
    private var completePercentage = 0
    // MARK: - сервисы
    private let firebaseManager = FirebaseManager()
    
    @Published var sections = [
        QuizSectionModel(id: 1, name: "последняя категория", icon: "", sound: "", info: "", itemsCount: 1, completedItemsCount: 0, percentage: 0),
        QuizSectionModel(id: 2, name: "категории", icon: "astronomy", sound: "IQ.mp3", info: "На данный момент существует 19 категорий.", itemsCount: 19, completedItemsCount: 0, percentage: 0),
        QuizSectionModel(id: 3, name: "задания", icon: "tasks icon", sound: "IQ.mp3", info: "На данный момент существует 19 заданий.", itemsCount: 19, completedItemsCount: 0, percentage: 0),
        QuizSectionModel(id: 4, name: "достижения", icon: "trophy.png", sound: "league.mp3", info: "получите все достижения в iQuiz X!", itemsCount: 1, completedItemsCount: 0, percentage: 0),
        QuizSectionModel(id: 5, name: "iQuiz X обои", icon: "astronomy", sound: "", info: "", itemsCount: 18, completedItemsCount: nil, percentage: nil)
    ]
    
    func GetQuizSectionData() {
        
        // последняя категория викторины
        firebaseManager.LoadLastQuizCategoryData { category in
            self.completePercentage = (category.bestscore * 100) / 100
            self.sections[0].icon = category.icon
            self.sections[0].name = category.categoryName
            self.sections[0].sound = category.sound
            self.sections[0].completedItemsCount = 1
            self.sections[0].percentage = self.completePercentage
            self.sections[0].info = "лучший счет: \(category.bestscore)/100 \n правильные ответы: \(category.CorrectAnswersCounter)/20"
        }
        
        // категории
        for i in QuizCategories.categories {
            firebaseManager.LoadQuizCategoriesData(quizpath: i.quizpath) { category in
                if category.complete == true && category.score == 100 {
                    self.completedQuizCategories.append(category)
                    print(self.completedQuizCategories.count)
                    self.completePercentage = (self.completedQuizCategories.count * 100) / 19
                    self.sections[1].completedItemsCount = self.completedQuizCategories.count
                    self.sections[1].percentage = self.completePercentage
                }
            }
        }
        
        // задания
        for i in QuizTasks.tasks {
            firebaseManager.LoadQuizTasksData(quizpath: i.quizpath) { task in
                if task.complete == true {
                    self.completedQuizTasks.append(task)
                    print(self.completedQuizTasks.count)
                    self.completePercentage = (self.completedQuizTasks.count * 100) / 19
                    self.sections[2].completedItemsCount = self.completedQuizTasks.count
                    self.sections[2].percentage = self.completePercentage
                }
            }
        }
        
        // достижения
        for i in QuizAchievements.achievements {
            firebaseManager.LoadQuizAchievementsData(quizachievement: i) { achievement in
                if achievement.conditions[0].score == i.conditions[0].score && achievement.conditions[0].complete == i.conditions[0].complete {
                    self.completedQuizAchievements.append(achievement)
                    self.completePercentage = (self.completedQuizAchievements.count * 100) / 1
                    self.sections[3].completedItemsCount = self.completedQuizAchievements.count
                    self.sections[3].percentage = self.completePercentage
                }
            }
        }
    }
}
