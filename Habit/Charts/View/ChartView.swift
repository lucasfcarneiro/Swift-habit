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
        BoxChartView(entries: $viewModel.entries, dates: $viewModel.dates)
            .frame(maxWidth: .infinity, maxHeight: 350)
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
    ChartView(viewModel: ChartViewModel())
}
