//
//  String+Extension.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 14/08/24.
//

import Foundation

extension String{
    func isEmail() -> Bool {
        let emailRegEx = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"

        return NSPredicate(format: "SELF MATCHES %@", emailRegEx).evaluate(with: self)
    }
    
    func toDate(sourcePattern source: String, DestinePattern destine: String) -> String?{
        
        //Pegar a String -> dd/MM/yyyy -> Date
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = source
        
        let dateFormatted = formatter.date(from: self)
        
        //Validar a Data
        guard let dateFormatted = dateFormatted else {
            return nil
        }
        
        //Date -> yyyy/MM/dd -> String
        formatter.dateFormat = destine
        return formatter.string(from: dateFormatted)
    }
}
