//
//  QuizCategoriesCollectionViewCellViewModel.swift
//  QUIZ
//
//  Created by Марк Киричко on 23.01.2023.
//

import Foundation

class QuizCategoriesCollectionViewCellViewModel {
    public var categoryName: String
    public var categoryIcon: String
    public var categoryScore: Int
    public var categoryComplete: Bool
    public var categoryBackground: String
    public var categorySound: String
    public var categoryMusic: String
    
    init(categoryName: String, categoryIcon: String, categoryScore: Int, categoryComplete: Bool, categoryBackground: String, categorySound: String, categoryMusic: String) {
        self.categoryName = categoryName
        self.categoryIcon = categoryIcon
        self.categoryScore = categoryScore
        self.categoryComplete = categoryComplete
        self.categoryBackground = categoryBackground
        self.categorySound = categorySound
        self.categoryMusic = categoryMusic
    }
    
}
