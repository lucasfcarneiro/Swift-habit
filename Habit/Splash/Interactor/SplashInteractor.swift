//
//  SplashInteractor.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 29/08/24.
//

import Foundation
import Combine

class SplashInteractor {
    
    private let local: LocalDataSource = .shared
}

extension SplashInteractor{
    
    func checkTokenState() -> Future<UserAuth?, Never>{
        return local.getUserAuth()
    }
}
