//
//  HabitInteractor.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 12/09/24.
//

import Foundation
import Combine

class HabitInteractor {
    
    private let remote: HabitRemoteDataSource = .shared
    
}

extension HabitInteractor {
    
    func fetchHabits() -> Future<[HabitResponse], AppError>{
        return remote.fetchHabits()
    }
}
