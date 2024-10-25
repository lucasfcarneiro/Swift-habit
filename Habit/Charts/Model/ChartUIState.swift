//
//  ChartUIState.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 04/10/24.
//

import Foundation

enum ChartUIState : Equatable {
    case loading
    case emptyChart
    case fullChart
    case error(String)
}
