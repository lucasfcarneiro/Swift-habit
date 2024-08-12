//
//  HomeView.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 10/08/24.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        Text("HOME VIEW ")
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel())
}
