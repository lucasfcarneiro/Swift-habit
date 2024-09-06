//
//  ButtonStyle.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 06/09/24.
//

import Foundation
import SwiftUI

struct ButtonStyle: ViewModifier{
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .padding(.horizontal, 16)
            .font(Font.system(.title3).bold())
            .background(Color.lightOrange)
            .foregroundColor(.black)
            .cornerRadius(4.0)
    }
}

