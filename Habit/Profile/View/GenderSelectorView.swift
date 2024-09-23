//
//  GenderSelectorView.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 19/09/24.
//

import SwiftUI

struct GenderSelectorView: View {
    
    @Binding var selectedGender: Gender?
    
    let genders: [Gender]
    let title: String
    
    var body: some View {
        
        Form{
            Section(header: Text(title)) {
                List(genders, id: \.id) { item in
                
                    HStack{
                        Text(item.rawValue)
                        Spacer()
                        Image(systemName: "checkmark")
                            .foregroundColor(selectedGender == item ? .darkOrange : .checkMark)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if !(selectedGender == item){
                            selectedGender = item
                        }
                    }
                }
            }
        }
        .navigationBarTitle(Text(""), displayMode: .inline)
    }
}

#Preview {
    GenderSelectorView(selectedGender: .constant(.female), genders: Gender.allCases, title: "teste")
}
