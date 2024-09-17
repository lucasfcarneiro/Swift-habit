//
//  HabitCardViewRouter.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 17/09/24.
//

import SwiftUI
import Combine

enum HabitCardViewRouter {
    
    static func makeHabitDetailView(id:Int, name:String, label:String ) -> some View {
        
        let viewModel = HabitDetailViewModel(id: id, name: name, label: label)
        return HabitDetailView(viewModel: viewModel)
    }
}
