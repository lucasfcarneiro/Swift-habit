//
//  SignInInteractor.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 23/08/24.
//

import Foundation
import Combine

//Em kotlin é o famoso: SignInRepository
class SignInInteractor {
    
    private let remote: SignInRemoteDataSource = .shared
    private let local: LocalDataSource = .shared
}

extension SignInInteractor {
    
    //quem chama a func usa o loginRequest mas interno na func eu uso o request (forma do parametro ter nomes
    //diferentes dependendo de onde ele ta sendo usado)
    func login(loginRequest request: SignInRequest) -> Future<SignInResponse, AppError>{
        return remote.login(request: request)
    }
    
    func insertAuth(userAuth: UserAuth){
        return local.insertUserAuth(userAuth: userAuth)
    }
}
