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
    private let remote: SplashRemoteDataSource = .shared
}

extension SplashInteractor{
    
    func checkTokenState() -> Future<UserAuth?, Never>{
        return local.getUserAuth()
    }
    
    func insertAuth(userAuth: UserAuth){
        return local.insertUserAuth(userAuth: userAuth)
    }
    
    func refreshToken(refreshRequest request: RefreshRequest) -> Future<SignInResponse, AppError> {
        return remote.refreshToken(request: request)
    }
}
