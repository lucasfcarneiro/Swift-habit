//
//  Date+Extension.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 12/09/24.
//

import Foundation

extension Date {
    
    func toString(destinePattern destine: String) -> String {
        //Pegar a String -> dd/MM/yyyy -> Date
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = destine
        
        return formatter.string(from: self)
    }
}
