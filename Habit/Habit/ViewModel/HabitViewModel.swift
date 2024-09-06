//
//  HabitViewModel.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 05/09/24.
//

import Foundation

class HabitViewModel: ObservableObject{
    
    @Published var uiState: HabitUIState = .emptyList
    
    @Published var title = "Atenção"
    @Published var headline = "Fique ligado"
    @Published var description = "você está atrasado nos hábitos"
}
