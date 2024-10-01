//
//  ProfileUpdateRequest.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 01/10/24.
//

import Foundation

struct ProfileUpdateRequest: Encodable {
    
    let fullName: String
    let phone: String
    let birthday: String
    let gender: Int
    
    enum CodingKeys: String, CodingKey {
        case fullName = "name"
        case phone
        case birthday
        case gender
    }
}
