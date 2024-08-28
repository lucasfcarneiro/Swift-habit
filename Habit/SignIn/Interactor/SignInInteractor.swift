//
//  SignInInteractor.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 23/08/24.
//

import Foundation

//Em kotlin é o famoso: SignInRepository
class SignInInteractor {
    
    private let remote: RemoteDataSource = .shared
    //private let local: LocalDataSource
}

extension SignInInteractor {
    
    //quem chama a func usa o loginRequest mas interno na func eu uso o request (forma do parametro ter nomes
    //diferentes dependendo de onde ele ta sendo usado)
    func login(loginRequest request: SignInRequest,
               completion: @escaping (SignInSuccessResponse?, SignInErrorResponse?) -> Void){
        
        remote.login(request: request, completion: completion)
    }
}
