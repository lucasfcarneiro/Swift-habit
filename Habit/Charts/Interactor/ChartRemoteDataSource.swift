//
//  ChartRemoteDataSource.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 30/09/24.
//

import Foundation
import Combine

class ChartRemoteDataSource {
    
//padrao singleton: apenas um unico objeto vivo dentro da aplicacao, uma unica instancia
static var shared: ChartRemoteDataSource = ChartRemoteDataSource()

private init(){
    
}

    func fetchHabitValues(habitId: Int) -> Future<[HabitValueResponse], AppError> {
    return Future { promise in
        
        //coloca o habitid no lugar do %d em habitvalues
        let path = String(format:WebService.Endpoint.habitsValues.rawValue, habitId)
        
        WebService.call(path: path, method: .get) { result in
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
                let response = try? decoder.decode([HabitValueResponse].self, from: data)
                
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
