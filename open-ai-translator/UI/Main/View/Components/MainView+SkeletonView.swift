//
//  View.swift
//  open-ai-translator
//
//  Created by Кирилл Белашов  on 23.10.2024.
//

import SwiftUI

extension MainView {
    struct SkeletonView: View {
        var body: some View {
            VStack(spacing: 24) {
                Skeleton()
                    .frame(height: .inputSkeletonHeight)
                    
                Skeleton()
                    .frame(height: .languageSelectSkeletonHeight)
            }
            .padding(.horizontal, 16)
        }
    }
    
    struct Skeleton: View {
        var body: some View {
            Rectangle()
                .fill(Color.lightGray)
                .cornerRadius(.cornerRadius)
        }
    }
}

private extension CGFloat {
    static let cornerRadius = 12.0
    static let inputSkeletonHeight = 150.0
    static let languageSelectSkeletonHeight = 32.0
}

private extension Color {
    static let lightGray: Self = .gray.opacity(0.1)
}

#Preview {
    MainView.SkeletonView()
}

