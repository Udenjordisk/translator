//
//  MainView+TextInput.swift
//  open-ai-translator
//
//  Created by Кирилл Белашов  on 24.10.2024.
//

import SwiftUI

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
                        buttonIconName: .closeIcon,
                        buttonAction: {
                            viewModel.clear()
                        }
                    )
                    
                    if !viewModel.translatedText.isEmpty {
                        Divider()
                            .padding(12)
                        
                        InputBlock(
                            text: $viewModel.translatedText,
                            buttonIconName: .copyIcon,
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
//                HStack {
//                    if let originalLanguage {
//                        Text(originalLanguage)
//                            .fontWeight(.bold)
//                            .foregroundStyle(Color(UIColor.systemBlue))
//                        
//                    } else {
//                        Spacer()
//                    }
//                    
//                    Button {
//                        buttonAction()
//                    } label: {
//                        Image(systemName: buttonIconName)
//                            .frame(width: 24.0, height: 24.0)
//                            .foregroundStyle(.gray)
//                    }
//                }
                ZStack(alignment: .topLeading) {
                    if text.isEmpty {
                        Text("Начните вводить текст для перевода...")
                            .foregroundColor(.gray)
                            .padding(.leading, .placeholderLeadingPadding)
                            .padding(.top, 12)
                    }
                    
                    // TextEditor
                    TextEditor(text: $text)
                        .scrollContentBackground(.hidden)
                        .padding(4)
                    
                }
            }
            .padding(12)
        }
    }
}

private extension String {
    static let closeIcon = "xmark"
    static let copyIcon = "document.on.document"
}

private extension CGFloat {
    static let placeholderLeadingPadding: CGFloat = 9.0
}

private extension Color {
    static let textEditorBackground = Color(UIColor.systemGray5)
}
