//
//  ProfileUIState.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 19/09/24.
//

import Foundation

enum ProfileUIState: Equatable {
        case loading
        case fetchSuccess
        case fetchError(String)
        case none
}
