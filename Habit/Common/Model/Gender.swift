//
//  Gender.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 12/08/24.
//

import Foundation

enum Gender : String, CaseIterable, Identifiable {
    case male = "Masculino"
    case female = "Feminino"
    
    var id: String{
        self.rawValue
    }
}
