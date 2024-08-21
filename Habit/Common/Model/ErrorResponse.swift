//
//  ErrorResponse.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 20/08/24.
//

import Foundation

struct ErrorResponse : Decodable {
 
    let detail: String
    
    enum CodingKeys: String, CodingKey {
        case detail
    }
}
