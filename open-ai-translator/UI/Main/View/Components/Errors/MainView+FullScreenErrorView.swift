//
//  MainView+FullScreenErrorView.swift
//  open-ai-translator
//
//  Created by Кирилл Белашов  on 25.10.2024.
//

import SwiftUI

extension MainView {
    struct FullScreenErrorView: View {
        @EnvironmentObject var viewModel: MainViewModel
        
        var body: some View {
            VStack(alignment: .center, spacing: .spacing24) {
                Spacer()
                
                Image(systemName: "exclamationmark.icloud.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: .imageHeight)
                    .foregroundStyle(.yellow)
                    .symbolRenderingMode(.multicolor)
                
                Text("Упс...")
                    .font(.system(size: .spacing48))
                    .fontWeight(.bold)

                Text("Что-то пошло не так. Попробуйте позже через некоторое время.")
                    .font(.system(size: .spacing24))
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
                
                Button {
                    Task { await viewModel.viewWillAppear() }
                } label: {
                    Text("Попробовать еще раз")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .padding(.spacing12)
                        .background(Color.blue)
                        .cornerRadius(.spacing8)
                        .padding(.horizontal, .spacing16)
                }
                
                Spacer()
            }
        }
    }
}

private extension CGFloat {
    static let imageHeight = 150.0
}
