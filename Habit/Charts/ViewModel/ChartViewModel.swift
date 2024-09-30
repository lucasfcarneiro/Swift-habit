//
//  ChartViewModel.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 30/09/24.
//

import Foundation
import SwiftUI
import Charts

class ChartViewModel: ObservableObject {
    
    @Published var entries: [ChartDataEntry] = [
        ChartDataEntry(x: 1, y: 2),
        ChartDataEntry(x: 2, y: 5),
        ChartDataEntry(x: 3, y: 7),
        ChartDataEntry(x: 4, y: 4),
        ChartDataEntry(x: 5, y: 6),
        ChartDataEntry(x: 6, y: 2),
        ChartDataEntry(x: 7, y: 10),
        ChartDataEntry(x: 8, y: 9),
        
    ]
    
    @Published var dates = [
        "2024-01-01",
        "2024-01-02",
        "2024-01-03",
        "2024-01-04",
        "2024-01-05",
        "2024-01-06",
        "2024-01-07",
        "2024-01-08",
    ]
}
