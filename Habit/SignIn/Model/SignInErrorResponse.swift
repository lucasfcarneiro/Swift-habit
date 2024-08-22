//
//  SignInErrorResponse.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 21/08/24.
//

import Foundation

struct SignInErrorResponse : Decodable {
 
    let detail: SignInDetailErrorResponse
    
    enum CodingKeys: String, CodingKey {
        case detail
    }
}

struct SignInDetailErrorResponse : Decodable {
 
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case message
    }
}

