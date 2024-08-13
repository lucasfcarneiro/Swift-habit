//
//  SingInView.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 09/08/24.
//

import SwiftUI

struct SignInView: View {
    
    @ObservedObject var viewModel: SignInViewModel
    
    @State var email = ""
    @State var password = ""
    @State var action : Int? = 0
    @State var navigationHidden = true
    
    var body: some View {
        
        ZStack{
            if case SignInUIState.goToHomeScreen = viewModel.uiState {
                viewModel.homeView()
            }else {
                NavigationView {
                    
                    ScrollView{
                        
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
                    .background(Color.white)
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle("Login")
                    .navigationBarHidden(navigationHidden)
                }
            }
        }
        
    }
}

extension SignInView{
    var emailField : some View{
        TextField("", text: $email)
            .border(Color.black)
    }
}

extension SignInView{
    var passwordField : some View{
        SecureField("", text: $password)
            .border(Color.black)
    }
}

extension SignInView{
    var enterButton : some View{
        Button("Entrar"){
            viewModel.login(email : email, password : password)
        }
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
    SignInView(viewModel: SignInViewModel())
}
