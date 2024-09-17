//
//  HabitDetailUIState.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 13/09/24.
//

import Foundation

enum HabitDetailUIState: Equatable {
        case none
        case loading
        case success
        case error(String)
}
