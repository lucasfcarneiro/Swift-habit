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
    
    var index: Self.AllCases.Index {
        return Self.allCases.firstIndex {self == $0} ?? 0 //pega o valor do picker selecionado, 0 ou 1 no caso
    }
}
