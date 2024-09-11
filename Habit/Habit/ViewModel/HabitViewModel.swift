//
//  HabitViewModel.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 05/09/24.
//

import Foundation

class HabitViewModel: ObservableObject{
    
    @Published var uiState: HabitUIState = .loading
    
    @Published var title = "Atenção"
    @Published var headline = "Fique ligado"
    @Published var description = "você está atrasado nos hábitos"
    @Published var showAlert = false
    
    func onAppear(){
        self.uiState = .loading
        //self.uiState = .error("Falha interna")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            
            
            var rows: [HabitCardViewModel] = []
            
            rows.append(HabitCardViewModel(id: 1,
                                           icon: "https://placehold.co/150x150",
                                           date: "01/01/2024 12:35:35",
                                           name: "Tocar guitarra",
                                           label: "horas",
                                           value: "2",
                                           state: .green))
            
            rows.append(HabitCardViewModel(id: 2,
                                           icon: "https://placehold.co/150x150",
                                           date: "01/01/2024 12:35:35",
                                           name: "Leitura",
                                           label: "minutos",
                                           value: "40",
                                           state: .green))

            rows.append(HabitCardViewModel(id: 3,
                                           icon: "https://placehold.co/150x150",
                                           date: "01/01/2024 12:35:35",
                                           name: "Tocar guitarra",
                                           label: "horas",
                                           value: "2",
                                           state: .green))

            rows.append(HabitCardViewModel(id: 4,
                                           icon: "https://placehold.co/150x150",
                                           date: "01/01/2024 12:35:35",
                                           name: "Corrida",
                                           label: "km",
                                           value: "5",
                                           state: .green))


            //self.uiState = .fullList(rows)
            self.uiState = .error("Falha interna")
            //self.uiState = .emptyList
            
        }
    }
}
