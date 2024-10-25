//
//  ChartViewModel.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 30/09/24.
//

import Foundation
import SwiftUI
import Charts
import Combine

class ChartViewModel: ObservableObject {
    
    @Published var uiState = ChartUIState.loading
    @Published var entries: [ChartDataEntry] = []
    @Published var dates: [String] = []
    
    private var cancellable: AnyCancellable?
    
    private let habitId: Int
    private let interactor: ChartInteractor
    
    init(habitId: Int, interactor: ChartInteractor) {
        self.habitId = habitId
        self.interactor = interactor
    }
    
    deinit{
        cancellable?.cancel()
    }
    
    func onAppear() {
        cancellable = interactor.fetchHabitValue(habitId: habitId)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch(completion){
                case .failure(let appError):
                    self.uiState = .error(appError.message)
                case . finished:
                    break
                }
            }, receiveValue: { response in
                if response.isEmpty {
                    self.uiState = .emptyChart
                }else{
                    self.dates = response.map{$0.createdDate}
                    
                    // [0...N] , [HabitValueResponse] percorre os valores da resposta para criar uma lista afim de injetar no grafico
                    self.entries = zip(response.startIndex..<response.endIndex, response).map{ index, response in
                        ChartDataEntry(x: Double(index), y: Double(response.value))
                    }
                    self.uiState = .fullChart
                    print()
                }
            })
    }
}
