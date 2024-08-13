//
//  SignUpView.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 12/08/24.
//

import SwiftUI

struct SignUpView: View {
    
    @ObservedObject var viewModel : SignUpViewModel
    
    @State var fullName = ""
    @State var email = ""
    @State var password = ""
    @State var document = ""
    @State var phone = ""
    @State var birthday = ""
    @State var gender = Gender.male
    
    var body: some View {
        
        ZStack{
            ScrollView(showsIndicators: false){
                VStack(alignment:.leading, spacing: 8 ) {
                    VStack(alignment: .leading, spacing: 8 ){
                        Text("Cadastro")
                            .foregroundColor(.black)
                            .font(Font.system(.title).bold())
                            .padding(.bottom, 8)
                        
                        TextFieldExtension(stringBinding: $fullName)
                        TextFieldExtension(stringBinding: $email)
                        TextFieldExtension(stringBinding: $password)
                        TextFieldExtension(stringBinding: $document)
                        TextFieldExtension(stringBinding: $phone)
                        TextFieldExtension(stringBinding: $birthday)
                        genderField
                        saveButton
                    }
                    Spacer()
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
    func TextFieldExtension (stringBinding: Binding<String>) -> some View{
        TextField("", text: stringBinding)
            .border(Color.black)
    }
}

extension SignUpView{
    var genderField : some View{
        
        Picker("Gender", selection : $gender){
            ForEach(Gender.allCases, id: \.self) { value in
                Text(value.rawValue)
                    .tag(value)
            }
        }.pickerStyle(SegmentedPickerStyle()) //Mais de 3 usar o inline
            .padding()
    }
}


extension SignUpView{
    var saveButton : some View{
        Button("Cadastrar"){
            viewModel.signUp()
        }
    }
}

#Preview {
    SignUpView(viewModel : SignUpViewModel())
}
