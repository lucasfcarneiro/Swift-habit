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
        WebService.postUser( request: SignUpRequest (
            fullName: fullName,
            email: email,
            password: password,
            document: document,
            phone: phone,
            birthday: birthday,
            gender: gender.index)) { (successResponse, errorResponse) in
                
                //Non Main Thread
                if let error = errorResponse {
                    DispatchQueue.main.async {
                        self.uiState = .error(error.detail)
                    }
                }
                
//                if let success = successResponse {
//                    WebService.login(request: SignInRequest(email: self.email,
//                                                            password: self.password)) {(successResponse, ErrorResponse) in
//                        
//                        if let error = ErrorResponse {
//                            DispatchQueue.main.async {
//                                self.uiState = .error(error.detail.message)
//                            }
//                        }
//                        
//                        if let successSignIn = successResponse {
//                            DispatchQueue.main.async {
//                                print(successSignIn)
//                                self.publisher.send(success)
//                                self.uiState = .success
//                        }
//                    }
//                }
//            }
        }
    }
}


extension SignUpViewModel {
    func homeView() -> some View {
        return SignUpViewRouter.makeHomeView()
    }
}
