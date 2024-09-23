//
//  profileResponse.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 23/09/24.
//

import Foundation

struct ProfileResponse: Decodable {
    
    let id : Int
    let fullName: String
    let email: String
    let document: String
    let phone: String
    let birthday: String
    let gender: Int
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case fullName = "name"       //"name" é a forma que o servidor espera
        case email                   //no caso dos demais, o servidor ja espera como email, password...
        case document
        case phone
        case birthday
        case gender
    }
}
