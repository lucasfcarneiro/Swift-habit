//
//  SignInModel.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 09/08/24.
//

import Foundation

enum SignInUIState : Equatable{
    case none
    case loading
    case goToHomeScreen
    case error(String)
}

