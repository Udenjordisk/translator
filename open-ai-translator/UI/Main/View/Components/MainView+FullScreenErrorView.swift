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
            VStack(alignment: .center, spacing: 24) {
                Spacer()
                
                Image(systemName: "exclamationmark.icloud.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
                    .foregroundStyle(.yellow)
                    .symbolRenderingMode(.multicolor)
                
                Text("Упс...")
                    .font(.system(size: 48))
                    .fontWeight(.bold)

                Text("Что-то пошло не так. Попробуйте позже через некоторое время.")
                    .font(.system(size: 24))
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
                        .padding(12.0)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .padding(.horizontal, 16)
                }
                
                Spacer()
            }
        }
    }
}
