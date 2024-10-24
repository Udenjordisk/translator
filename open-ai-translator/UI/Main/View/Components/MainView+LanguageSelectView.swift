//
//  MainView+LanguageSelectView.swift
//  open-ai-translator
//
//  Created by Кирилл Белашов  on 24.10.2024.
//

import SwiftUI

extension MainView.ContentView {
    struct LanguagesSelectView: View {
        @EnvironmentObject var viewModel: MainViewModel
        
        var body: some View {
            HStack(alignment: .center, spacing: 8.0) {
                LanguageMenuButton(
                    selectedLanguage: $viewModel.sourceLanguage,
                    languages: viewModel.languages
                )
                
                Button {
                    viewModel.swapLanguages()
                } label: {
                    Image(systemName: "arrow.left.arrow.right")
                        .frame(width: 24.0, height: 24.0)
                        .foregroundStyle(.gray)
                }

                LanguageMenuButton(
                    selectedLanguage: $viewModel.targetLanguage,
                    languages: viewModel.languages
                )
            }
        }
    }
}

extension MainView.ContentView.LanguagesSelectView {
    struct LanguageMenuButton: View {
        @Binding var selectedLanguage: String
        let languages: [String]
        
        var body: some View {
            Menu {
                ScrollView {
                    ForEach(languages, id: \.self) { language in
                        Button {
                            selectedLanguage = language
                        } label:{
                            Label(
                                language,
                                systemImage: selectedLanguage == language ? "checkmark" : ""
                            )
                        }
                    }
                }
            } label: {
                Text(selectedLanguage)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .padding(8.0)
                    .background(Color.buttonBackground)
                    .cornerRadius(8)
            }
        }
    }
}

private extension Color {
    static let buttonBackground = Color(UIColor.systemBlue)
}
