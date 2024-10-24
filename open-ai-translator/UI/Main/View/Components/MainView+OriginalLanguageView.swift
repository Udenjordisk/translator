//
//  MainView+OriginalLanguageView.swift
//  open-ai-translator
//
//  Created by Кирилл Белашов  on 25.10.2024.
//

import SwiftUI

extension MainView.ContentView {
    struct OriginalLanguageView: View {
        @EnvironmentObject var viewModel: MainViewModel

        var body: some View {
            if let originalLanguage = viewModel.originalLanguage, originalLanguage != viewModel.sourceLanguage {
                Button {
                    viewModel.updateSourceLanguage(originalLanguage)
                } label: {
                    Text("Язык оригинала: ")
                        .foregroundStyle(.gray)
                    +
                    Text(originalLanguage)
                        .foregroundStyle(.blue)
                }
            }
        }
    }
}
