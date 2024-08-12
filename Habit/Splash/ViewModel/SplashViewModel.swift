//
//  SplashViewModel.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 09/08/24.
//

import SwiftUI

class SplashViewModel: ObservableObject{
    
    @Published var uiState: SplashUIState = .loading
    
    func onAppear(){
        // faz algo assincrono e muda o estado da uistate
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2 ){
            //simula resposta servidor chamando depois de 2 seg
            //self.uiState = .goToHomeScreen
            self.uiState = .goToSignInScreen
            //self.uiState = .error("Erro na resposta do servidor")
        }
    }
}

extension SplashViewModel {
    func signInView() -> some View {
        return SplashViewRouter.makeSignInView()
    }
    func homeView() -> some View{
        return SplashViewRouter.makeHomeView()
    }
 }
