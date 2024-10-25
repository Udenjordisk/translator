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
            VStack(alignment: .leading, spacing: .zero) {
                TextBlockItem(
                    text: $viewModel.sourceText,
                    placeholder: "Начните вводить текст здесь...",
                    buttonIconName: .closeIcon,
                    buttonAction: {
                        viewModel.clear()
                    }
                )
                .frame(height: .textEditorHeight)
                
                if viewModel.translationState != .empty {
                    Divider()
                        .padding(.spacing12)
                }
                
                switch viewModel.translationState {
                case .empty:
                    EmptyView()
                    
                case .loading:
                    HStack {
                        Spacer()
                        
                        ProgressView()
                            .progressViewStyle(.circular)
                            .padding(.vertical, .spacing16)
                        
                        Spacer()
                    }
                   
                case .content:
                    TextBlockItem(
                        text: $viewModel.translatedText,
                        isEditable: false,
                        buttonIconName: .copyIcon,
                        buttonAction: {
                            viewModel.copy()
                        }
                    )
                    .frame(height: .textEditorHeight)
                    
                    if viewModel.isTranscriptionEnabled, let transcription = viewModel.transcription {
                        Text(transcription)
                            .foregroundStyle(.gray)
                            .fontDesign(.serif)
                            .font(.system(size: 14))
                            .padding(.horizontal, .spacing16)
                            .padding(.bottom, .spacing12)
                    }
                    
                case .error:
                    TranslationErrorView()
                        .padding(.vertical, .spacing16)
                }
            }
            .background(Color.textEditorBackground)
            .cornerRadius(.spacing12)
        }
    }
}

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

private extension String {
    static let closeIcon = "xmark"
    static let copyIcon = "document"
}

private extension Color {
    static let textEditorBackground = Color(UIColor.systemGray5)
}

private extension CGFloat {
    static let textEditorHeight: CGFloat = 150.0
}
