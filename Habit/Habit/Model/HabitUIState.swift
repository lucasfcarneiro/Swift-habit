//
//  HabitUIState.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 05/09/24.
//

import Foundation

enum HabitUIState: Equatable {
        case loading
        case emptyList
        case fullList([HabitCardViewModel])
        case error(String)
}
