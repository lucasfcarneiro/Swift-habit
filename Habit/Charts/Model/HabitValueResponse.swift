//
//  HabitValueResponse.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 30/09/24.
//

import Foundation

struct HabitValueResponse : Decodable {
    
    let id: Int
    let value: Int
    let createdDate: String
    let habitId: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case value
        case createdDate = "created_date"
        case habitId = "habit_id"
    }
}
