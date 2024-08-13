//
//  SignInViewModel.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 09/08/24.
//

import SwiftUI
import Combine

class SignInViewModel: ObservableObject {
    
    private var cancellable : AnyCancellable?
    
    private let publisher = PassthroughSubject<Bool, Never>()
    
    @Published var uiState : SignInUIState = .none
    
    init(){
        cancellable = publisher.sink { value in
//            print("Usuario criado goToHome : \(value)")
            
            if value {
                self.uiState = .goToHomeScreen
            }
        }
    }
    
    deinit{
        cancellable?.cancel()
    }
    
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
    func signUpView() -> some View{
        return SignInViewRouter.makeSignUpView(publisher: publisher)
    }
}
