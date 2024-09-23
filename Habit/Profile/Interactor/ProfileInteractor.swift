//
//  ProfileInteractor.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 23/09/24.
//

import Foundation
import Combine

class ProfileInteractor {
    
    private let remote: ProfileRemoteDataSource = .shared
    
}

extension ProfileInteractor {
    
    func fetchUser() -> Future<ProfileResponse, AppError>{
        return remote.fetchUser()
    }
}
