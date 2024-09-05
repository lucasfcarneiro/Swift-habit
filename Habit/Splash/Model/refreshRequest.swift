//
//  refreshRequest.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 30/08/24.
//

import Foundation

struct RefreshRequest: Encodable{
    let token: String
    
    enum CodingKeys: String, CodingKey{
        case token = "refresh_token"
    }
}
