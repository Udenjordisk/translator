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
            VStack(alignment: .leading, spacing: 24) {
                NavigationBarView()
                
                InputView()
                
                if viewModel.isOriginalLanguageEnabled {
                    OriginalLanguageView()
                        .padding(.leading, 8)
                }
                
                if viewModel.isMeaningsEnabled {
                    MeaningsView()
                        .padding(.leading, 8)
                }
                
                LanguagesSelectView()
            }
            .padding(.horizontal, 16.0)
        }
    }
}

#Preview {
    MainView.ContentView()
        .environmentObject(MainViewModel.arbitrary())
}
