//
//  ProfileRemoteDataSource.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 23/09/24.
//

import Foundation
import Combine

class ProfileRemoteDataSource {
    
    //padrao singleton: apenas um unico objeto vivo dentro da aplicacao, uma unica instancia
    static var shared: ProfileRemoteDataSource = ProfileRemoteDataSource()
    
    private init(){
        
    }
    
    func fetchUser() -> Future<ProfileResponse, AppError> {
        return Future { promise in
            
            WebService.call(path: .fetchUser, method: .get) { result in
                switch result {
                case .failure(_, let data):
                    if let data = data {
                            let decoder = JSONDecoder()  //decodifica a resposta do servidor
                            let response = try? decoder.decode(ErrorResponse.self, from: data)
                            
                            promise(.failure(AppError.response(message: response?.detail ?? "Erro desconhecido no servidor")))
                    }
                    break
                case .success(let data):
                    
                    let decoder = JSONDecoder()
                    let response = try? decoder.decode(ProfileResponse.self, from: data)
                    
                    guard let res = response else {
                        print("Log: Error parser \(String(data: data, encoding: .utf8)!)")
                        return
                    }
                    
                    promise(.success(res))
                    break
                }
            }
        }
    }
    
    func updateUser(userId: Int, request profileUpdateRequest : ProfileUpdateRequest) -> Future<ProfileResponse, AppError> {
        return Future { promise in
            
            let path = String(format:WebService.Endpoint.updateUser.rawValue, userId)
            
            WebService.call(path: path, method: .put, body: profileUpdateRequest) { result in
                switch result {
                case .failure(_, let data):
                    if let data = data {
                            let decoder = JSONDecoder()  //decodifica a resposta do servidor
                            let response = try? decoder.decode(ErrorResponse.self, from: data)
                            
                            promise(.failure(AppError.response(message: response?.detail ?? "Erro desconhecido no servidor")))
                    }
                    break
                case .success(let data):
                    
                    let decoder = JSONDecoder()
                    let response = try? decoder.decode(ProfileResponse.self, from: data)
                    
                    guard let res = response else {
                        print("Log: Error parser \(String(data: data, encoding: .utf8)!)")
                        return
                    }
                    
                    promise(.success(res))
                    break
                }

            }
        }
    }
}
