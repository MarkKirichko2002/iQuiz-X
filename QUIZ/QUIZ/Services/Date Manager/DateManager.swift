//
//  DateManager.swift
//  QUIZ
//
//  Created by Марк Киричко on 05.01.2023.
//

import Foundation

class DateManager: DateManagerProtocol {
    
    private let date = Date()
    
    func GetCurrentDate()-> String {
        var currentDate = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        currentDate = dateFormatter.string(from: date)
        return currentDate
    }
    
}
