//
//  HabitDetailInteractor.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 18/09/24.
//

import Foundation
import Combine

//Em kotlin é o famoso: SignInRepository
class HabitDetailInteractor {
    
    private let remote: HabitDetailRemoteDataSource = .shared
}

extension HabitDetailInteractor {
    
    //quem chama a func usa o habitValueRequest mas interno na func eu uso o request (forma do parametro ter nomes
    //diferentes dependendo de onde ele ta sendo usado)
    func save(habitId: Int, habitValueRequest request: HabitValueRequest) -> Future<Bool, AppError>{
        return remote.save(habitId: habitId, request: request)
    }
}
