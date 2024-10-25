//
//  MainView+MeaningsView.swift
//  open-ai-translator
//
//  Created by Кирилл Белашов  on 25.10.2024.
//

import SwiftUI

extension MainView.ContentView {
    struct MeaningsView: View {
        @EnvironmentObject var viewModel: MainViewModel

        var body: some View {
            if !viewModel.meanings.isEmpty {
                VStack(alignment: .leading, spacing: .spacing4) {
                    ForEach(viewModel.meanings, id: \.self) { meaning in
                        VStack(alignment: .leading, spacing: .spacing4) {
                            Text(meaning.title)
                                .foregroundStyle(.black)
                                .fontWeight(.medium)
                                .font(.title)

                            Text(meaning.description)
                                .foregroundStyle(.gray)
                                .fontDesign(.serif)
                                .font(.description)
                                .lineLimit(nil)
                                .fixedSize(horizontal: false, vertical: true)
                            
                            if viewModel.meanings.count > 1, meaning != viewModel.meanings.last {
                                Divider()
                            }
                        }
                    }
                }
            }
        }
    }
}

private extension Font {
    static let title = Self.system(size: 16.0)
    static let description = Self.system(size: 14.0)
}
