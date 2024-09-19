//
//  HabitRemoteDataSource.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 17/09/24.
//

import Foundation
import Combine

class HabitDetailRemoteDataSource {
    
    //padrao singleton: apenas um unico objeto vivo dentro da aplicacao, uma unica instancia
    static var shared: HabitDetailRemoteDataSource = HabitDetailRemoteDataSource()
    
    private init(){
        
    }
    
    func save(habitId: Int, request: HabitValueRequest) -> Future<Bool, AppError>{
        return Future<Bool, AppError> { promise in
            
            //coloca o habitid no lugar do %d em habitvalues
            let path = String(format:WebService.Endpoint.habitsValues.rawValue, habitId)
            
            WebService.call(path: path, method: .post, body: request) { result in
                
                switch result {
                case .failure(_, let data):
                    if let data = data {
                        
                        let decoder = JSONDecoder()  //decodifica a resposta do servidor
                        let response = try? decoder.decode(SignInErrorResponse.self, from: data)
                        //completion(nil, response)
                        
                        promise(.failure(AppError.response(message: response?.detail.message ?? "Erro desconhecido no servidor")))
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
