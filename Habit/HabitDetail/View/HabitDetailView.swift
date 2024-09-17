//
//  HabitDetailView.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 13/09/24.
//

import SwiftUI

struct HabitDetailView: View {
    
    @ObservedObject var viewModel : HabitDetailViewModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            
            VStack(alignment: .center, spacing: 12) {
                Text(viewModel.name)
                    .foregroundColor(Color.orange)
                    .font(.title.bold())
                
                Text("Unidade: \(viewModel.label)")
            }
            
            VStack {
                TextField("Escreva aqui o valor conquistado.", text: $viewModel.value)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(PlainTextFieldStyle())
                    .keyboardType(.numberPad)
                
                Divider()
                    .frame(height: 1)
                    .background(Color.gray)
                    .padding(.vertical, 8)
            }.padding()
            
            Text("Os registros devem ser feitos em até 24h.\nHábitos se constroem todos os dias :)")
                .padding()
        
            LoadingButtonView(action: {},
                              disable: self.viewModel.value.isEmpty,
                              showProgress: self.viewModel.uiState == .loading,
                              text: "Salvar")
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            
            Button("Cancelar"){
                //dissmiss / pop exit
            }
            .modifier(ButtonStyle())
            .padding(.horizontal,16)
            
            Spacer()
        }
        .padding(.horizontal, 8)
        .padding(.top, 32)
    }
}


#Preview {
    HabitDetailView(viewModel: HabitDetailViewModel(id: 1, name: "Tocar guitarra", label: "horas"))
        .preferredColorScheme(.dark)
}
#Preview {
    HabitDetailView(viewModel: HabitDetailViewModel(id: 1, name: "Tocar guitarra", label: "horas"))
        .preferredColorScheme(.light)
}
