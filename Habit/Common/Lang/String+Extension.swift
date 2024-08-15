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
}
