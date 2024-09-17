//
//  CustomTextFieldStyle.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 14/08/24.
//

import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.horizontal, 8)
            .padding(.vertical, 16)
            .overlay(
                RoundedRectangle(cornerRadius: 8.0)
                    .stroke(Color("borderColor"), lineWidth: 2)
            )
    }
}

