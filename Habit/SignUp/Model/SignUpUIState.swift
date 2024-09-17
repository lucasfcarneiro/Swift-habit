//
//  File.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 12/08/24.
//

import Foundation

enum SignUpUIState: Equatable{
    case none
    case loading
    case success
    case error(String)
}
