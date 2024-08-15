//
//  SignUpViewModel.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 12/08/24.
//

import SwiftUI
import Combine

class SignUpViewModel: ObservableObject {
    
    var publisher: PassthroughSubject<Bool, Never>! //O ! é para dizer: não opcional
    
    @Published var uiState : SignUpUIState = .none
    
    @Published  var fullName = ""
    @Published  var email = ""
    @Published  var password = ""
    @Published  var document = ""
    @Published  var phone = ""
    @Published  var birthday = ""
    @Published  var gender = Gender.male
    
    func signUp(){
        self.uiState = .loading
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1 ){
            //simula resposta servidor chamando depois de 1 seg
            self.uiState = .success
            self.publisher.send(true)
            //self.uiState = .error("Usuario ja existente")
        }
    }
}

extension SignUpViewModel {
    func homeView() -> some View {
        return SignUpViewRouter.makeHomeView()
    }
}
