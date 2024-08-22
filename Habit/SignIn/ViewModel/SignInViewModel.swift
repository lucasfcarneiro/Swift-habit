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
    
    @Published var email = ""
    @Published var password = ""
    
    init(){
        cancellable = publisher.sink { value in
           
            if value {
                self.uiState = .goToHomeScreen
            }
        }
    }
    
    deinit{
        cancellable?.cancel()
    }
    
    func login() {
        
        self.uiState = .loading
        
        WebService.login(request: SignInRequest(email: email, 
                                                password: password)) {(successResponse, ErrorResponse) in
            
            if let error = ErrorResponse {
                DispatchQueue.main.async {
                    self.uiState = .error(error.detail.message)
                }
            }
            
            if let success = successResponse {
                DispatchQueue.main.async {
                    print(success)
                    self.uiState = .goToHomeScreen
                }
            }
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
