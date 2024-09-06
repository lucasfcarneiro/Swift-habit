//
//  HomeViewModel.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 10/08/24.
//

import SwiftUI

class HomeViewModel: ObservableObject{
    
    
}

extension HomeViewModel {
    
    func habitView() -> some View {
        return HomeViewRouter.makeHabitView()
    }
}
