//
//  SingInView.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 09/08/24.
//

import SwiftUI

struct SignInView: View {
    
    @ObservedObject var viewModel: SignInViewModel
    
    var body: some View {
        Text("SIGN IN PAGE")
    }
}

#Preview {
    SignInView(viewModel: SignInViewModel())
}
