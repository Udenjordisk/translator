//
//  MainView+TextBlockItem.swift
//  open-ai-translator
//
//  Created by Кирилл Белашов  on 24.10.2024.
//

import SwiftUI

extension MainView.ContentView.InputView {
    struct TextBlockItem: View {
        @Binding var text: String
        @FocusState private var isFocused: Bool
        
        let placeholder: String?
        let isEditable: Bool
        let buttonIconName: String
        let buttonAction: () -> Void
        
        init(
            text: Binding<String>,
            placeholder: String? = nil,
            isEditable: Bool = true,
            buttonIconName: String,
            buttonAction: @escaping () -> Void
        ) {
            _text = text
            self.placeholder = placeholder
            self.isEditable = isEditable
            self.buttonIconName = buttonIconName
            self.buttonAction = buttonAction
        }
        
        var body: some View {
            VStack {
                ZStack(alignment: .topLeading) {
                    if let placeholder, text.isEmpty {
                        Text(placeholder)
                            .foregroundStyle(.gray)
                            .padding(.leading, .placeholderLeadingPadding)
                            .padding(.top, 12)
                    }
                    
                    HStack(alignment: .top) {
                        TextEditor(text: $text)
                            .onChange(of: text) { _, _ in
                                changeFocusStateIfNeeded()
                            }
                            .scrollContentBackground(.hidden)
                            .allowsHitTesting(isEditable)
                            .submitLabel(.done)
                            .focused($isFocused)
                        
                        if !text.isEmpty {
                            Button {
                                buttonAction()
                            } label: {
                                Image(systemName: buttonIconName)
                                    .fontWeight(.medium)
                                    .frame(width: 24.0, height: 24.0)
                                    .foregroundStyle(.gray)
                            }
                            .padding(.top, 4)
                        }
                    }
                    .padding(4)
                }
            }
            .padding(12)
        }
        
        /// `TextEditor` в SwiftUI не умеет нативно скрывать клавиатуру по нажатию на кнопку Done и чтобы
        ///  реализовать подходящее поведение была реализована проверка на переход на новую строку.
        ///
        ///  Это работает, потому что `TextEditor` при тапе на кнопку Done переходит на новую строку
        func changeFocusStateIfNeeded() {
            if text.last?.isNewline == .some(true) {
                text.removeLast()
                isFocused = false
            }
        }
    }
}

private extension CGFloat {
    static let placeholderLeadingPadding: CGFloat = 9.0
}
