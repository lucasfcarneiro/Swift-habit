//
//  SingInView.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 09/08/24.
//

import SwiftUI

struct SignInView: View {
    
    @ObservedObject var viewModel: SignInViewModel
    
    @State var action : Int? = 0
    @State var navigationHidden = true
    
    var body: some View {
        
        ZStack{
            if case SignInUIState.goToHomeScreen = viewModel.uiState {
                viewModel.homeView()
            }else {
                NavigationView {
                    
                    ScrollView(showsIndicators: false) {
                       
                        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 20) {
                            
                            VStack(alignment: .center, spacing: 8) {
                                Image("logo")
                                    .resizable()
                                    .scaledToFit()
                                    .padding(.horizontal, 48)
                                
                                Text("Login")
                                    .foregroundColor(.yellow)
                                    .font(Font.system(.title).bold())
                                    .padding(.bottom, 8)
                                
                                emailField
                                
                                passwordField
                                
                                enterButton
                                
                                registerLink
                                
                                Text("Copyright @2024")
                                    .foregroundColor(Color.gray)
                                    .font(Font.system(size:12).bold())
                                    .padding(.top,16)
                            }
                        }
                        if case SignInUIState.error(let value) = viewModel.uiState{
                            
                            Text("")
                                .alert(isPresented: .constant(true)) {
                                    Alert(title: Text("Habit"), message: Text(value), dismissButton: .default(Text("OK")){
                                        //faz algo quando some o alerta
                                    })
                                }
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.horizontal, 32)
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle("Login")
                    .navigationBarHidden(navigationHidden)
                }
                .onAppear{
                    self.navigationHidden = true
                }
                .onDisappear{
                    self.navigationHidden = false
                }
            }
        }
    }
}

extension SignInView{
    var emailField : some View{
        EditTextView(text: $viewModel.email,
                     placeholder: "E-mail",
                     error: "Email invalido",
                     keyboard: .emailAddress, 
                     failure: !viewModel.email.isEmail() )
    }
}

extension SignInView{
    var passwordField : some View{
        EditTextView(text: $viewModel.password,
                     placeholder: "Senha",
                     error: "Minimo 8 caracteres",
                     keyboard: .emailAddress, 
                     failure: viewModel.password.count < 8,
                     isSecure: true )
    }
}

extension SignInView{
    var enterButton : some View{
        LoadingButtonView(
            action: {viewModel.login()},
            disable: !viewModel.email.isEmail() || viewModel.password.count < 8,
            showProgress: self.viewModel.uiState == SignInUIState.loading,
            text: "Entrar")
    }
}

extension SignInView {
    var registerLink : some View {
        
        VStack{
            Text("Ainda não possui cadastro?")
                .foregroundColor(.gray)
                .padding(.top, 38)
            
            ZStack{
                NavigationLink(
                    destination: viewModel.signUpView(),
                    tag: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/,
                    selection: $action,
                    label: {EmptyView()})
                
                Button("Registrar"){
                    self.action = 1
                }
            }
        }
    }
}

#Preview {
    SignInView(viewModel: SignInViewModel(interactor: SignInInteractor()))
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
#Preview {
    SignInView(viewModel: SignInViewModel(interactor: SignInInteractor()))
        .preferredColorScheme(.light)
}
