//
//  HomeViewModel.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 10/08/24.
//

import SwiftUI

class HomeViewModel: ObservableObject{
    let viewModel = HabitViewModel(interactor: HabitInteractor()) //dessa forma para instanciar uma unica vez
    
}

extension HomeViewModel {
    
    func habitView() -> some View {
        return HomeViewRouter.makeHabitView(viewModel: viewModel)
    }
}
