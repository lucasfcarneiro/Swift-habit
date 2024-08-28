//
//  RemoteDataSource.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 26/08/24.
//

import Foundation

class RemoteDataSource {
    
    //padrao singleton: apenas um unico objeto vivo dentro da aplicacao, uma unica instancia
    
    static var shared: RemoteDataSource = RemoteDataSource()
    
    private init(){
        
    }
    
    func login(request: SignInRequest,
               completion: @escaping (SignInSuccessResponse?, SignInErrorResponse?) -> Void) {
        
        WebService.call(path: .login, params: [
            URLQueryItem(name: "username", value: request.email),
            URLQueryItem(name: "password", value: request.password)
        ]) { result in
            
            switch result {
            case .failure(let error, let data):
                if let data = data {
                    if error == .unauthorized {
                        
                        let decoder = JSONDecoder()  //decodifica a resposta do servidor
                        let response = try? decoder.decode(SignInErrorResponse.self, from: data)
                        completion(nil, response)
                    }
                }
                break
            case .success(let data):
                let decoder = JSONDecoder()
                let response = try? decoder.decode(SignInSuccessResponse.self, from: data)
                completion(response, nil)
                break
            }
        }

    }
    
}
