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
    
    private var cancellableAuth : AnyCancellable?
    private var cancellableRefresh : AnyCancellable?
    
    private let interactor: SplashInteractor
    
    init(interactor: SplashInteractor) {
        self.interactor = interactor
    }
    
    deinit{
        cancellableAuth?.cancel()
        cancellableRefresh?.cancel()
    }
    
    func onAppear(){
        
        cancellableAuth = interactor.checkTokenState()
            .delay(for: .seconds(2), scheduler: RunLoop.main)
            .receive(on: DispatchQueue.main)
            .sink{ userAuth in
                //se userauth == nulo vai pra tela de login
                if userAuth == nil{
                    print("token nulo")
                    self.uiState = .goToSignInScreen
                }
                //se userauth != null && expirou
                else if (Date().timeIntervalSince1970 > Double(userAuth!.expires)){
                    // chama o refreshToken na Api
                    print("token expirou")
                    let request = RefreshRequest(token: userAuth!.refreshToken)
                    self.cancellableRefresh = self.interactor.refreshToken(refreshRequest:request)
                        .receive(on: DispatchQueue.main)
                        .sink(receiveCompletion: { completion in
                            switch(completion) {
                            case .failure(_):
                                self.uiState = .goToSignInScreen
                                break
                            default:
                                break
                            }
                        }, receiveValue: { success in
                            let auth = UserAuth(idToken: success.accessToken,
                                                refreshToken: success.refreshToken,
                                                //data atual + data do token
                                                expires: Date().timeIntervalSince1970 + Double(success.expires),
                                                tokenType: success.tokenType)
                            self.interactor.insertAuth(userAuth: auth)
                            self.uiState = .goToHomeScreen
                        })
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
