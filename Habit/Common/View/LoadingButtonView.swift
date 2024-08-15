//
//  LoadingButtonView.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 14/08/24.
//

import SwiftUI

struct LoadingButtonView: View {
    
    var action: () -> Void
    var disable: Bool = false
    var showProgress: Bool = false
    var text : String
    
    var body: some View {
        ZStack {
            Button(action: {
                action()
            }, label: {
                Text(showProgress ? "" : text)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .padding(.horizontal, 16)
                    .font(Font.system(.title3).bold())
                    .background(disable ? Color("lightYellow") : (Color("darkYellow")))
                    .foregroundColor(.black)
                    .cornerRadius(4.0)
            }).disabled(disable || showProgress)
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .opacity(showProgress ? 1 : 0)
        }
    }
}

#Preview {
    LoadingButtonView(action: {
        print("Button pressed")
    }, disable: false, showProgress: true, text: "Entrar")
    .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
#Preview {
    LoadingButtonView(action: {
        print("Button pressed")
    }, disable: false, showProgress: true, text: "Entrar")
    .preferredColorScheme(.light)
}
