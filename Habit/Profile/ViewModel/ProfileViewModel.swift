//
//  ProfileViewModel.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 19/09/24.
//

import Foundation
import Combine

class ProfileViewModel: ObservableObject {
    
    @Published var uiState: ProfileUIState = .none
    
    @Published var fullNameValidation = FullNameValidation()
    @Published var phoneValidation = PhoneValidation()
    @Published var birthdayValidation = BirthdayValidation()
    
    var userid: Int?
    @Published var email: String = ""
    @Published var document: String = ""
    @Published var gender: Gender?
    
    
    private var cancellable: AnyCancellable?
    private let interactor: ProfileInteractor
    
    init (interactor: ProfileInteractor) {
        self.interactor = interactor
    }
    
    deinit{
        cancellable?.cancel()
    }
    
    func fetchUser(){
        self.uiState = .loading
        
        cancellable = interactor.fetchUser()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let appError):
                    self.uiState = .fetchError(appError.message)
                    break
                case .finished:
                    break
                }
            }, receiveValue: {response in
                self.userid = response.id
                self.email = response.email
                self.document = response.document
                self.gender = Gender.allCases[response.gender]
                self.fullNameValidation.value = response.fullName
                self.phoneValidation.value = response.phone
                
                //Pegar a String -> dd/MM/yyyy -> Date
                let formatter = DateFormatter()
                formatter.locale = Locale(identifier: "en_US_POSIX")
                formatter.dateFormat = "yyyy-MM-dd"
                
                let dateFormatted = formatter.date(from: response.birthday)
                
                //Validar a Data
                guard let dateFormatted = dateFormatted else {
                    self.uiState = .fetchError("Data inválida \(response.birthday)")
                    return
                }
                
                //Date -> yyyy/MM/dd -> String
                formatter.dateFormat = "dd/MM/yyyy"
                let formattedBirthday = formatter.string(from: dateFormatted)
                
                self.birthdayValidation.value = formattedBirthday
                
                self.uiState = .fetchSuccess
                
            })
    }
}


class FullNameValidation: ObservableObject {
    
    @Published var failure: Bool = false
    
    var value: String = "" {
        didSet {
            failure = value.count < 3
        }
    }
}

class PhoneValidation: ObservableObject {
    
    @Published var failure: Bool = false
    
    var value: String = "" {
        didSet {
            failure = value.count < 10 || value.count >= 12
        }
    }
}

class BirthdayValidation: ObservableObject {
    
    @Published var failure: Bool = false
    
    var value: String = "" {
        didSet {
            failure = value.count != 10
        }
    }
}


