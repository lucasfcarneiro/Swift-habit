//
//  ProfileView.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 19/09/24.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var viewModel: ProfileViewModel
    
    var disableDone: Bool {
        viewModel.fullNameValidation.failure ||
        viewModel.birthdayValidation.failure ||
        viewModel.phoneValidation.failure
    }
    
    var body: some View {
        
        ZStack{
            
            if case ProfileUIState.loading = viewModel.uiState {
                ProgressView()
            }else{
                NavigationView(){
                    
                    VStack{
                        
                        Form{
                            
                            Section(header: Text("Dados cadastrais")){
                                HStack{
                                    Text("Nome")
                                    Spacer()
                                    TextField("Digite o nome", text: $viewModel.fullNameValidation.value)
                                        .keyboardType(.alphabet)
                                        .multilineTextAlignment(.trailing)
                                }
                                
                                if viewModel.fullNameValidation.failure {
                                    Text("Nome deve ter no minimo 3 caracteres")
                                        .foregroundColor(.red)
                                }
                                
                                HStack{
                                    Text("E-mail")
                                    Spacer()
                                    TextField("", text: $viewModel.email)
                                        .disabled(true)
                                        .foregroundColor(Color.gray)
                                        .multilineTextAlignment(.trailing)
                                }
                                
                                HStack{
                                    Text("CPF")
                                    Spacer()
                                    TextField("", text: $viewModel.document)
                                        .disabled(true)
                                        .foregroundColor(Color.gray)
                                        .multilineTextAlignment(.trailing)
                                }
                                
                                HStack{
                                    Text("Celular")
                                    Spacer()
                                    TextField("Digite o celular", text: $viewModel.phoneValidation.value)
                                        .keyboardType(.numberPad)
                                        .multilineTextAlignment(.trailing)
                                }
                                
                                if viewModel.phoneValidation.failure {
                                    Text("DDD + 8 ou 9 digitos")
                                        .foregroundColor(.red)
                                }
                                
                                HStack{
                                    Text("Data de nascimento")
                                    Spacer()
                                    TextField("Digite sua data de nascimento", text: $viewModel.birthdayValidation.value)
                                        .multilineTextAlignment(.trailing)
                                }
                                
                                if viewModel.birthdayValidation.failure {
                                    Text("Data deve ser dd/mm/aaaa")
                                        .foregroundColor(.red)
                                }
                                
                                NavigationLink(
                                    destination: GenderSelectorView(selectedGender: $viewModel.gender,
                                                                    genders: Gender.allCases,
                                                                    title: "Escolha o gênero"),
                                    label: {
                                        HStack {
                                            Text("Gênero")
                                            Spacer()
                                            Text(viewModel.gender?.rawValue ?? "")
                                        }
                                    })
                            }
                        }
                    }
                    
                    .navigationBarTitle(Text("Editar perfil"), displayMode: .automatic)
                    .navigationBarItems(trailing: Button(action: {}, label : {
                        Image(systemName: "checkmark")
                            .foregroundColor(Color.darkOrange)
                    })
                        .opacity(disableDone ? 0 : 1)
                    )
                    
                }
            }
            
            if case ProfileUIState.fetchError(let value ) = viewModel.uiState {
                Text("")
                    .alert(isPresented: .constant(true)) {
                        Alert(title: Text("Habit"),
                              message: Text(value),
                              dismissButton: .default(Text("OK")){
                            //faz algo quando some o alerta
                        })
                    }
            }
            
        }.onAppear(perform: viewModel.fetchUser)
    }
}

#Preview {
    ProfileView(viewModel: ProfileViewModel(interactor: ProfileInteractor()))
}
