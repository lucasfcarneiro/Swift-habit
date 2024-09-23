//
//  HomeViewModel.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 10/08/24.
//

import SwiftUI

class HomeViewModel: ObservableObject{
    let habitViewModel = HabitViewModel(interactor: HabitInteractor())//dessa forma para instanciar uma unica vez
    let profileViewModel = ProfileViewModel()
}

extension HomeViewModel {
    
    func habitView() -> some View {
        return HomeViewRouter.makeHabitView(viewModel: habitViewModel)
    }
    
    func profileView() -> some View {
        return HomeViewRouter.makeProfileView(viewModel: profileViewModel)
    }
}
