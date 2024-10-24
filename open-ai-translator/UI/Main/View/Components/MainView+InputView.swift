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
        
        private var isNeedToShowSecondLevel: Bool {
            !viewModel.translatedText.isEmpty || !viewModel.sourceText.isEmpty && viewModel.isTranslationError
        }
        
        var body: some View {
            VStack(alignment: .center, spacing: .zero) {
                TextBlockItem(
                    text: $viewModel.sourceText,
                    placeholder: "Начните вводить текст здесь...",
                    buttonIconName: .closeIcon,
                    buttonAction: {
                        viewModel.clear()
                    }
                )
                .frame(height: .textEditorHeight)
                
                if isNeedToShowSecondLevel {
                    Divider()
                        .padding(12)
                    
                    if viewModel.isTranslationError {
                        TranslationErrorView()
                            .padding(.vertical, 12)
                    } else {
                        TextBlockItem(
                            text: $viewModel.translatedText,
                            isEditable: false,
                            buttonIconName: .copyIcon,
                            buttonAction: {
                                viewModel.copy()
                            }
                        )
                        .frame(height: .textEditorHeight)
                    }
                }
            }
            .background(Color.textEditorBackground)
            .cornerRadius(12)
        }
    }
}

extension MainView.ContentView.InputView {
    struct TranslationErrorView: View {
        @EnvironmentObject var viewModel: MainViewModel

        var body: some View {
            VStack(alignment: .center, spacing: 8) {
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
                        .padding(.horizontal, 16)
                }
            }
        }
    }
}

private extension String {
    static let closeIcon = "xmark"
    static let copyIcon = "document.on.document"
}

private extension Color {
    static let textEditorBackground = Color(UIColor.systemGray5)
}

private extension CGFloat {
    static let textEditorHeight: CGFloat = 150.0
}
