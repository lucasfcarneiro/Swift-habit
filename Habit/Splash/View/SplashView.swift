//
//  SplashView.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 08/08/24.
//

import SwiftUI

struct SplashView: View {
    
    @ObservedObject var viewModel: SplashViewModel
    
    var body: some View {
        Group {
            switch viewModel.uiState {
            case .loading:
                loadingView()
                
            case .goToSignInScreen:
                viewModel.signInView()
                
            case .goToHomeScreen:
                viewModel.homeView()
                
            case .error(let msg):
                loadingView(error:msg)
            }
        }.onAppear(perform: viewModel.onAppear)
    }
}

// 1. funcoes em extencoes - Visivel somente dentro da classe e func pode passar paramentros
extension SplashView {
    func loadingView(error: String? = nil) -> some View {
        ZStack{
            Image("habits")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity )
                .padding(35)
                .ignoresSafeArea()
            
            if let error = error {
                Text("")
                    .alert(isPresented: .constant(true)) {
                        Alert(title: Text("Habit"), message: Text(error), dismissButton: .default(Text("OK")){
                            //faz algo quando some o o alerta
                        })
                    }
               }
        }
    }
}

// 2. Compartilhamento de objeto - usar varias vezes em outros locais
// struct LoadingView: View {
//    var body: some View{
//        ZStack{
//            Image("logo")
//                .resizable()
//                .scaledToFit()
//                .frame(maxWidth: .infinity, maxHeight: .infinity )
//                .padding(35)
//                .background(Color.white)
//                .ignoresSafeArea()
//        }
//    }
//}

// 3. Variavel de extensao -  Visivel somente dentro da classe
// extension SplashView {
//    var loading: some View{
//        ZStack{
//            Image("logo")
//                .resizable()
//                .scaledToFit()
//                .frame(maxWidth: .infinity, maxHeight: .infinity )
//                .padding(35)
//                .background(Color.white)
//                .ignoresSafeArea()
//        }
//    }
//}

#Preview {
    SplashView(viewModel: SplashViewModel(interactor: SplashInteractor()))
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
#Preview {
    SplashView(viewModel: SplashViewModel(interactor: SplashInteractor()))
        .preferredColorScheme(.light)
}
