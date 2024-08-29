//
//  SignUpInteractor.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 29/08/24.
//

import Foundation
import Combine

//Em kotlin é o famoso: SignInRepository
class SignUpInteractor {
    
    private let remoteSignIn: SignInRemoteDataSource = .shared
    private let remoteSignUp: SignUpRemoteDataSource = .shared
    //private let local: LocalDataSource
}

extension SignUpInteractor {
    
    //quem chama a func usa o loginRequest mas interno na func eu uso o request (forma do parametro ter nomes
    //diferentes dependendo de onde ele ta sendo usado)
    func postUser(SignUpRequest request: SignUpRequest) -> Future<Bool, AppError>{
       return remoteSignUp.postUser(request: request)
    }
    
    func login(loginRequest request: SignInRequest) -> Future<SignInSuccessResponse, AppError>{
        return remoteSignIn.login(request: request)
    }
}

