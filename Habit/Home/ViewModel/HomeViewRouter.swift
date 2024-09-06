//
//  HomeViewRouter.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 05/09/24.
//

import Foundation
import SwiftUI

enum HomeViewRouter {
    
    static func makeHabitView() -> some View {
        let viewModel = HabitViewModel()
        return HabitView(viewModel: viewModel)
    }
}
