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
            VStack(spacing: .vStackSpacing) {
                SkeletonBlock()
                SkeletonBlock()
            }
        }
    }
    
    struct SkeletonBlock: View {
        var body: some View {
            VStack {
                Skeleton()
                    .frame(height: .smallSkeletonHeight)
                    .padding(.trailing, .smallSkeletonTrailingPadding)
                    
                Skeleton()
                    .frame(height: .largeSkeletonHeight)
            }
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
    static let smallSkeletonHeight = 32.0
    static let smallSkeletonTrailingPadding = 100.0
    static let largeSkeletonHeight = 200.0
    static let vStackSpacing = 24.0
}

private extension Color {
    static let lightGray: Self = .gray.opacity(0.1)
}

#Preview {
    MainView.SkeletonView()
}

