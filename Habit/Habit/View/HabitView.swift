//
//  HabitView.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 05/09/24.
//

import Foundation
import SwiftUI

struct HabitView: View {
  
  @ObservedObject var viewModel: HabitViewModel
  
  var body: some View {
    ZStack {
      if case HabitUIState.loading = viewModel.uiState {
        progress
      } else{
        
        NavigationView {
        
          ScrollView(showsIndicators: false) {
            VStack(spacing: 12) {
              
              topContainer
              
              addButton
         
              if case HabitUIState.emptyList = viewModel.uiState {
                
                Spacer(minLength: 60)
                
                VStack {
                  Image(systemName: "exclamationmark.octagon.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24, alignment: .center)
                  
                  Text("Nenhum hábito encontrado :(")
                }
                
              } else if case HabitUIState.fullList(let rows) = viewModel.uiState {
                
                LazyVStack {
                  
                  ForEach(rows, content: HabitCardView.init(viewModel:))
                  
                }.padding(.horizontal, 14)
                
              } else if case HabitUIState.error(let msg) = viewModel.uiState {
                
                Text("")
                  .alert(isPresented: .constant(true)) {
                    Alert(
                      title: Text("Ops! \(msg)"),
                      message: Text("Tentar novamente?"),
                      primaryButton: .default(Text("Sim")) {
                        // aqui executa a retentativa
                        viewModel.onAppear()
                      },
                      secondaryButton: .cancel()
                    )
                  }
              }
              
            }
          }.navigationTitle("Meus Hábitos")
          
        }
      }

    }.onAppear {
        if !viewModel.opened {
            viewModel.onAppear()
        }
    }
  }
}

extension HabitView {
  var progress: some View {
    ProgressView()
  }
}

extension HabitView {
  var topContainer: some View {
    VStack(alignment: .center, spacing: 12) {
      Image(systemName: "exclamationmark.triangle")
        .resizable()
        .scaledToFit()
        .frame(width: 50, height: 50, alignment: .center)
      
      Text(viewModel.title)
        .font(Font.system(.title).bold())
        .foregroundColor(Color.orange)
      
      Text(viewModel.headline)
        .font(Font.system(.title3).bold())
        .foregroundColor(Color("textColor"))
      
      Text(viewModel.description)
        .font(Font.system(.subheadline))
        .foregroundColor(Color("textColor"))
    }
    .frame(maxWidth: .infinity)
    .padding(.vertical, 32)
    .overlay(
      RoundedRectangle(cornerRadius: 6)
        .stroke(Color.gray, lineWidth: 1)
    )
    .padding(.horizontal, 16)
    .padding(.top, 16)
  }
}

extension HabitView {
  var addButton: some View {
    NavigationLink(destination: Text("Tela de adicionar")
        .frame(maxWidth: .infinity, maxHeight: .infinity)) {
      Label("Criar Hábito", systemImage: "plus.app")
        .modifier(ButtonStyle())
    }
    .padding(.horizontal, 16)
  }
}

#Preview {
    HabitView(viewModel: HabitViewModel(interactor: HabitInteractor()))
}
