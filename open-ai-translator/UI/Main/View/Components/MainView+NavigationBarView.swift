//
//  MainView+NavigationBarView.swift
//  open-ai-translator
//
//  Created by Кирилл Белашов  on 25.10.2024.
//

import SwiftUI

extension MainView {
    struct NavigationBarView: View {
        @EnvironmentObject var viewModel: MainViewModel
        
        var body: some View {
            ZStack {
                HStack {
                    Spacer()
                    
                    Menu {
                        Toggle(isOn: $viewModel.isTranscriptionEnabled) {
                            Text("Транскрипция")
                        }
                        
                        Toggle(isOn: $viewModel.isMeaningsEnabled) {
                            Text("Значения слов")
                        }
                        
                        Toggle(isOn: $viewModel.isOriginalLanguageEnabled) {
                            Text("Язык оригинала")
                        }
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: .spacing24, height: .spacing24)
                            .foregroundStyle(.gray)
                    }
                }
                
                Text("Переводчик")
                    .font(.subheadline)
                    .fontWeight(.medium)
            }
        }
    }
}
