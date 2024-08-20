//
//  SignUpResponse.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 20/08/24.
//

import Foundation

struct SignUpResponse : Decodable {
 
    let detail: String?
    
    enum CodingKeys: String, CodingKey {
        case detail
    }
}
