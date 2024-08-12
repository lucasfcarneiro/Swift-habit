//
//  HabitApp.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 08/08/24.
//

import SwiftUI

@main
struct HabitApp: App {
    var body: some Scene {
        WindowGroup {
            SplashView(viewModel: SplashViewModel())
        }
    }
}
