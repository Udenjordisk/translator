//
//  MainView+TranslationErrorView.swift
//  open-ai-translator
//
//  Created by Кирилл Белашов  on 25.10.2024.
//

import SwiftUI

extension MainView.ContentView.InputView {
    struct TranslationErrorView: View {
        @EnvironmentObject var viewModel: MainViewModel
        
        var body: some View {
            VStack(alignment: .center, spacing: .spacing8) {
                Text("Что-то пошло не так. Попробуйте позже через некоторое время.")
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
                
                Button {
                    Task { await viewModel.reloadTranslation() }
                } label: {
                    Text("Попробовать еще раз")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Color.blue)
                        .padding(.horizontal, .spacing16)
                }
            }
        }
    }
}
