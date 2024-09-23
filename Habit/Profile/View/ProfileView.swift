//
//  ProfileView.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 19/09/24.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var viewModel: ProfileViewModel
    
    @State var fullName = "Lucas Fagundes Carneiro"
    @State var email = "lukasfcarneiro@gmail.com"
    @State var cpf = "111.222.222.111"
    @State var fone = "31 9 9999-9999"
    @State var birthday = "02/10/1995"
    @State var selectedGender: Gender? = .male
    
    
    var body: some View {
        
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
                            TextField("", text: $email)
                                .disabled(true)
                                .foregroundColor(Color.gray)
                                .multilineTextAlignment(.trailing)
                        }
                        
                        HStack{
                            Text("CPF")
                            Spacer()
                            TextField("", text: $cpf)
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
                            destination: GenderSelectorView(selectedGender:                                       $selectedGender,
                                                            genders: Gender.allCases,
                                                            title: "Escolha o gênero"),
                            label: {
                                HStack {
                                    Text("Gênero")
                                    Spacer()
                                    Text(selectedGender?.rawValue ?? "")
                                }
                            })
                    }
                }
            }
            
            .navigationBarTitle(Text("Editar perfil"), displayMode:
                    .automatic)
        }
    }
}

#Preview {
    ProfileView(viewModel: ProfileViewModel())
}
