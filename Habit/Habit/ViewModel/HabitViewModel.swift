//
//  HabitViewModel.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 05/09/24.
//

import Foundation
import SwiftUI
import Combine

class HabitViewModel: ObservableObject{
    
    @Published var uiState: HabitUIState = .loading
    
    @Published var title = "Atenção"
    @Published var headline = "Fique ligado"
    @Published var description = "você está atrasado nos hábitos"
    @Published var showAlert = false
    
    @Published var opened = false
    
    private var cancellableRequest: AnyCancellable?
    private let interactor: HabitInteractor
    
    init(interactor: HabitInteractor){
        self.interactor = interactor
        
    }
    
    deinit{
        cancellableRequest?.cancel()
    }
    
    
    func onAppear(){
        self.uiState = .loading
        
        cancellableRequest = interactor.fetchHabits()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch(completion) {
                case .failure(let appError):
                    self.uiState = .error(appError.message)
                    break
                case .finished:
                    break
                }
            }, receiveValue: { response in
                if response.isEmpty {
                    self.uiState = .emptyList
                    
                    self.title = ""
                    self.headline = "Fique ligado!"
                    self.description = "Você ainda não possui hábitos"
                    
                }else {
                    self.uiState = .fullList(
                        response.map {
                            
                            let lastDate = $0.lastDate?.toDate(sourcePattern: "yyyy-MM-dd'T'HH:mm:ss",
                                                               DestinePattern: "dd/MM/yyyy HH:mm") ?? ""
                            
                            var state = Color.green
                            self.title = "Muito bom!"
                            self.headline = "Seus hábitos estão em dia"
                            self.description = ""
                            
                            let dateToCompare = $0.lastDate?.toDate(sourcePattern: "yyyy-MM-dd'T'HH:mm:ss")
                            ?? Date()
                            
                            if dateToCompare < Date() {
                                state = .red
                                self.title = "Atenção!"
                                self.headline = "Fique ligado!"
                                self.description = "Você está atrasado nos hábitos"
                            }
                            
                            return HabitCardViewModel(id: $0.id,
                                                      icon: $0.iconUrl ?? "",
                                                      date: lastDate,
                                                      name: $0.name,
                                                      label: $0.label,
                                                      value: "\($0.value ?? 0)",
                                                      state: state)
                        })
                }
            })
    }
}
