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
            VStack(alignment: .center, spacing: .zero) {
                TextBlockItem(
                    text: $viewModel.sourceText,
                    placeholder: "Начните вводить текст здесь...",
                    buttonIconName: .closeIcon,
                    buttonAction: {
                        viewModel.clear()
                    }
                )
                .frame(height: 150)
                
                if !viewModel.translatedText.isEmpty {
                    Divider()
                        .padding(12)
                    
                    TextBlockItem(
                        text: $viewModel.translatedText,
                        isEditable: false,
                        buttonIconName: .copyIcon,
                        buttonAction: {
                            viewModel.copy()
                        }
                    )
                    .frame(height: 150)
                }
            }
            .background(Color.textEditorBackground)
            .cornerRadius(12)
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
