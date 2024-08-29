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
    
    private var interactor: SignUpInteractor
    private var cancellableSignIn : AnyCancellable?
    private var cancellableSignUp : AnyCancellable?
    
    @Published  var uiState : SignUpUIState = .none
    @Published  var fullName = ""
    @Published  var email = ""
    @Published  var password = ""
    @Published  var document = ""
    @Published  var phone = ""
    @Published  var birthday = ""
    @Published  var gender = Gender.male
    
    init (interactor: SignUpInteractor){
        self.interactor = interactor
    }
    
    deinit{
        cancellableSignIn?.cancel()
        cancellableSignUp?.cancel()
    }
    
    func signUp(){
        
        self.uiState = .loading
        
        //Pegar a String -> dd/MM/yyyy -> Date
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "dd/MM/yyyy"
        
        let dateFormatted = formatter.date(from: birthday)
        
        //Validar a Data
        guard let dateFormatted = dateFormatted else {
            self.uiState = .error("Data inválida \(birthday)")
            return
        }
        
        //Date -> yyyy/MM/dd -> String
        formatter.dateFormat = "yyyy-MM-dd"
        let birthday = formatter.string(from: dateFormatted)
        
        //Main Thread
        cancellableSignUp = interactor.postUser(SignUpRequest: SignUpRequest(fullName: fullName,
                                                                              email: email,
                                                                              password: password,
                                                                              document: document,
                                                                              phone: phone,
                                                                              birthday: birthday,
                                                                              gender: gender.index))
        .receive(on: DispatchQueue.main)
        .sink{ completion in
            switch(completion){
            case .failure(let appError):
                self.uiState = SignUpUIState.error(appError.message)
                break
            case .finished:
                break
            }
        }receiveValue: { created in
            if (created){
                self.cancellableSignIn = self.interactor.login(loginRequest: SignInRequest(email: self.email, password: self.password))
                    .receive(on: DispatchQueue.main)
                    .sink{ completion in
                        //aqui acontece o Erro ou Finished
                        switch(completion) {
                        case .failure(let appError):
                            self.uiState = .error(appError.message)
                            break
                        case .finished:
                            break
                        }
                    } receiveValue: { successSignIn in
                        print(successSignIn)
                        print(created)
                        self.publisher.send(created)
                        self.uiState = .success
                    }
            }
        }
    }
}

extension SignUpViewModel {
    func homeView() -> some View {
        return SignUpViewRouter.makeHomeView()
    }
}
