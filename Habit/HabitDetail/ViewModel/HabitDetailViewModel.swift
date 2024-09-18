//
//  HabitDetailViewModel.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 13/09/24.
//

import Foundation
import SwiftUI
import Combine

class HabitDetailViewModel: ObservableObject {
    
    @Published var uiState: HabitDetailUIState = .none
    @Published var value = ""
    
    private var cancellable: AnyCancellable?
    
    let id: Int
    let name: String
    let label: String
    let interactor: HabitDetailInteractor
    
    init (id: Int, name: String, label: String, interactor: HabitDetailInteractor){
        self.id = id
        self.name = name
        self.label = label
        self.interactor = interactor
    }
    
    deinit{
        cancellable?.cancel()
    }
    
    func save(){
        self.uiState = .loading
        cancellable = interactor.save(habitId: id, habitValueRequest: HabitValueRequest(value: value))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch(completion) {
                case .failure(let appError):
                    self.uiState = .error(appError.message)
                    break
                case .finished:
                    break
                }
            }, receiveValue: { createdHabit in
                if createdHabit {
                    self.uiState = .success
                }
            })
    }
}
