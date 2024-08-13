//
//  SignUpViewRouter.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 12/08/24.
//

import SwiftUI

enum SignUpViewRouter {
    
    static func makeHomeView() -> some View {
        
        let viewModel = HomeViewModel()
        
        return HomeView(viewModel: viewModel)
    }
    
    
}
