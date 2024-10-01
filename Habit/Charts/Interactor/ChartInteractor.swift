//
//  ChartInteractor.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 01/10/24.
//

import Foundation
import Combine

class ChartInteractor {
    
    private let remote: ChartRemoteDataSource = .shared
    
}

extension ChartInteractor {
    
    func fetchHabitValue(habitId: Int) -> Future<[HabitValueResponse], AppError>{
        return remote.fetchHabitValues(habitId: habitId)
    }
}
