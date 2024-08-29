//
//  SignUpRemoteDataSource.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 26/08/24.
//

import Foundation
import Combine

class SignUpRemoteDataSource {
    
    //padrao singleton: apenas um unico objeto vivo dentro da aplicacao, uma unica instancia
    static var shared: SignUpRemoteDataSource = SignUpRemoteDataSource()
    
    private init(){
        
    }
    
    func postUser(request: SignUpRequest) -> Future<Bool, AppError> {
        return Future { promise in
            
            WebService.call(path: .postUser, body: request) { result in
                switch result {
                case .failure(let error, let data):
                    if let data = data {
                        if error == .badRequest {
                            
                            let decoder = JSONDecoder()  //decodifica a resposta do servidor
                            let response = try? decoder.decode(ErrorResponse.self, from: data)
                            
                            promise(.failure(AppError.response(message: response?.detail ?? "Erro desconhecido no servidor")))
                        }
                    }
                    break
                case .success(_):
                    promise(.success(true))
                    break
                }
            }
        }
    }
}
