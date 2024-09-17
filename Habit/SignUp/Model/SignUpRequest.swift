//
//  SignUpRequest.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 16/08/24.
//

import Foundation

struct SignUpRequest: Encodable {
    
    let fullName: String
    let email: String
    let password: String
    let document: String
    let phone: String
    let birthday: String
    let gender: Int
    
    enum CodingKeys: String, CodingKey {
        case fullName = "name"       //"name" é a forma que o servidor espera
        case email                   //no caso dos demais, o servidor ja espera como email, password...
        case password
        case document
        case phone
        case birthday
        case gender
    }
}
