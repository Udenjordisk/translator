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
            VStack(alignment: .center, spacing: 24) {
                InputView()
                
                LanguagesSelectionView()
            }
            .padding(.horizontal, 16.0)
        }
    }
}

extension MainView.ContentView {
    struct InputView: View {
        @EnvironmentObject var viewModel: MainViewModel
        
        var body: some View {
            ZStack(alignment: .topLeading) {
                Color.textEditorBackground
                
                VStack(alignment: .center, spacing: .zero) {
                    InputBlock(
                        text: $viewModel.inputText,
                        originalLanguage: viewModel.originalLanguage,
                        buttonIconName: "xmark",
                        buttonAction: {
                            viewModel.clear()
                        }
                    )
                    
                    if !viewModel.translatedText.isEmpty {
                        Divider()
                            .padding(12)
                        
                        InputBlock(
                            text: $viewModel.translatedText,
                            buttonIconName: "document.on.document",
                            buttonAction: {
                                viewModel.copy()
                            }
                        )
                    }
                }
            }
            .fixedSize(horizontal: false, vertical: true)
            .cornerRadius(12)
        }
    }
}

extension MainView.ContentView.InputView {
    struct InputBlock: View {
        @Binding var text: String
        @State var originalLanguage: String?
        
        let buttonIconName: String
        let buttonAction: () -> Void
        
        var body: some View {
            VStack {
                HStack {
                    if let originalLanguage {
                        Text(originalLanguage)
                            .fontWeight(.bold)
                            .foregroundStyle(Color(UIColor.systemBlue))
                    } else {
                        Spacer()
                    }
                    
                    Button {
                        buttonAction()
                    } label: {
                        Image(systemName: buttonIconName)
                            .frame(width: 24.0, height: 24.0)
                            .foregroundStyle(.gray)
                    }
                }
                
                TextEditor(text: $text)
                    .scrollContentBackground(.hidden)
                    .foregroundStyle(.black)
                    .frame(minHeight: 100, maxHeight: 400)
            }
            .padding(12)
        }
    }
}

extension MainView.ContentView {
    struct LanguagesSelectionView: View {
        @EnvironmentObject var viewModel: MainViewModel
        
        var body: some View {
            HStack(alignment: .center, spacing: 8.0) {
                LanguagesSelectionButtonView(
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

                LanguagesSelectionButtonView(
                    selectedLanguage: $viewModel.targetLanguage,
                    languages: viewModel.languages
                )
            }
        }
    }
}

extension MainView.ContentView.LanguagesSelectionView {
    struct LanguagesSelectionButtonView: View {
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
    static let textEditorBackground = Color(UIColor.systemGray5)
}

#Preview {
    MainView.ContentView()
        .environmentObject(MainViewModel.arbitrary())
}
