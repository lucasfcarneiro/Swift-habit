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
    private var cancellableNotify: AnyCancellable?
    
    private let interactor: HabitInteractor
    let isCharts: Bool
    
    private let habitPublisher = PassthroughSubject<Bool, Never>()
    
    init(isCharts: Bool, interactor: HabitInteractor){
        self.isCharts = isCharts
        self.interactor = interactor
        
        //o habitPublisher é observado e sempre que for alterado o bloco é executado
        cancellableNotify = habitPublisher.sink(receiveValue: { saved in
            print("saved: \(saved)")
            self.onAppear() //recarrega a tela de habitos
        })
    }
    
    deinit{
        cancellableRequest?.cancel()
        cancellableNotify?.cancel()
    }
    
    
    func onAppear(){
        self.opened = true
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
                            
                            //sempre que o cartao é instanciado(ou seja, criado) passo o habitpublisher pra ele
                            return HabitCardViewModel(id: $0.id,
                                                      icon: $0.iconUrl ?? "",
                                                      date: lastDate,
                                                      name: $0.name,
                                                      label: $0.label,
                                                      value: "\($0.value ?? 0)",
                                                      state: state,
                                                      habitPublisher: self.habitPublisher)
                        })
                }
            })
    }
}
