//
//  SplashViewModel.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 09/08/24.
//

import SwiftUI
import Combine

class SplashViewModel: ObservableObject{
    
    @Published var uiState: SplashUIState = .loading
    
    @Published var token = ""
    private var cancellableAuth : AnyCancellable?
    private let interactor: SplashInteractor
    
    init(interactor: SplashInteractor) {
        self.interactor = interactor
    }
    
    deinit{
        cancellableAuth?.cancel()
    }
    
    func onAppear(){
        
        cancellableAuth = interactor.checkTokenState()
            .delay(for: .seconds(2), scheduler: RunLoop())
            .receive(on: DispatchQueue.main)
            .sink{ userAuth in
                //se userauth == nulo vai pra tela de login
                if userAuth == nil{
                    self.uiState = .goToSignInScreen
                }
                //se userauth != null && expirou
                else if (Date().timeIntervalSince1970 > Double(userAuth!.expires)){ 
                    // chama o refreshToken na Api
                }
                //token Ok vai pra tela principal
                else {
                    self.uiState = .goToHomeScreen
                }
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
