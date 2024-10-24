//
//  MainView+ContentView.swift
//  open-ai-translator
//
//  Created by Кирилл Белашов  on 24.10.2024.
//

import SwiftUI

extension MainView {
    struct ContentView: View {
        @EnvironmentObject var viewModel: MainViewModel
        
        var body: some View {
            VStack(alignment: .leading, spacing: .spacing24) {
                NavigationBarView()
                
                InputView()
                
                if viewModel.isOriginalLanguageEnabled {
                    OriginalLanguageView()
                        .padding(.leading, .spacing8)
                }
                
                if viewModel.isMeaningsEnabled {
                    MeaningsView()
                        .padding(.leading, .spacing8)
                }
                
                LanguagesSelectView()
            }
            .padding(.horizontal, .spacing16)
        }
    }
}

#Preview {
    MainView.ContentView()
        .environmentObject(MainViewModel.arbitrary())
}
