//
//  BoxChartView.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 30/09/24.
//

import SwiftUI
import Charts


struct BoxChartView: UIViewRepresentable {
    typealias UIViewType = LineChartView
    
    @Binding var entries: [ChartDataEntry]
    @Binding var dates: [String]
    
    func makeUIView(context: Context) -> LineChartView {
        let uiView = LineChartView()
        
        uiView.legend.enabled = false
        uiView.chartDescription.enabled = false
        uiView.xAxis.granularity = 1
        uiView.xAxis.labelPosition = .bottom
        uiView.rightAxis.enabled = false
        uiView.xAxis.valueFormatter = DateAxisValueFormatter(values: dates)
        uiView.leftAxis.axisLineColor = .orange
        uiView.animate(yAxisDuration: 1.0)
        
        uiView.data = addData()
        
        return uiView
    }
    
    private func addData() -> LineChartData {
        
        let colors = [UIColor.white.cgColor, UIColor.darkOrange.cgColor]
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colorLocations: [CGFloat] = [0.0, 1.0]
        
        guard let gradient = CGGradient(colorsSpace: colorSpace,
                                        colors: colors as CFArray,
                                        locations: colorLocations) else {
            return LineChartData()
        }
        
        let dataSet = LineChartDataSet(entries: entries, label: "")
        
        dataSet.mode = .cubicBezier
        dataSet.lineWidth = 2
        dataSet.circleRadius = 4
        dataSet.setColor(.orange)
        dataSet.circleColors = [.red]
        dataSet.drawFilledEnabled = true
        dataSet.fillAlpha = 0.5
        dataSet.fill = LinearGradientFill(gradient: gradient, angle: 90.0)
        dataSet.valueColors = [.red]
        dataSet.drawHorizontalHighlightIndicatorEnabled = false
        
        return LineChartData(dataSet: dataSet)
    }
    
    func updateUIView(_ uiView: LineChartView, context: Context) {
        uiView.data = addData() // Make sure data updates when entries change
    }
}

class DateAxisValueFormatter: IndexAxisValueFormatter{
    
    let dates: [String]
    
    override init(values dates: [String]) {
            self.dates = dates
            super.init(values: dates)
        }
    
    override func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let position = Int(value)
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd"
        
        if position > 0 && position < dates.count {
            let date = formatter.date(from: dates[position])
            
            guard let date = date else{
                return ""
            }
            
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM"
            let createdAt = formatter.string(from: date)
            
            return createdAt
        }else{
            return ""
        }
    }
}

#Preview {
    BoxChartView(entries: .constant([
        ChartDataEntry(x: 1, y: 3),
        ChartDataEntry(x: 2, y: 4),
        ChartDataEntry(x: 3, y: 3),
        ChartDataEntry(x: 4, y: 5)
    ]),
                 dates: .constant([
                    "01/02/2024",
                    "02/02/2024",
                    "03/02/2024",
                    "04/02/2024"
                 ]))
    .frame(maxWidth: .infinity, maxHeight: 350)
}
