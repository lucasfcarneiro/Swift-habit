//
//  SignInViewModel.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 09/08/24.
//

import SwiftUI

class SignInViewModel: ObservableObject {
    
    @Published var uiState : SignInUIState = .none
    
    func login(email: String, password: String) {
        
        self.uiState = .loading
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1 ){
            //simula resposta servidor chamando depois de 1 seg
            self.uiState = .goToHomeScreen
            //self.uiState = .error("Usuario ou senha incorreta")
            
        }
    }
}

extension SignInViewModel{
    func homeView() -> some View{
        return SignInViewRouter.makeHomeView()
    }

}
