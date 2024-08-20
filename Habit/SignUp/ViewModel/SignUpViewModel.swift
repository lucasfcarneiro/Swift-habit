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
        guard let dateFormatted = dateFormatted else{
            self.uiState = .error("Data inválida \(birthday)")
            return
        }
        
        //Date -> yyyy/MM/dd -> String
        formatter.dateFormat = "yyyy/MM/dd"
        let birthday = formatter.string(from: dateFormatted)
        
        
        WebService.postUser( request: SignUpRequest (
            fullName: fullName,
            email: email,
            password: password,
            document: document,
            phone: phone,
            birthday: birthday,
            gender: gender.index))
   }
}
                             
                             
extension SignUpViewModel {
    func homeView() -> some View {
        return SignUpViewRouter.makeHomeView()
    }
}
