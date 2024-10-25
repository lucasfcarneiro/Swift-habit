//
//  ChartView.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 25/09/24.
//

import SwiftUI
import Charts

struct ChartView: View {
    
    @ObservedObject var viewModel: ChartViewModel
    
    var body: some View {
        ZStack {
            if case ChartUIState.loading = viewModel.uiState {
                ProgressView()
            }else{
                VStack {
                    if case ChartUIState.emptyChart = viewModel.uiState {
                        
                        Image(systemName: "exclamationmark.octagon.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24, alignment: .center)
                        
                        Text("Nenhum hábito encontrado :(")
                    }else if case ChartUIState.error(let msg) = viewModel.uiState {
                        
                        Text("")
                            .alert(isPresented: .constant(true)) {
                                Alert(
                                    title: Text("Ops! \(msg)"),
                                    message: Text("Tentar novamente?"),
                                    primaryButton: .default(Text("Sim")) {
                                        // aqui executa a retentativa
                                        viewModel.onAppear()
                                    },
                                    secondaryButton: .cancel()
                                )
                            }
                    }else {
                        BoxChartView(entries: $viewModel.entries, dates: $viewModel.dates)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            
                    }
                }
            }
        }
        .onAppear(perform: viewModel.onAppear)
    }
}





//Exemplo de como criar uma view usando o UIkit
//struct TestView:UIViewRepresentable {
//    typealias UIViewType = UILabel
//
//    func makeUIView(context: Context) -> UILabel {
//
//        let lb = UILabel()
//        lb.backgroundColor = UIColor.red
//        lb.text = "Ola"
//        return lb
//    }
//
//    func updateUIView(_ uiView: UILabel, context: Context) {
//
//    }
//}

#Preview {
    ChartView(viewModel: ChartViewModel(habitId: 570, interactor: ChartInteractor()))
}
