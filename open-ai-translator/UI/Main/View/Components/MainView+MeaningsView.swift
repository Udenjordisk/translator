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
                ForEach(viewModel.meanings, id: \.self) { meaning in
                    VStack(alignment: .leading, spacing: .spacing4) {
                        Text(meaning.title)
                            .foregroundStyle(.black)
                            .fontWeight(.medium)
                        
                        Text(meaning.description)
                            .foregroundStyle(.gray)
                            .fontDesign(.serif)
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
