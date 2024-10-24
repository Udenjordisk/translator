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
            VStack(spacing: .spacing24) {
                Skeleton()
                    .frame(height: .inputSkeletonHeight)
                    
                Skeleton()
                    .frame(height: .spacing32)
            }
            .padding(.horizontal, .spacing16)
        }
    }
    
    struct Skeleton: View {
        var body: some View {
            Rectangle()
                .fill(Color.lightGray)
                .cornerRadius(.spacing12)
        }
    }
}

private extension CGFloat {
    static let inputSkeletonHeight = 150.0
}

private extension Color {
    static let lightGray: Self = .gray.opacity(0.1)
}

#Preview {
    MainView.SkeletonView()
}

