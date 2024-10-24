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
            VStack(alignment: .center, spacing: .spacing24) {
                NavigationBarView()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: .spacing24) {
                        InputView()
                        
                        if viewModel.isOriginalLanguageEnabled {
                            OriginalLanguageView()
                                .padding(.leading, .spacing8)
                        }
                        
                        LanguagesSelectView()
                        
                        if viewModel.isMeaningsEnabled {
                            MeaningsView()
                                .padding(.leading, .spacing8)
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
            .padding(.horizontal, .spacing16)
        }
    }
}

#Preview {
    MainView.ContentView()
        .environmentObject(MainViewModel.arbitrary())
}
