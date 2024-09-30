//
//  HabitCardViewRouter.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 17/09/24.
//

import SwiftUI
import Combine

enum HabitCardViewRouter {
    
    static func makeHabitDetailView(id:Int, name:String, label:String, habitPublisher: PassthroughSubject<Bool, Never> ) -> some View {
        //cria-se a tela de HabitDetailViewModel e injeta o publisher
        let viewModel = HabitDetailViewModel(id: id, name: name, label: label, interactor: HabitDetailInteractor())
        
        viewModel.habitPublisher = habitPublisher
        
        return HabitDetailView(viewModel: viewModel)
    }
    
    static func makeChartView() -> some View {
        return ChartView(viewModel: ChartViewModel())
    }
}
