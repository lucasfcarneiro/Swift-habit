//
//  SignUpView.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 12/08/24.
//

import SwiftUI

struct SignUpView: View {
    
    @ObservedObject var viewModel : SignUpViewModel
    
    var body: some View {
        
        ZStack{
            ScrollView(showsIndicators: false){
                VStack(alignment:.leading, spacing: 8 ) {
                    VStack(alignment: .leading, spacing: 8 ){
                        Text("Cadastro")
                            .foregroundColor(Color("textColor"))
                            .font(Font.system(.title).bold())
                            .padding(.bottom, 8)
                        
                        TextFieldExtension(
                            stringBinding: $viewModel.fullName,
                            placeholder: "Nome Completo",
                            error: "Nome curto",
                            keyboard: .namePhonePad,
                            failure: viewModel.fullName.count < 3)
                        
                        TextFieldExtension(
                            stringBinding: $viewModel.email,
                            placeholder: "E-mail",
                            error: "E-mail invalido",
                            keyboard: .emailAddress,
                            failure: !viewModel.email.isEmail())
                        
                        TextFieldExtension(
                            stringBinding: $viewModel.password,
                            placeholder: "Senha",
                            error: "Minimo de 8 caracteres",
                            keyboard: .emailAddress,
                            failure: viewModel.password.count < 8)
                        
                        TextFieldExtension(
                            stringBinding: $viewModel.document,
                            placeholder: "CPF",
                            error: "CPF invalido",
                            keyboard: .numberPad,
                            failure: viewModel.document.count != 11)
                        //TODO MASK
                        //TODO  isDisable
                        
                        TextFieldExtension(
                            stringBinding: $viewModel.phone,
                            placeholder: "Telefone",
                            error: "DDD + 8 ou 9 digitos",
                            keyboard: .numberPad,
                            failure: viewModel.phone.count < 10 ||
                            viewModel.phone.count >= 12)
                        //TODO MASK
                        
                        TextFieldExtension(
                            stringBinding: $viewModel.birthday,
                            placeholder: "Data de nascimento",
                            error: "Data deve ser dd/mm/aaaa",
                            keyboard: .emailAddress,
                            failure: viewModel.birthday.count < 10)
                        //TODO MASK
                        
                        genderField
                        enterButton
                    }
                }.padding(.horizontal, 8)
                
            }.padding()
            
            if case SignUpUIState.error(let value) = viewModel.uiState{
                Text("")
                    .alert(isPresented: .constant(true)) {
                        Alert(title: Text("Habit"), message: Text(value), dismissButton: .default(Text("OK")){
                            //faz algo quando some o alerta
                        })
                    }
            }
        }
    }
}

extension SignUpView{
    func TextFieldExtension (stringBinding: Binding<String>, placeholder: String, error: String, keyboard: UIKeyboardType,  failure: Bool) -> some View{
        
        EditTextView(text: stringBinding, placeholder: placeholder, error: error, keyboard: keyboard , failure: failure)
    }
}

extension SignUpView{
    var genderField : some View{
        
        Picker("Gender", selection : $viewModel.gender){
            ForEach(Gender.allCases, id: \.self) { value in
                Text(value.rawValue)
                    .tag(value)
            }
        }.pickerStyle(SegmentedPickerStyle()) //outro estilo: inline
            .padding()
    }
}

extension SignUpView{
    var enterButton : some View{
        LoadingButtonView(
            action: {viewModel.signUp()},
            disable:
                !viewModel.email.isEmail() ||
                viewModel.password.count < 8 ||
                viewModel.fullName.count < 3 ||
                viewModel.document.count != 11 ||
                viewModel.phone.count < 10 ||
                viewModel.phone.count >= 12 ||
                viewModel.birthday.count < 10,
            showProgress: self.viewModel.uiState == SignUpUIState.loading,
            text: "Cadastrar")
    }
}

#Preview {
    SignUpView(viewModel : SignUpViewModel(interactor: SignUpInteractor()))
}
